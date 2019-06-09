var http = require('http');
const conn = require('./config');
const connection = conn();

server = http.createServer(function (request, response) {
    console.log(request.url);
    if (request.url.indexOf('/get_rt') == 0) {
        selectRt(function (result) {
            const query_result = {data: result, basePrice: 10.44};
            response.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
            response.end(JSON.stringify(query_result));
        });
    } else if (request.url.indexOf('/get_his') == 0) {
        selectHt(function (result) {
            const query_result = {data: result, basePrice: 10.44};
            response.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
            response.end(JSON.stringify(query_result));
        });
    }
});

var sql_ht = 'SELECT * FROM `600909`';
var sql_rt = 'SELECT * FROM `600909_RT`';

const selectHt = (callback) => {
    connection.query(sql_ht, (err, rows) => {
        if (err) {
            console.log('[SELECT ERROR] - ', err.sqlMessage);
            let errNews = err.sqlMessage;
            callback(errNews, '');
            return;
        }
        var arr = [];
        for (var i = 0; i < rows.length; i++) {
            var mydate = rows[i].date.getFullYear() + "-" + (rows[i].date.getMonth() + 1) + "-" + rows[i].date.getDate();
            arr[i] = [mydate,
                rows[i].open_price,
                rows[i].close_price,
                rows[i].min_price,
                rows[i].max_price,
                rows[i].volume,
                rows[i].MACD,
                rows[i].DIF,
                rows[i].DEA
            ];
        }
        callback(arr);
    })
};


const selectRt = (callback) => {
    connection.query(sql_rt, (err, rows) => {
        if (err) {
            console.log('[SELECT ERROR] - ', err.sqlMessage);
            let errNews = err.sqlMessage;
            callback(errNews, '');
            return;
        }
        var arr = [];
        for (var i = 0; i < rows.length; i++) {
            var mydate = rows[i].date.getFullYear() + "-" + (rows[i].date.getMonth() + 1) + "-" + rows[i].date.getDate();
            arr[i] = [
                // mydate,
                rows[i].time,
                rows[i].price,
                rows[i].change_percent,
                rows[i].amount
            ];
        }
        callback(arr);
    })
};

server.listen(8088, function () {
    console.log("Listen on port 8088");
    connection.connect();
});
