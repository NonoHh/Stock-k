function account_err_account_not_found() {
    return {
        "code": -1,
        "msg": "account not found"
    };
}

function account_err_password_not_matched() {
    return {
        "code": -1,
        "msg": "password not matched"
    };
}

function account_err_account_existed() {
    return {
        "code": -1,
        "msg": "account existed"
    };
}

function account_err_initialization_failed(err) {
    return {
        "code": -1,
        "msg": "initialization failed",
        "err": err
    };
}

function account_err_capital_account_not_satisfied() {
    return {
        "code": -1,
        "msg": "capital account not satisfied"
    };
}

function account_err_syntax_err(err) {
    return {
        "code": -1,
        "msg": "syntax error",
        "err": err
    }
}

// function account_err_account_status_not_matched(){
//     return{
//         "code": -1,
//         "msg": "account status not matched"
//     };
// }

function admin_account_return_data(uid, name) {
    return {
        "code": 0,
        "data": {
            "user_id": uid,
            "name": name
        }
    };
}

function account_return_data(uid, name, type, acc_type) {
    return {
        "code": 0,
        "data": {
            "user_id": uid,
            "name": name,
            "type": type,
            "acc_type": acc_type
        }
    };
}

function account_info_return_data(uid, info) {
    return {
        "code": 0,
        "data": {
            "user_id": uid,
            "info": info
        }
    }
}

function request_success() {
    return {
        "code": 0
    }
}

function insert_account(name, acc_type, password) {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("INSERT INTO account VALUES(0,?,?,0,?);", [name, password, acc_type], (err) => {
            if (err)
                reject(account_err_account_existed(err));
            else
                resolve(name);
        });
    });
}

function insert_account_info(uid, acc_type, info) {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        if (acc_type == 0) {
            db.query("INSERT INTO account_info_0 VALUES(?,?,?,?,?,?,?,?,?);", [
                uid,
                info.name,
                info.ID,
                info.home_address,
                info.job,
                info.education_background,
                info.company_address,
                info.phone,
                info.agent_ID], (err) => {
                if (err)
                    reject(account_err_syntax_err(err));
                else
                    resolve();
            });
        } else {
            db.query("INSERT INTO account_info_1 VALUES(?,?,?,?,?,?,?,?,?,?,?);", [
                uid,
                info.corporate_number,
                info.license_number,
                info.representative_ID,
                info.representative_name,
                info.representative_phone,
                info.representative_address,
                info.operator_name,
                info.operator_ID,
                info.operator_phone,
                info.operator_address], (err) => {
                if (err)
                    reject(account_err_syntax_err(err));
                else
                    resolve();
            });
        }
    });
}

// function check_account_status(uid, status) { //get
//     return new Promise((resolve, reject) => {
//         db = account_database.get_database();
//         db.query("SELECT * FROM account WHERE uid=?;", [uid], (err, row) => {
//             if (err)
//                 reject(account_err_account_not_found(err));
//             else {
//                 if (row[0].status == status)
//                     resolve();
//                 else
//                     reject(account_err_account_status_not_matched());
//             }
//         });
//     });
// }

// function update_account_status(uid, status) {
//     return new Promise((resolve, reject) => {
//         db = account_database.get_database();
//         db.query("UPDATE account SET status=? where uid=?;", [status, uid], (err) => {
//             if (err)
//                 reject(account_err_account_not_found(err));
//             else
//                 resolve();
//         });
//     });
// }

// function get_account(uid, callback) {  //get
//
// }

function get_account_info(post_data, callback) {
    let uid = post_data.user_id;
    let db = account_database.get_database();
    db.query("SELECT * FROM account_info_0 WHERE uid=?;", [uid], (err, row) => {
        if (err)
            callback(account_err_syntax_err(err));
        else {
            let return_data;
            if (row[0]) {
                return_data = account_info_return_data(
                    uid,
                    {
                        "name": row[0].name,
                        "ID": row[0].ID,
                        "home_address": row[0].home_address,
                        "job": row[0].job,
                        "education_background": row[0].education_background,
                        "company_address": row[0].company_address,
                        "phone": row[0].phone,
                        "agent_ID": row[0].agent_ID,
                    }
                );
                callback(return_data);
            } else {
                db.query("SELECT * FROM account_info_1 WHERE uid=?;", [uid], (err, row) => {
                    if (err) {
                        callback(account_err_syntax_err(err));
                    } else {
                        if (row[0]) {
                            return_data = account_info_return_data(
                                uid,
                                {
                                    "corporate_number": row[0].corporate_number,
                                    "license_number": row[0].license_number,
                                    "representative_ID": row[0].representative_ID,
                                    "representative_name": row[0].representative_name,
                                    "representative_phone": row[0].representative_phone,
                                    "representative_address": row[0].representative_address,
                                    "operator_name": row[0].operator_name,
                                    "operator_ID": row[0].operator_ID,
                                    "operator_phone": row[0].operator_phone,
                                    "operator_address": row[0].operator_address,
                                }
                            );
                            callback(return_data);
                        }
                    }
                });
            }
        }

    });
}

// function handel_request(post_data, callback){
//     var data = JSON.parse(post_data);
//     var request = data.request;
//     var name = data.name;
//     var uid = data.user_id;
//     var password = data.password;
//     var acc_type = data.acc_type;
//     var info = data.info;

//     switch (request) {
//         case 'login':
//             login_account(name, password, callback);
//         break;
//         case 'register':
//             register_account(name, password, acc_type, info, callback);
//         break;
//         case 'update_password':
//             update_password(uid, password, callback);
//         case 'change':
//             change_account(uid, acc_type, info, callback);
//         break;
//         case 'raise':
//             raise_account(uid, callback);
//         break;
//         // case 'suspend':
//         //     suspend_account(uid, callback);
//         // break;
//         // case 'reapply':
//         //     reapply_account(uid, callback);
//         // break;
//         case 'suspend':
//             suspend_account(uid, callback);
//         break;
//         case 'cancel':
//             cancel_account(uid, callback);
//         break;
//         default:
//         break;
//     }
// }

function login_account(post_data, callback) {
    let data = post_data;
    let name = data.name;
    let password = data.password;
    new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("SELECT * FROM account WHERE name=?;", [name], (err, row) => {
            if (err)
                reject(account_err_syntax_err(err));
            else {
                if (row[0]) {
                    if (row[0].password == password)
                        resolve(account_return_data(row[0].uid, row[0].name, row[0].type, row[0].acc_type));
                    else
                        reject(account_err_password_not_matched());
                } else {
                    reject(account_err_account_not_found());
                }
            }
        })
    })
        .then((msg) => callback(msg))
        .catch((err) => callback(err))
}

function admin_login_account(post_data, callback) {
    let data = post_data;
    let name = data.name;
    let password = data.password;
    new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("SELECT * FROM admin_account WHERE name=?;", [name], (err, row) => {
            if (err)
                reject(account_err_syntax_err(err));
            else {
                if (row[0]) {
                    if (row[0].password == password)
                        resolve(admin_account_return_data(row[0].uid, row[0].name));
                    else
                        reject(account_err_password_not_matched());
                } else {
                    reject(account_err_account_not_found());
                }
            }
        })
    })
        .then((msg) => callback(msg))
        .catch((err) => callback(err))
}

function admin_get_account_by_name(post_data, callback) {
    let name = post_data.name;
    new Promise((resolve, reject) => {
        db.query("SELECT * FROM account WHERE name=?;", [name], (err, rows) => {
            if (err)
                reject(account_err_syntax_err(err));
            else {
                let return_data = {
                    code: 0,
                    data: []
                }
                for (row in rows) {
                    return_data.data.push(account_return_data(row.uid, row.name, row.type, row.acc_type).data);
                }
                resolve(return_data);
            }
        })
    })
        .then((msg) => callback(msg))
        .catch((err) => callback(err))
}

function admin_get_account_by_limit(post_data, callback) {
    let data = post_data;
    let limit = data.amount;
    let offset = data.offset;
    new Promise((resolve, reject) => {
        db.query("SELECT * FROM account LIMIT ?, ?;", [offset, limit], (err, rows) => {
            if (err)
                reject(account_err_syntax_err(err));
            else {
                let return_data = {
                    code: 0,
                    data: []
                };
                for (row in rows) {
                    return_data.data.push(account_return_data(row.uid, row.name, row.type, row.acc_type).data);
                }
                resolve(return_data);
            }
        })
    })
        .then((msg) => callback(msg))
        .catch((err) => callback(err))
}


function register_account(post_data, callback) {
    // let data = post_data;
    let data = post_data;
    let name = data.name;
    let password = data.password;
    let acc_type = data.acc_type;
    let info = JSON.parse(data.info);
    insert_account(name, acc_type, password)
        .then(() => get_uid(name))
        .then((uid) => insert_account_info(uid, acc_type, info))
        .then(() => callback(request_success()))
        .catch((err) => callback(err))
}

function change_account(post_data, callback) {
    let data = post_data;
    let uid = data.user_id;
    let acc_type = data.acc_type;
    let info = JSON.parse(data.info);
    let db = account_database.get_database();
    if (acc_type == 0) {
        db.query("UPDATE account_info_0 SET " +
            "name=?," +
            "ID=?" +
            "home_address=?" +
            "job=?" +
            "education_backgroud=?" +
            "company_address=?" +
            "phone=?" +
            "agent_ID=?" +
            "where uid=?;", [
            info.name,
            info.ID,
            info.home_address,
            info.job,
            info.education_background,
            info.company_address,
            info.phone,
            info.agent_ID,
            uid], (err) => {
            let return_data;
            if (err)
                return_data = account_err_syntax_err(err);
            else
                return_data = request_success();
            callback(return_data);
        });
    } else {
        db.query("UPDATE account_info_1 SET " +
            "corporate_number=?," +
            "license_number=?," +
            "representative_ID=?" +
            "representative_name=?" +
            "representative_phone=?" +
            "representative_address=?" +
            "operator_name=?" +
            "operator_ID=?" +
            "operator_phone=?" +
            "operator_address=?" +
            "where uid=?;", [
            info.corporate_number,
            info.license_number,
            info.representative_ID,
            info.representative_name,
            info.representative_phone,
            info.representative_address,
            info.operator_name,
            info.operator_ID,
            info.operator_phone,
            info.operator_address,
            uid], (err) => {
            let return_data;
            if (err)
                return_data = account_err_syntax_err(err);
            else
                return_data = request_success();
            callback(return_data);
        });
    }
}

function update_password(post_data, callback) {
    let data = post_data;
    let uid = data.user_id;
    let password = data.password;
    let db = account_database.get_database();
    db.query("UPDATE account SET password=? where uid=?;", [password, uid], (err) => {
        let return_data;
        if (err)
            return_data = account_err_syntax_err(err);
        else
            return_data = request_success();
        callback(return_data);
    });
}

function raise_account(post_data, callback) {
    let uid = post_data.user_id;
    let db = account_database.get_database();
    db.query("UPDATE account SET type=1 where uid=?;", [uid], (err) => {
        let return_data;
        if (err)
            return_data = account_err_syntax_err(err);
        else
            return_data = request_success();
        callback(return_data);
    });
}

function suspend_account_get_account(uid) {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("SELECT * FROM account WHERE uid=?;", [uid], (err, row) => {
            let return_data;
            if (err)
                reject(account_err_syntax_err(err));
            else {
                if (row[0]) {
                    return_data = {
                        user_id: uid,
                        name: row[0].name,
                        password: row[0].password,
                        type: row[0].type,
                        acc_type: row[0].acc_type
                    };
                    resolve(return_data);
                } else {
                    reject(account_err_account_not_found())
                }
            }
        });
    })
}

function suspend_account_update_account_info_0(old_uid, new_uid) {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("UPDATE account_info_0 SET uid=? WHERE uid = ?", [new_uid, old_uid], err => {
            if (err)
                reject(account_err_syntax_err(err));
            else
                resolve();
        })
    })
}

function suspend_account_update_account_info_1(old_uid, new_uid) {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("UPDATE account_info_1 SET uid=? WHERE uid = ?", [new_uid, old_uid], err => {
            if (err)
                reject(account_err_syntax_err(err));
            else
                resolve();
        })
    })
}

function get_uid(name) {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("SELECT uid FROM account WHERE name=?;", [name], (err, row) => {
            if (err)
                reject(account_err_syntax_err(err));
            else {
                if (row[0])
                    resolve(row[0].uid);
                else
                    reject(account_err_account_not_found());
            }
        })
    })
}

function suspend_account(post_data, callback) {
    let uid = post_data.user_id;
    suspend_account_get_account(uid)
        .then(data => {
            return new Promise(((resolve, reject) => {
                delete_account(uid)
                    .then(() => insert_account(data.name, data.acc_type, data.password))
                    .then(() => get_uid(data.name))
                    .then(new_uid => resolve(new_uid))
                    .catch(err => reject(err))
            }))
        })
        .then(new_uid => {
            return new Promise(((resolve, reject) => {
                Promise.all([suspend_account_update_account_info_0(uid, new_uid), suspend_account_update_account_info_1(uid, new_uid)])
                    .then(() => {
                        // TODO：调用资金账户的函数
                        if (capital_account_switch_uid(uid, new_uid))
                            resolve();
                        else
                            reject(account_err_capital_account_not_satisfied());
                    })
                    .then(() => resolve())
                    .catch(err => reject(err))
            }))
        })
        .then(() => callback(request_success()))
        .catch(err => callback(err));
}

// function suspend_account(uid, callback){
//     check_account_status(uid, 1)
//         .then(() => {
//             return new Promise((resolve, reject)=>{
//                 //调用资金账户模块来挂失所有对应的资金账户
//                 if(capital_account_suspend(uid))
//                     resolve();
//                 else
//                     reject(account_err_capital_account_not_satisfied());
//             })
//         })
//         .then(() => update_account_status(uid,0))
//         .then(() => callback(request_success()))
//         .catch((err)=>{callback(err)});
// }

// function reapply_account(uid, callback) {
//     check_account_status(uid, 0)
//         // .then(() => {
//         //     return new Promise((resolve, reject) => {
//         //         //调用资金账户模块来检查是否满足恢复要求
//         //         if (capital_account_check_reapplyable())
//         //             resolve();
//         //         else
//         //             reject(account_err_capital_account_not_satisfied());
//         //     })
//         // })
//         .then(() => update_account_status(uid, 1))
//         .then(() => callback(request_success()))
//         .catch((err) => { callback(err) });
// }


function delete_account(uid) {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("DELETE FROM account where uid=?;", [uid], (err) => {
            if (err)
                reject(account_err_syntax_err(err));
            else
                resolve();
        });
    })
}

function delete_account_info_0(uid) {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("DELETE FROM account_info_0 where uid=?;", [uid], (err) => {
            if (err)
                reject(account_err_syntax_err(err));
            else
                resolve();
        });
    })
}

function delete_account_info_1(uid) {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("DELETE FROM account_info_1 where uid=?;", [uid], (err) => {
            if (err)
                reject(account_err_syntax_err(err));
            else
                resolve();
        });
    })
}

function cancel_account(post_data, callback) {
    let data = post_data;
    let uid = data.user_id;
    new Promise((resolve, reject) => {
        // TODO：调用资金账户模块来检查是否满足注销要求
        if (capital_account_check_cancelable(uid))
            resolve();
        else
            reject(account_err_capital_account_not_satisfied());
    })
        .then(() => delete_account(uid))
        .then(() => Promise.all([delete_account_info_0(uid), delete_account_info_1(uid)]))
        .then(() => callback(request_success()))
        .catch((err) => callback(err));
}

function capital_account_check_cancelable(uid) {
    return true;
}

function capital_account_switch_uid(uid) {
    return true;
}

class account_database {
    // constructor(){
    //     this.sqlite3 = require('sqlite3').verbose();
    //     this.database = new this.sqlite3.Database("test.db", (err) => {
    //         if (err) throw account_err_initialization_failed(err);
    //     });
    // }
    // static get_database(){
    //     return account_database.instance.database;
    // }
    constructor() {

        this.mysql = require('mysql');

        this.connection = this.mysql.createConnection({
            //Options
            host: 'localhost',
            user: 'root',
            password: 'root',
            database: 'stock'
        });
        this.connection.connect();

    }

    static get_database() {
        return account_database.instance.connection
    }
}

account_database.instance = new account_database();

function account_db_init() {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("CREATE TABLE IF NOT EXISTS account (uid INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(32) UNIQUE, password VARCHAR(16) NOT NULL, type INT NOT NULL, acc_type INT NOT NULL);", (err) => {
            if (err) reject(account_err_initialization_failed(err));
            else resolve();
        });
    });
}

function admin_account_db_init() {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("CREATE TABLE IF NOT EXISTS admin_account (uid INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(32) UNIQUE, password VARCHAR(16) NOT NULL);", (err) => {
            if (err) reject(account_err_initialization_failed(err));
            else resolve();
        });
    });
}

function account_info_db_init_0() {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("CREATE TABLE IF NOT EXISTS account_info_0 (" +
            "uid INT PRIMARY KEY, " +
            "name VARCHAR(32) NOT NULL, " +
            "ID VARCHAR(18) NOT NULL, " +
            "home_address VARCHAR(100) NOT NULL, " +
            "job VARCHAR(100) NOT NULL, " +
            "education_background VARCHAR(100) NOT NULL, " +
            "company_address VARCHAR(100) NOT NULL, " +
            "phone VARCHAR(100) NOT NULL, " +
            "agent_ID VARCHAR(100));", (err) => {
            if (err) reject(account_err_initialization_failed(err));
            else resolve();
        });
    });
}

function account_info_db_init_1() {
    return new Promise((resolve, reject) => {
        let db = account_database.get_database();
        db.query("CREATE TABLE IF NOT EXISTS account_info_1 (" +
            "uid INT PRIMARY KEY, " +
            "corporate_number VARCHAR(32) NOT NULL, " +
            "license_number VARCHAR(32) NOT NULL, " +
            "representative_ID VARCHAR(18) NOT NULL, " +
            "representative_name VARCHAR(100) NOT NULL, " +
            "representative_phone VARCHAR(100) NOT NULL, " +
            "representative_address VARCHAR(100) NOT NULL, " +
            "operator_name VARCHAR(32) NOT NULL, " +
            "operator_ID VARCHAR(100) NOT NULL, " +
            "operator_phone VARCHAR(100) NOT NULL, " +
            "operator_address VARCHAR(100) NOT NULL);", (err) => {
            if (err) reject(account_err_initialization_failed(err));
            else resolve();
        });
    });
}

function account_module_init(callback) {
    Promise.all([account_db_init(), admin_account_db_init(), account_info_db_init_0(), account_info_db_init_1()])
        .then(() => {
            callback()
        }, (err) => {
            console.log(err);
        })
}

exports.account_module_init = account_module_init;

exports.login = login_account;
exports.register = register_account;

exports.change_password = update_password;
exports.change_account_info = change_account;
exports.get_account_info = get_account_info;

exports.raise = raise_account;
exports.suspend = suspend_account;
exports.cancel = cancel_account;
exports.admin_login = admin_login_account;
exports.admin_get_account_by_limit = admin_get_account_by_limit;
exports.admin_get_account_by_name = admin_get_account_by_name;

//调用方法例： account.login(req.body, data=>res.send(data))