connection = require("./center_db.js").connection;

function select_max_buy_id(callback) {
    var sql = "select max(buy_id) as max_buy_id from offer_buy";
    connection.query(sql, function (err, result) {
        if (result.length)
            callback(result[0].max_buy_id);
        else
            callback(1000000);
    });
}

exports.select_max_buy_id = select_max_buy_id;

function select_max_sell_id(callback) {
    var sql = "select max(sell_id) as max_sell_id from offer_sell";
    connection.query(sql, function (err, result) {
        if (result.length)
            callback(result[0].max_sell_id);
        else
            callback(1000000);
    });
}

exports.select_max_sell_id = select_max_sell_id;

function select_max_trans_id(callback) {
    var sql = "select max(trans_id) as max_trans_id from transaction";
    connection.query(sql, function (err, result) {
        if (result.length)
            callback(result[0].max_trans_id);
        else
            callback(1000000);
    });
}

exports.select_max_trans_id = select_max_trans_id;

function select_account_offer_buy(account_id, callback) {
    var select_account_buy_ = "select * from stock.offer_buy natural join stock.stock where buyer_id in " +
        account_id + " order by date desc, time desc";
    connection.query(select_account_buy_, function (err, result) {
        if (err) {
            console.log('[SELECT OFFER_BUY ERROR] - ', err.message);
            return null;
        }
        callback(result);
    });
}

exports.select_account_offer_buy = select_account_offer_buy;

function select_account_offer_sell(account_id, callback) {
    var select_account_sell_ = "select * from stock.offer_sell natural join stock.stock where seller_id in " +
        account_id + " order by date desc, time desc";
    connection.query(select_account_sell_, function (err, result) {
        if (err) {
            console.log('[SELECT OFFER_SELL ERROR] - ', err.message);
            return null;
        }
        callback(result);
    });
}

exports.select_account_offer_sell = select_account_offer_sell;

function select_account_stock(account_id, callback) {
    var select_accountstock_ = "select * from stock.account_stock natural join stock.stock where account_id in " +
        account_id + " order by account_id";
    connection.query(select_accountstock_, function (err, result) {
        if (err) {
            console.log('[SELECT ACCOUNT_STOCK ERROR] - ', err.message);
            return null;
        }
        callback(result);
    });
}

exports.select_account_stock = select_account_stock;

function stock_check(account_id, stock_id) {
    this.select = function (callback) {
        var select_accountstock_ = "SELECT num FROM account_stock WHERE account_id = ? AND stock_id = ? ";
        var select_accountstock_p = [account_id, stock_id];
        connection.query(select_accountstock_, select_accountstock_p, function (err, result) {
            if (err) {
                console.log('[SELECT ACCOUNT_STOCK ERROR] - ', err.message);
                return null;
            }
            callback(result);
        });
    };
}

exports.stock_check = stock_check;

function limite_check(stock_id) {
    this.select = function (callback) {
        var select_limite_ = "SELECT * FROM limite WHERE stock_id = ?";
        var select_limite_p = [stock_id];
        connection.query(select_limite_, select_limite_p, function (err, result) {
            if (err) {
                console.log('[SELECT LIMITE ERROR] - ', err.message);
                return null;
            }
            callback(result);
        });
    };
}

exports.limite_check = limite_check;
