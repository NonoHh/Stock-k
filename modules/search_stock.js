var mysql = require("mysql"); //引用Mysql
const config = {
    host: '127.0.0.1',//数据库地址
    user: "root",//数据库用户
    password: "root",//数据库密码
    database: "stock",//需要连接的数据库
    useConnectionPooling: true
};

var sql_select = "SELECT stock_name, stock_id FROM stock where ";
var num;

//从stock_infomation中查询
function searchStockInfo(json, callback) {
    console.log(json);
    var conn = mysql.createConnection(config);
    conn.connect(); //连接数据库
    //以代码搜索
    if (json["type"] == 1) {
        let sql_from_info = sql_select + "stock_id = " + json["entity"];
        conn.query(sql_from_info, (err, rows) => {
            if (err) {
                console.log("[SELECT ERROR1] - ", err.sqlMessage);
            }
            num = rows.length;
            if(num == 0) {
                var stocks=new Array();
                callback(stocks);
            }
            else {
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
                let conn1 = mysql.createConnection(config);
                conn1.connect(); //连接数据库
                conn1.query(sql, (err, rows1) => {
                    if (err) {
                        console.log("[SELECT ERROR3] - ", err.message);
                    }
                    var stocks = new Array();
                    let arr = {};
                    arr.id = rows[0]["stock_id"];
                    arr.name = rows[0]["stock_name"];
                    arr.price_now = rows1[0]["price_now"];
                    arr.highest_price_today = rows1[0]["highest_price_today"];
                    arr.lowest_price_today = rows1[0]["lowest_price_today"];
                    let sql_order='select (select MAX(price) from `offer_buy` where `stock_id`='+ rows[0]["stock_id"]+' and `rest`>0) as `highest_buy_order`,\
                        (select MIN(price) from `offer_sell` where `stock_id`='+rows[0]["stock_id"]+' and `rest`>0) as `lowest_sell_order`';
                    let conn2 = mysql.createConnection(config);
                    conn2.connect();
                    conn2.query(sql_order,(err,rows2)=>{
                        if(err){
                            console.log("[SELECT ERROR4] - ", err.message);
                        }
                        else{
                            arr.highest_buy_order=rows2[0]['highest_buy_order'];
                            arr.lowest_sell_order=rows2[0]['lowest_sell_order'];
                            let weekprice={};
                            selectWeek(rows[0]["stock_id"],e=>{
                                // arr.week_price=e;
                                stocks.push(arr);
                                callback(stocks);
                            });
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
        conn.query(sql_from_info, (err, rows) => {
            if (err) {
                console.log("[SELECT ERROR2] - ", err.sqlMessage);
            }
            num = rows.length;
            if(num == 0){
                let stocks=new Array();
                callback(stocks);
            }
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
                    let sql_order='select (select MAX(price) from `offer_buy` where `stock_id`='+ rows[0]["stock_id"]+' and `rest`>0) as `highest_buy_order`,\
                        (select MIN(price) from `offer_sell` where `stock_id`='+rows[0]["stock_id"]+' and `rest`>0) as `lowest_sell_order`';
                    let conn2 = mysql.createConnection(config);
                    conn2.connect();
                    conn2.query(sql_order,(err,rows2)=>{
                        if(err){
                            console.log("[SELECT ERROR4] - ", err.message);
                        }
                        else{
                            arr.highest_buy_order=rows2[0]['highest_buy_order'];
                            arr.lowest_sell_order=rows2[0]['lowest_sell_order'];
                            let weekprice={};
                            selectWeek(rows[0]["stock_id"],e=>{
                                arr.week_price=e;
                                stocks.push(arr);
                                callback(stocks);
                            });
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
const selectWeek = (num, callback)=>{
    var sql_ht = 'SELECT * FROM `' + num+'`';
    var conn = mysql.createConnection(config);
    conn.connect();
    conn.query(sql_ht,(err,rows)=>{
        if(err){
            console.log('[SELECT ERROR] - ',err.sqlMessage);
            let errNews = err.sqlMessage;
            callback(errNews,'');
            return;
        }
        var arr = [];
        var EMA12, EMA26;
        var overall_len = rows.length;
        var section_num;
        // calculate the number of weeks
        if(overall_len % 5 == 0) {
            section_num = overall_len/5;
        }
        else {
            section_num = Math.ceil(overall_len/5);
        }
        for(var i = 0; i < 1; i++) {
            var count = 0;
            var date_w, min_w, max_w, vol_w, open_w, close_w, MACD_W, DIF_W, DEA_W;
            vol_w = 0;
            min_w = Number.MAX_VALUE;
            max_w = -Number.MAX_VALUE;
            while(count != 5 && rows[5*i + count]) {
                if(rows[5*i + count].min_price < min_w) {
                    min_w = rows[5*i + count].min_price;
                }
                if(rows[5*i + count].max_price > max_w) {
                    max_w = rows[5*i + count].max_price;
                }
                count++;
            }
            // insert current week
            arr[i] = { min_w, max_w};
        }
        callback(arr);
    });
    conn.end();
}

function interface(json_in, callback) {
    var res={};
    searchStockInfo(json_in, result => {
        res.stock = result;
        if (res.stock.length == num || res.stock.length == 0) {
            callback(res);
        }
    });
}

function interface1(json_in, callback) {
    var res={};
    searchStockInfo(json_in, result => {
        for(let i=0;i<result.length;i++){
            delete result[i].price_now;
            delete result[i].highest_price_today;
            delete result[i].lowest_price_today;
            delete result[i].highest_buy_order;
            delete result[i].lowest_sell_order;
            delete result[i].week_price;
        }
        res.stock=result;
        if (res.stock.length == num || res.stock.length == 0) {
            callback(res);
        }
    });
}


exports.searchStock = interface;
exports.searchStockSimple = interface1;
