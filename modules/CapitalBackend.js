var transaction = require('./transaction');
var mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'stock'
});

/*----------------------------------------Database Operation--------------------------------- */
function connectDatabase(host, user, password, database) {
    connection.connect();
    console.log('Connect Success');
}

function disConnectDatabase() {
    connection.end();
}

function createTable() { //create a table
    connection.query('create table capital_account(account_id int primary key auto_increment, user_id int, account_balance decimal(10,2),account_state char(32),password_hash char(64), frozen decimal(10,2));', function (err, results, fields) {
        if (err) {
            // console.log(err.message);
        } else {
            console.log('Initialization Success');
        }
    });
}

exports.createAccount = createAccount;

function createAccount(stock_id, password) {
    const crypto = require('crypto');
    var obj = crypto.createHash('sha256');
    obj.update(password);
    var hash = obj.digest('hex'); //hex是十六进制
    obj.end();
    return new Promise((resolve, reject) => {
        connection.query(`insert into capital_account values(null, ${stock_id}, 100000, \'normal\', \'${hash}\', 0)`, function (err, results, fields) {
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

exports.deleteAccount = deleteAccount;

function deleteAccount(ID, password) {
    const crypto = require('crypto');
    var obj = crypto.createHash('sha256');
    obj.update(password);
    var hash = obj.digest('hex'); //hex是十六进制
    obj.end();
    return new Promise((resolve, reject) => {
        connection.query(`select password_hash from capital_account where account_id=${ID};`, function (err, results, fields) {
            if (err || results.length == 0) {
                resolve({'code': -1, 'msg': '注销失败'})
            } else {
                if (results[0]['password_hash'] == hash) {
                    connection.query(`delete from capital_account where account_id=${ID};`, function (err, results, fields) {
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

exports.deleteAllAccounts = deleteAllAccounts;

function deleteAllAccounts(ID) {
    return new Promise((resolve, reject) => {
        connection.query(`delete from capital_account where user_id=${ID};`, function (err, results, fields) {
            if (err) {
                resolve(false)
            } else {
                resolve(true)
            }
        });
    })
}

exports.restoreStock = restoreStock;

function restoreStock(old_id, new_id) {
    return new Promise((resolve, reject) => {
        connection.query(`update capital_account set user_id=${new_id} where user_id=${old_id};`, function (err, results, fields) {
            if (err) {
                resolve(false)
            } else {
                resolve(true)
            }
        });
    })
}

exports.updatePassword = updatePassword;

function updatePassword(ID, oldpass, newpass) {
    const crypto = require('crypto');
    var obj = crypto.createHash('sha256');
    obj.update(oldpass);
    var oldhash = obj.digest('hex');
    obj = crypto.createHash('sha256');
    obj.update(newpass);
    var newhash = obj.digest('hex');
    obj.end();

    return new Promise((resolve, reject) => {
        connection.query(`select password_hash from capital_account where account_id=${ID};`, function (err, results, fields) {
            if (err || results.length == 0) {
                console.log(err);
                resolve({'code': -1, 'msg': '修改失败'})
            } else {
                if (results[0]['password_hash'] == oldhash) {
                    connection.query(`update capital_account set password_hash=\'${newhash}\' where account_id=${ID};`, function (err, results, fields) {
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

exports.restoreAccount = restoreAccount;

function restoreAccount(ID, password) {
    const crypto = require('crypto');
    var obj = crypto.createHash('sha256');
    obj.update(password);
    var hash = obj.digest('hex'); //hex是十六进制
    obj.end();
    return new Promise((resolve, reject) => {
        connection.query(`update capital_account set password_hash = \'${hash}\', account_id=(select t.id from (select max(account_id) as id from capital_account) t)+1 where account_id=${ID};`, function (err, results, fields) {
            if (err || results.affectedRows == 0) {
                resolve({'code': -1, 'msg': '挂失失败'})
            } else {
                connection.query(`select max(account_id) from capital_account;`, function (err, results, fields) {
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

exports.checkBalance = checkBalance;

function checkBalance(ID, amount) {
    return new Promise((resolve, reject) => {
        connection.query(`select account_balance from capital_account where account_id=${ID};`, function (err, results, fields) {
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

exports.addBalance = addBalance;

function addBalance(ID, amount) { //flag = add or subtract
    console.log(amount);
    return new Promise((resolve, reject) => {
        connection.query(`update capital_account set account_balance = account_balance+${amount} where account_id=${ID};`, function (err, results, fields) {
            if (err) {
                resolve(false)
            } else {
                resolve(true)
            }
        });
    })
}

exports.getAllAcounts = getAllAcounts;

function getAllAcounts(stock_id) {
    return new Promise((resolve, reject) => {
        connection.query(`select account_id, account_balance, frozen from capital_account where user_id =${stock_id};`, function (err, results, fields) {
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

exports.create_buy = create_buy;

function create_buy(buyer_id, stock_id, password, price, total) {
    const crypto = require('crypto');
    var obj = crypto.createHash('sha256');
    obj.update(password);
    var hash = obj.digest('hex');


    return new Promise((resolve, reject) => {
        connection.query(`select password_hash, account_balance from capital_account where account_id=${buyer_id};`, function (err, results, fields) {
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
                                connection.query(`update capital_account set account_balance=account_balance-${money}, frozen=frozen+${money} where account_id= ${buyer_id};`, function (err, results, fields) {
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

exports.delete_buy = delete_buy;

function delete_buy(buyer_id, buy_id, password) {
    const crypto = require('crypto');
    var obj = crypto.createHash('sha256');
    obj.update(password);
    var hash = obj.digest('hex');

    return new Promise((resolve, reject) => {
        connection.query(`select password_hash, account_balance from capital_account where account_id=${buyer_id};`, function (err, results, fields) {
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

exports.create_sell = create_sell;

function create_sell(seller_id, stock_id, password, price, total) {
    const crypto = require('crypto');
    var obj = crypto.createHash('sha256');
    obj.update(password);
    var hash = obj.digest('hex');


    return new Promise((resolve, reject) => {
        connection.query(`select password_hash, account_balance from capital_account where account_id=${seller_id};`, function (err, results, fields) {
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

exports.delete_sell = delete_sell;

function delete_sell(seller_id, sell_id, password) {
    const crypto = require('crypto');
    var obj = crypto.createHash('sha256');
    obj.update(password);
    var hash = obj.digest('hex');


    return new Promise((resolve, reject) => {
        connection.query(`select password_hash, account_balance from capital_account where account_id=${seller_id};`, function (err, results, fields) {
            if (err || results.length == 0) {
                console.log(err)
                resolve({'code': -1, 'msg': '撤销失败'})
            } else {
                if (results[0]['password_hash'] == hash) {
                    transaction.cancel_sell(sell_id, function (success, amount) {
                        if (success) {
                            connection.query(`update capital_account set account_balance=account_balance+${amount} where account_id= ${seller_id};`, function (err, results, fields) {
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

exports.freezeBalance = freezeBalance;

function freezeBalance(account_id, amount) {
    var output = new Array()
    return new Promise((resolve, reject) => {
        connection.query(`update capital_account set account_balance=account_balance-${amount}, frozen=frozen+${amount} where account_id= ${account_id};`, function (err, results, fields) {
            if (err || results.length == 0) {
                resolve(false)
            } else {
                resolve(true)
            }
        })
    })
}

exports.unfreezeBalance = unfreezeBalance;

function unfreezeBalance(account_id, amount) {
    var output = new Array()
    return new Promise((resolve, reject) => {
        connection.query(`update capital_account set account_balance=account_balance+${amount}, frozen=frozen-${amount} where account_id= ${account_id};`, function (err, results, fields) {
            if (err || results.length == 0) {
                resolve(false)
            } else {
                resolve(true)
            }
        })
    })
}

exports.deductFrozen = deductFrozen;

function deductFrozen(account_id, amount) {
    console.log('run');
    return new Promise((resolve, reject) => {
        connection.query(`update capital_account set frozen=frozen-${amount} where account_id= ${account_id};`, function (err, results, fields) {
            if (err || results.length == 0) {
                resolve('fail')
            } else {
                resolve('success')
            }
        })
    })
}

exports.init = init;

/* -----------------------------------------init-------------------------------------------- */
function init(host, user, password, database) {
    connectDatabase(host, user, password, database);
    createTable();

    function calcInterest() {
        var today = new Date();
        if (today.getDate() == 30 && today.getMonth() == 5) { //六月三十日增加利息
            connection.query(`update capital_account set account_balance=account_balance*1.02;`, function (err, results, fields) {
                if (err) {
                    console.log(err)
                }
            })
        }
    }

    var interval = setInterval(calcInterest, 86400000)
}
