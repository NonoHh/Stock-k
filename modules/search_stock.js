const conn = require('../js/config');
const connection = conn();

var sql_select = "SELECT stock_name, stock_id FROM stock_info where ";
var num;

//从stock_infomation中查询
function searchStockInfo(json, callback) {
    connection.connect(); //连接数据库
    //以代码搜索
    if (json["type"] == 1) {
        let sql_from_info = sql_select + "stock_id = " + json["entity"];
        connection.query(sql_from_info, (err, rows) => {
            if (err) {
                console.log("[SELECT ERROR1] - ", err.sqlMessage);
            }
            num = rows.length;
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
            var conn1 = mysql.createConnection(config);
            conn1.connect(); //连接数据库
            conn1.query(sql, (err, rows1) => {
                if (err) {
                    console.log("[SELECT ERROR3] - ", err.message);
                }
                var stocks = new Array();
                let arr = {};
                var resultObject = {};
                arr.id = rows[0]["stock_id"];
                arr.name = rows[0]["stock_name"];
                arr.price_now = rows1[0]["price_now"];
                arr.highest_price_today = rows1[0]["highest_price_today"];
                arr.lowest_price_today = rows1[0]["lowest_price_today"];
                if (resultObject.stock == undefined) {
                    resultObject.stock = stocks;
                }
                stocks.push(arr);
                callback(stocks);
            });
            conn1.end();
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
        connection.query(sql_from_info, (err, rows) => {
            if (err) {
                console.log("[SELECT ERROR2] - ", err.sqlMessage);
            }
            num = rows.length;
            var stocks = new Array();
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
                var conn1 = mysql.createConnection(config);
                conn1.connect(); //连接数据库
                conn1.query(sql, (err, rows1) => {
                    if (err) {
                        console.log("[SELECT ERROR3] - ", err.message);
                    }
                    let arr = {};
                    arr.id = stock_id;
                    arr.name = stock_name;
                    arr.price_now = rows1[0]["price_now"];
                    arr.highest_price_today = rows1[0]["highest_price_today"];
                    arr.lowest_price_today = rows1[0]["lowest_price_today"];
                    stocks.push(arr);
                    callback(stocks);
                });
                conn1.end();
            }
        });
    }
    connection.end(); //断开连接
}

function interface(json_in, callback) {
    var res = {};
    searchStockInfo(json_in, result => {
        res.stock = result;
        if (res.stock.length == num) {
            callback(res);
        }
    });
}

exports.searchStock = interface;
