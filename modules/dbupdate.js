connection = require("./center_db.js").connection;


//offer_sell
function insert_sell(sell_id, seller_id, stock_id, price, date, time, totol, rest, status){
    var insert_sell_ = "INSERT INTO offer_sell (sell_id, seller_id, stock_id, price, date, time, total, rest, status) values(?,?,?,?,?,?,?,?,?) ";
    var insert_sell_p = [sell_id, seller_id, stock_id, price, date, time, totol, rest, status];
    connection.query(insert_sell_,insert_sell_p,function (err, result) {
        if(err){
            console.log('[INSERT SELL ERROR] - ',err.message);
            return null;
        }             
        console.log('insert_sell: ', sell_id, seller_id, stock_id, price, date, time, totol, rest, status);
    });
}
exports.insert_sell=insert_sell;

function update_sell_rest_byid(id, add_rest){
    var update_sell_rest_byid_ = "UPDATE offer_sell SET rest = rest + ? WHERE sell_id = ? ";
    var update_sell_rest_byid_p = [add_rest, id];
    connection.query(update_sell_rest_byid_,update_sell_rest_byid_p,function (err, result) {
        if(err){
            console.log('[UPDATE SELL REST ERROR] - ',err.message);
            return null;
        }             
        console.log('update_sell_rest_byid: ',id, add_rest);
    });
}
exports.update_sell_rest_byid=update_sell_rest_byid;

function update_sell_status_byid(id, status){
    var update_sell_status_byid_ = "UPDATE offer_sell SET status = ? WHERE sell_id = ? ";
    var update_sell_status_byid_p = [status, id];
    connection.query(update_sell_status_byid_,update_sell_status_byid_p,function (err, result) {
        if(err){
            console.log('[UPDATE SELL STATUS ERROR] - ',err.message);
            return null;
        }             
        console.log('update_sell_status_byid: ',id, status);
    });
}
exports.update_sell_status_byid=update_sell_status_byid;

//offer_buy
function insert_buy(buy_id, buyer_id, stock_id, price, date, time, totol, rest, status){
    var insert_buy_ = "INSERT INTO offer_buy (buy_id, buyer_id, stock_id, price, date, time, total, rest, status) values(?,?,?,?,?,?,?,?,?) ";
    var insert_buy_p = [buy_id, buyer_id, stock_id, price, date, time, totol, rest, status];
    connection.query(insert_buy_,insert_buy_p,function (err, result) {
        if(err){
            console.log('[INSERT BUY ERROR] - ',err.message);
            return null;
        }             
        console.log('insert_buy: ', buy_id, buyer_id, stock_id, price, date, time, totol, rest, status);
    });
}
exports.insert_buy=insert_buy;

function update_buy_rest_byid(id, add_rest){
    var update_buy_rest_byid_ = "UPDATE offer_buy SET rest = rest+? WHERE buy_id = ? ";
    var update_buy_rest_byid_p = [add_rest, id];
    connection.query(update_buy_rest_byid_,update_buy_rest_byid_p,function (err, result) {
        if(err){
            console.log('[UPDATE BUY REST ERROR] - ',err.message);
            return null;
        }             
        console.log('update_buy_rest_byid: ',id, add_rest);
    });
}
exports.update_buy_rest_byid=update_buy_rest_byid;

function update_buy_status_byid(id, status){
    var update_buy_status_byid_ = "UPDATE offer_buy SET status = ? WHERE buy_id = ? ";
    var update_buy_status_byid_p = [status, id];
    connection.query(update_buy_status_byid_,update_buy_status_byid_p,function (err, result) {
        if(err){
            console.log('[UPDATE BUY STATUS ERROR] - ',err.message);
            return null;
        }             
        console.log('update_buy_status_byid: ',id, status);
    });
}
exports.update_buy_status_byid=update_buy_status_byid;

//transaction
function insert_transaction(trans_id, stock_id, price, amount, buy_id, sell_id, date, time){
    var insert_transaction_ = "INSERT INTO transaction (trans_id, stock_id, price, amount, buy_id, sell_id, date, time) values(?,?,?,?,?,?,?,?) ";
    var insert_transaction_p = [trans_id, stock_id, price, amount, buy_id, sell_id, date, time];
    connection.query(insert_transaction_,insert_transaction_p,function (err, result) {
        if(err){
            console.log('[INSERT TRANSACTION ERROR] - ',err.message);
            return null;
        }             
        console.log('insert_transaction: ', trans_id, stock_id, price, amount, buy_id, sell_id, date, time);
    });
}
exports.insert_transaction=insert_transaction;

//stock_account
function update_accountstock_byid(account_id, stock_id, add_num, add_freeze_num){
    var update_accountstock_byid_="INSERT INTO account_stock(account_id, stock_id, num, freeze_num) VALUES (?,?,?,?) ON DUPLICATE KEY UPDATE num = num+?, freeze_num = freeze_num + ?";
    var update_accountstock_byid_p=[account_id, stock_id, add_num, add_freeze_num, add_num, add_freeze_num];
    connection.query(update_accountstock_byid_,update_accountstock_byid_p,function (err, result) {
        if(err){
            console.log('[UPDATE ACCOUNT_STOCK ERROR] - ',err.message);
            return null;
        }             
        console.log('update_account_stock_byid: ',account_id, stock_id, add_num, add_freeze_num);
    });
}
exports.update_accountstock_byid=update_accountstock_byid;







