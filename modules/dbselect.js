//check if initialized
var mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'stock'
});

var ready = 0;

function init() {
    connection.connect();
    ready = 1;
    console.log("dbselect are initialized");
}

exports.init = init;

function end() {
    if (ready == 0) {
        console.log("[END ERROR] - dbselect are not initialized");
        return;
    }
    connection.end();
    ready = 0;
    console.log("dbselect are stoped");
}

exports.end = end;

function select_account_offer_buy(account_id, callback) {
    var select_account_buy_ = "SELECT * FROM offer_buy WHERE buyer_id = ? ";
    var select_account_buy_p = [account_id];
    connection.query(select_account_buy_, select_account_buy_p, function (err, result) {
        if (err) {
            console.log('[SELECT OFFER_BUY ERROR] - ', err.message);
            return null;
        }
        // console.log('select_offer_buy: ', account_id);
        callback(result);
    });
}

exports.select_account_offer_buy = select_account_offer_buy;

function select_account_offer_sell(account_id, callback) {
    var select_account_sell_ = "SELECT * FROM offer_sell WHERE seller_id = ? ";
    var select_account_sell_p = [account_id];
    connection.query(select_account_sell_, select_account_sell_p, function (err, result) {
        if (err) {
            console.log('[SELECT OFFER_SELL ERROR] - ', err.message);
            return null;
        }
        // console.log('select_offer_sell: ', account_id);
        console.log(result);
        callback(result);
    });
}

exports.select_account_offer_sell = select_account_offer_sell;

function select_account_stock(account_id, callback) {
    console.log('helloworld');
    var select_accountstock_ = "SELECT * FROM account_stock WHERE account_id = ? ";
    var select_accountstock_p = [account_id];
    connection.query(select_accountstock_, select_accountstock_p, function (err, result) {
        if (err) {
            console.log('[SELECT ACCOUNT_STOCK ERROR] - ', err.message);
            return null;
        }
        console.log(result);
        // console.log('select_accountstock: ', account_id);
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
            console.log('select_accountstock: ', account_id, stock_id);
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

            console.log('select_limite: ', stock_id);
            callback(result);
        });
    };
}

exports.limite_check = limite_check;
