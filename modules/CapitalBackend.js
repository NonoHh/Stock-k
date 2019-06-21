var transaction = require('./transaction');

class CapitalBackend {
    /*----------------------------------------Database Operation--------------------------------- */
    static connectDatabase(host, user, password, database) {
        var mysql = require('mysql');
        this.connection = mysql.createConnection({
            host: host,
            user: user,
            password: password,
            database: database,
        });

        this.connection.connect();
        console.log('Connect Success');
    }

    static disConnectDatabase() {
        this.connection.end();
    }

    static createTable() { //create a table
        this.connection.query('create table capital_account(account_id int primary key auto_increment, user_id int, account_balance decimal(10,2),account_state char(32),password_hash char(64), frozen decimal(10,2));', function (err, results, fields) {
            if (err) {
                // console.log(err.message);
            } else {
                console.log('Initialization Success');
            }
        });
    }

    static createAccount(stock_id, password) {
        const crypto = require('crypto');
        var obj = crypto.createHash('sha256');
        obj.update(password);
        var hash = obj.digest('hex'); //hex是十六进制
        obj.end();
        return new Promise((resolve, reject) => {
            this.connection.query(`insert into capital_account values(null, ${stock_id}, 100000, \'normal\', \'${hash}\', 0)`, function (err, results, fields) {
                if (err) {
                    // console.log(err)
                    resolve({'code': -1, 'msg': '创建失败'})
                } else {
                    // console.log(results)
                    resolve({'code': 0, 'msg': '创建成功', 'id': results.insertId})
                }
            });
        })
    }

    static deleteAccount(ID, password) {
        const crypto = require('crypto');
        var obj = crypto.createHash('sha256');
        obj.update(password);
        var hash = obj.digest('hex'); //hex是十六进制
        obj.end();
        return new Promise((resolve, reject) => {
            this.connection.query(`select password_hash from capital_account where account_id=${ID};`, function (err, results, fields) {
                if (err || results.length == 0) {
                    resolve({'code': -1, 'msg': '注销失败'})
                } else {
                    if (results[0]['password_hash'] == hash) {
                        CapitalBackend.connection.query(`delete from capital_account where account_id=${ID};`, function (err, results, fields) {
                            if (err) {
                                resolve({'code': -1, 'msg': '注销失败'})
                            } else {
                                resolve({'code': 0, 'msg': '注销成功'})
                            }
                        });
                    } else {
                        resolve({'code': -1, 'msg': '密码错误'})
                    }
                }
            });
        })
    }

    static deleteAllAccounts(ID) {
        return new Promise((resolve, reject) => {
            CapitalBackend.connection.query(`delete from capital_account where user_id=${ID};`, function (err, results, fields) {
                if (err) {
                    resolve(false)
                } else {
                    resolve(true)
                }
            });
        })
    }

    static restoreStock(old_id, new_id) {
        return new Promise((resolve, reject) => {
            CapitalBackend.connection.query(`update capital_account set user_id=${new_id} where user_id=${old_id};`, function (err, results, fields) {
                if (err) {
                    resolve(false)
                } else {
                    resolve(true)
                }
            });
        })
    }

    static updatePassword(ID, oldpass, newpass) {
        const crypto = require('crypto');
        var obj = crypto.createHash('sha256');
        obj.update(oldpass);
        var oldhash = obj.digest('hex');
        obj = crypto.createHash('sha256');
        obj.update(newpass);
        var newhash = obj.digest('hex');
        obj.end();

        return new Promise((resolve, reject) => {
            this.connection.query(`select password_hash from capital_account where account_id=${ID};`, function (err, results, fields) {
                if (err || results.length == 0) {
                    console.log(err);
                    resolve({'code': -1, 'msg': '修改失败'})
                } else {
                    if (results[0]['password_hash'] == oldhash) {
                        CapitalBackend.connection.query(`update capital_account set password_hash=\'${newhash}\' where account_id=${ID};`, function (err, results, fields) {
                            if (err) {
                                resolve({'code': -1, 'msg': '修改失败'})
                            } else {
                                resolve({'code': 0, 'msg': '修改成功'})
                            }
                        });
                    } else {
                        resolve({'code': -1, 'msg': '密码错误'})
                    }
                }
            });
        })
    }

    static restoreAccount(ID, password) {
        const crypto = require('crypto');
        var obj = crypto.createHash('sha256');
        obj.update(password);
        var hash = obj.digest('hex'); //hex是十六进制
        obj.end();
        return new Promise((resolve, reject) => {
            CapitalBackend.connection.query(`update capital_account set password_hash = \'${hash}\', account_id=(select t.id from (select max(account_id) as id from capital_account) t)+1 where account_id=${ID};`, function (err, results, fields) {
                if (err || results.affectedRows == 0) {
                    resolve({'code': -1, 'msg': '挂失失败'})
                } else {
                    CapitalBackend.connection.query(`select max(account_id) from capital_account;`, function (err, results, fields) {
                        if (err) {
                            resolve({'code': -1, 'msg': '挂失失败'})
                        } else {
                            // console.log(results)
                            resolve({'code': 0, 'msg': '挂失成功', 'id': results[0]['max(account_id)']})
                        }
                    });


                }
            });
        });
    }

    static checkBalance(ID, amount) {
        return new Promise((resolve, reject) => {
            CapitalBackend.connection.query(`select account_balance from capital_account where account_id=${ID};`, function (err, results, fields) {
                if (err || results.length == 0) {
                    resolve("fail")
                } else {
                    if (results[0]['account_balance'] >= amount) {
                        resolve('sufficient')
                    } else {
                        resolve("insufficient")
                    }
                }
            });


        });
    }

    static addBalance(ID, amount) { //flag = add or subtract
        console.log(amount);
        return new Promise((resolve, reject) => {
            this.connection.query(`update capital_account set account_balance = account_balance+${amount} where account_id=${ID};`, function (err, results, fields) {
                if (err) {
                    resolve(false)
                } else {
                    resolve(true)
                }
            });
        })
    }

    static getAllAcounts(stock_id) {
        return new Promise((resolve, reject) => {
            CapitalBackend.connection.query(`select account_id, account_balance, frozen from capital_account where user_id =${stock_id};`, function (err, results, fields) {
                if (err || results.length == 0) {
                    // console.log(err)
                    resolve({'code': -1, 'msg': '查询失败'})
                } else {
                    var result = new Array()
                    // console.log(results)
                    // results.array.forEach(element => {
                    //     result.
                    // });
                    JSON.parse(JSON.stringify(results)).forEach(element => {
                        result.push({
                            'id': element.account_id,
                            'available': element.account_balance,
                            'frozen': element.frozen
                        })
                    });
                    resolve({'code': 0, 'data': result})
                }
            })
        })
    }

    static create_buy(buyer_id, stock_id, password, price, total) {
        const crypto = require('crypto');
        var obj = crypto.createHash('sha256');
        obj.update(password);
        var hash = obj.digest('hex');


        return new Promise((resolve, reject) => {
            this.connection.query(`select password_hash, account_balance from capital_account where account_id=${buyer_id};`, function (err, results, fields) {
                if (err || results.length == 0) {
                    console.log(err)
                    resolve({'code': -1, 'msg': '创建失败'})
                } else {
                    if (results[0]['password_hash'] == hash) {
                        var money = price * total;
                        if (results[0]['account_balance'] >= money) {
                            transaction.add_buy(buyer_id, stock_id, price, total, function (success, id) {
                                if (success) {
                                    console.log(money);
                                    CapitalBackend.connection.query(`update capital_account set account_balance=account_balance-${money}, frozen=frozen+${money} where account_id= ${buyer_id};`, function (err, results, fields) {
                                        if (err) {
                                            resolve({'code': -1, 'msg': '创建失败'});
                                        } else {
                                            resolve({'code': 0, 'msg': '创建成功'});
                                        }
                                    })
                                } else
                                    resolve({'code': -1, 'msg': '创建失败'});
                            })
                            // resolve({ 'code': 0, 'msg': '创建成功' })
                        } else {
                            resolve({'code': -1, 'msg': '余额不足'})
                        }
                    } else {
                        resolve({'code': -1, 'msg': '密码错误'})
                    }
                }
            });
        })
    }

    static delete_buy(buyer_id, buy_id, password) {
        const crypto = require('crypto');
        var obj = crypto.createHash('sha256');
        obj.update(password);
        var hash = obj.digest('hex');

        return new Promise((resolve, reject) => {
            this.connection.query(`select password_hash, account_balance from capital_account where account_id=${buyer_id};`, function (err, results, fields) {
                if (err || results.length == 0) {
                    console.log(err)
                    resolve({'code': -1, 'msg': '撤销失败'})
                } else {
                    if (results[0]['password_hash'] == hash) {
                        transaction.cancel_buy(buy_id, function (success) {
                            if (success) {
                                resolve({'code': 0, 'msg': '撤销成功'})
                            } else {
                                resolve({'code': -1, 'msg': '撤销失败'})
                            }
                        })
                    } else {
                        resolve({'code': -1, 'msg': '密码错误'})
                    }
                }
            });
        })
    }

    static create_sell(seller_id, stock_id, password, price, total) {
        const crypto = require('crypto');
        var obj = crypto.createHash('sha256');
        obj.update(password);
        var hash = obj.digest('hex');


        return new Promise((resolve, reject) => {
            this.connection.query(`select password_hash, account_balance from capital_account where account_id=${seller_id};`, function (err, results, fields) {
                if (err || results.length == 0) {
                    console.log(err)
                    resolve({'code': -1, 'msg': '创建失败'})
                } else {
                    if (results[0]['password_hash'] == hash) {
                        transaction.add_sell(seller_id, stock_id, price, total, function (success, id) {
                            if (success)
                                resolve({'code': 0, 'msg': '创建成功'})
                            else
                                resolve({'code': -1, 'msg': '创建失败'})
                        })
                    } else {
                        resolve({'code': -1, 'msg': '密码错误'})
                    }
                }
            });
        })
    }

    static delete_sell(seller_id, sell_id, password) {
        const crypto = require('crypto');
        var obj = crypto.createHash('sha256');
        obj.update(password);
        var hash = obj.digest('hex');


        return new Promise((resolve, reject) => {
            this.connection.query(`select password_hash, account_balance from capital_account where account_id=${seller_id};`, function (err, results, fields) {
                if (err || results.length == 0) {
                    console.log(err)
                    resolve({'code': -1, 'msg': '撤销失败'})
                } else {
                    if (results[0]['password_hash'] == hash) {
                        transaction.cancel_sell(sell_id, function (success, amount) {
                            if (success) {
                                CapitalBackend.connection.query(`update capital_account set account_balance=account_balance+${amount} where account_id= ${seller_id};`, function (err, results, fields) {
                                    if (err) {
                                        resolve({'code': 0, 'msg': '撤销成功'});
                                    } else {
                                        resolve({'code': -1, 'msg': '撤销失败'});
                                    }
                                })
                            } else
                                resolve({'code': -1, 'msg': '撤销失败'})
                        })
                        // resolve({ 'code': 0, 'msg': '撤销成功' })
                    } else {
                        resolve({'code': -1, 'msg': '密码错误'})
                    }
                }
            });
        })
    }

    static freezeBalance(account_id, amount) {
        var output = new Array()
        return new Promise((resolve, reject) => {
            CapitalBackend.connection.query(`update capital_account set account_balance=account_balance-${amount}, frozen=frozen+${amount} where account_id= ${account_id};`, function (err, results, fields) {
                if (err || results.length == 0) {
                    resolve(false)
                } else {
                    resolve(true)
                }
            })
        })
    }

    static unfreezeBalance(account_id, amount) {
        var output = new Array()
        return new Promise((resolve, reject) => {
            CapitalBackend.connection.query(`update capital_account set account_balance=account_balance+${amount}, frozen=frozen-${amount} where account_id= ${account_id};`, function (err, results, fields) {
                if (err || results.length == 0) {
                    resolve(false)
                } else {
                    resolve(true)
                }
            })
        })
    }

    static deductFrozen(account_id, amount) {
        console.log('run');
        return new Promise((resolve, reject) => {
            CapitalBackend.connection.query(`update capital_account set frozen=frozen-${amount} where account_id= ${account_id};`, function (err, results, fields) {
                if (err || results.length == 0) {
                    resolve('fail')
                } else {
                    resolve('success')
                }
            })
        })
    }

    /* -----------------------------------------init-------------------------------------------- */
    static init(host, user, password, database) {
        this.connectDatabase(host, user, password, database)
        this.createTable()

        function calcInterest() {
            var today = new Date();
            if (today.getDate() == 30 && today.getMonth() == 5) { //六月三十日增加利息
                CapitalBackend.connection.query(`update capital_account set account_balance=account_balance*1.02;`, function (err, results, fields) {
                    if (err) {
                        console.log(err)
                    }
                })
            }

        }

        var interval = setInterval(calcInterest, 86400000)

    }
}

CapitalBackend.init('localhost', 'root', 'password', 'capitalaccount')

async function creatAcc(stock_id, password) {
    console.log(await CapitalBackend.createAccount(stock_id, password))
}

// creatAcc(123, "1234")


async function changePass(account_id, ori_pass, new_pass) {
    console.log(await CapitalBackend.updatePassword(account_id, ori_pass, new_pass))
}

// changePass(8, '123', '1234')

async function deleteAcc(account_id, password) {
    console.log(await CapitalBackend.deleteAccount(account_id, password))
}

// deleteAcc(15, '1234')

async function restoreAcc(account_id, new_pass) {
    console.log(await CapitalBackend.restoreAccount(account_id, new_pass))
}

// restoreAcc(30, '123')

async function getAccs(stock_id) {
    console.log(await CapitalBackend.getAllAcounts(stock_id))
}

// getAccs(12)

async function deleteAll(stock_id) {
    console.log(await CapitalBackend.deleteAllAccounts(stock_id))
}

// deleteAll(12)

async function restoreSto(old_id, new_id) {
    console.log(await CapitalBackend.restoreStock(old_id, new_id))
}

// restoreSto('123', '12')

async function createBuy(buyer_id, stock_id, password, price, total) {
    console.log(await CapitalBackend.create_buy(buyer_id, stock_id, password, price, total))
}

// createBuy(31, 12, '1234', 100, 10000)

async function deleteSell(seller_id, sell_id, password) {
    console.log(await CapitalBackend.delete_sell(seller_id, sell_id, password))
}

// deleteSell(31, 1234, '1234')

async function freezeBal(account_id, amount) {
    console.log(await CapitalBackend.freezeBalance(account_id, amount))
}

// freezeBal(31, 10000)

async function unfreezeBal(account_id, amount) {
    console.log(await CapitalBackend.unfreezeBalance(account_id, amount))
}

// unfreezeBal(31, 10000)

exports.capital = CapitalBackend;