const connection = require('../js/config');

var sql_select = "SELECT stock_name, stock_id FROM stock where ";
var num;

//查询股票结果
function searchStock(json, callback) {
    var conn = connection();
    conn.connect(); //连接数据库
    //以代码搜索
    if (json["type"] == 1) {
        let sql_from_info = sql_select + "stock_id = " + json["entity"];
        conn.query(sql_from_info, (err, rows) => {
            if (err) {
                console.log("[SELECT ERROR1] - ", err.sqlMessage);
                let stocks = [];
                let result = {};
                result.code = 0;
                result.data = {};
                result.data.stock = stocks;
                return callback(result);
            }
            num = rows.length;
            if (num == 0) {
                let stocks = [];
                let result = {};
                result.code = 1;
                result.data = {};
                result.data.stock = stocks;
                callback(result);
            } else {
                let table_name = rows[0]["stock_id"] + "_RT";
                let sql =
                    "select (select price from " +
                    table_name +
                    " order by time desc limit 1) as price_now,\
                    (select MAX(price) from " +
                    table_name +
                    ") as highest_price_today,\
                    (select MIN(price) from " +
                    table_name +
                    ") as lowest_price_today";
                let conn1 = connection();
                conn1.connect(); //连接数据库
                conn1.query(sql, (err, rows1) => {
                    if (err || rows1.length == 0) {
                        console.log("[SELECT ERROR3] - ", err.message);
                        let stocks = [];
                        let result = {};
                        result.code = 0;
                        result.data = {};
                        result.data.stock = stocks;
                        return callback(result);
                    }
                    let stocks = [];
                    let arr = {};
                    arr.id = rows[0]["stock_id"];
                    arr.name = rows[0]["stock_name"];
                    arr.price_now = rows1[0]["price_now"];
                    arr.highest_price_today = rows1[0]["highest_price_today"];
                    arr.lowest_price_today = rows1[0]["lowest_price_today"];
                    let sql_order = 'select (select MAX(price) from `offer_buy` where `stock_id`=' + rows[0]["stock_id"] + ' and `rest`>0) as `highest_buy_order`,\
                        (select MIN(price) from `offer_sell` where `stock_id`=' + rows[0]["stock_id"] + ' and `rest`>0) as `lowest_sell_order`';
                    let conn2 = connection();
                    conn2.connect();
                    conn2.query(sql_order, (err, rows2) => {
                        if (err) {
                            console.log("[SELECT ERROR4] - ", err.message);
                            let stocks = [];
                            let result = {};
                            result.code = 0;
                            result.data = {};
                            result.data.stock = stocks;
                            return callback(result);
                        } else {
                            arr.highest_buy_order = rows2[0]['highest_buy_order'];
                            arr.lowest_sell_order = rows2[0]['lowest_sell_order'];
                            let result = {};
                            result.code = 1;
                            result.data = {};
                            result.data.stock = stocks;
                            stocks.push(arr);
                            callback(result);
                        }
                    });
                    conn2.end();
                });
                conn1.end();
            }
        });
    } else {
        //以名称搜索
        let split_str = json["entity"].split(" "); //以空格分隔
        let query_str = "";
        for (var i = 0; i < split_str.length; i++) {
            query_str += "%" + split_str[i];
        }
        query_str += "%";
        let sql_from_info = sql_select + "stock_name like '" + query_str + "'"; //被执行查询的sql
        console.log(sql_from_info);
        conn.query(sql_from_info, (err, rows) => {
            num = rows.length;
            if (err) {
                console.log("[SELECT ERROR2] - ", err.sqlMessage);
                let stocks = [];
                let result = {};
                result.code = 0;
                result.data = {};
                result.data.stock = stocks;
                return callback(result);
            }

            if (num == 0) {
                let stocks = [];
                let result = {};
                result.code = 1;
                result.data = {};
                result.data.stock = stocks;
                callback(result);
            }
            let result = {};
            let stocks = [];
            for (var i = 0; i < rows.length; i++) {
                const stock_id = rows[i]["stock_id"];
                const stock_name = rows[i]["stock_name"];
                let table_name = stock_id + "_RT";
                let sql =
                    "select (select price from " +
                    table_name +
                    " order by time desc limit 1) as price_now,\
                    (select MAX(price) from " +
                    table_name +
                    ") as highest_price_today,\
                    (select MIN(price) from " +
                    table_name +
                    ") as lowest_price_today";
                var conn1 = connection();
                conn1.connect(); //连接数据库
                conn1.query(sql, (err, rows1) => {
                    if (err || rows1.length == 0) {
                        console.log("[SELECT ERROR3] - ", err.message);
                        result.code = 0;
                        result.data = {};
                        result.data.stock = stocks;
                        return callback(result);
                    }
                    let arr = {};
                    arr.id = stock_id;
                    arr.name = stock_name;
                    arr.price_now = rows1[0]["price_now"];
                    arr.highest_price_today = rows1[0]["highest_price_today"];
                    arr.lowest_price_today = rows1[0]["lowest_price_today"];
                    let sql_order = 'select (select MAX(price) from `offer_buy` where `stock_id`=' + rows[0]["stock_id"] + ' and `rest`>0) as `highest_buy_order`,\
                        (select MIN(price) from `offer_sell` where `stock_id`=' + rows[0]["stock_id"] + ' and `rest`>0) as `lowest_sell_order`';
                    let conn2 = connection();
                    conn2.connect();
                    conn2.query(sql_order, (err, rows2) => {
                        if (err) {
                            console.log("[SELECT ERROR4] - ", err.message);
                            result.code = 0;
                            result.data = {};
                            result.data.stock = stocks;
                            callback(result);
                        } else {
                            arr.highest_buy_order = rows2[0]['highest_buy_order'];
                            arr.lowest_sell_order = rows2[0]['lowest_sell_order'];
                            stocks.push(arr);
                            result.code = 1;
                            result.data = {};
                            result.data.stock = stocks;
                            callback(result);
                        }
                    });
                    conn2.end();
                });
                conn1.end();
            }
        });
    }
    conn.end(); //断开连接
}


//两个参数：股票代码和回调函数 返回周最高价
const selectWeekMonth = (num, callback) => {
    var sql_ht = 'SELECT * FROM `' + num + '`';
    var conn = connection();
    conn.connect();
    conn.query(sql_ht, (err, rows) => {
        if (err) {
            console.log('[SELECT ERROR] - ', err.sqlMessage);
            let errNews = err.sqlMessage;
            callback(errNews, '');
            return;
        }
        var arr = {};
        var overall_len = rows.length;
        let min_w = Number.MAX_VALUE;
        let max_w = 0;
        let min_m = Number.MAX_VALUE;
        let max_m = 0;
        for (var i = overall_len - 1; i >= 0 && i >= overall_len - 30; i--) {
            if (i >= overall_len - 5) {
                if (rows[i]["min_price"] < min_w)
                    min_w = rows[i]["min_price"];
                if (rows[i]["max_price"] > max_w)
                    max_w = rows[i]["max_price"];
            }
            if (rows[i]["min_price"] < min_m)
                min_m = rows[i]["min_price"];
            if (rows[i]["max_price"] > max_m)
                max_m = rows[i]["max_price"];
        }
        arr.min_w = min_w;
        arr.max_w = max_w;
        arr.min_m = min_m;
        arr.max_m = max_m;
        callback(arr);
    });
    conn.end();
};

function search_stock(json_in, callback) {
    searchStock(json_in, result => {
        if (result.data.stock.length == num || result.data.stock.length == 0) {
            return callback(result);
        } else {
            return callback({code: 0, data: {stock: []}});
        }
    });
}

function stock_detail(json_in, callback) {
    let json = {};
    json.type = 1;
    json.entity = json_in.id;
    searchStock(json, result => {
        let res = {};
        res.code = result.code;
        let data = result.data.stock[0];
        selectWeekMonth(result.data.stock[0].id, arr => {
            data.highest_price_week = arr.max_w;
            data.lowest_price_week = arr.min_w;
            data.highest_price_month = arr.max_m;
            data.lowest_price_month = arr.min_m;
            res.data = data;
            callback(res);
        })
    });
}


exports.search_stock = search_stock;
exports.stock_detail = stock_detail;
