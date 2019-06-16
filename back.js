// var http = require('http');
const URL = require('url');
const kline_db = require('./modules/kline_query');
const search_stock = require('./modules/search_stock');

const express = require('express');
const app = express();
// const bodyParser = require('body-parser');
const server = require('http').createServer(app);

app.get('/kline/get_rt', function (req, res) {
    const json = URL.parse(req.url, true).query;
    kline_db.selectRt(json, function (result) {
        const query_result = {data: result.data, basePrice: result.base_price};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.get('/kline/get_his', function (req, res) {
    const json = URL.parse(req.url, true).query;
    kline_db.selectHis(json, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

// TODO: 之后的路由函数暂缺，都是复制粘贴
app.post('/api/login', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.post('/api/change_pass', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.post('/api/search_security', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.get('/api/fund', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.get('/api/stock_in_fund', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.post('/api/search_stock', function (req, res) {
    const data = req.body.data;
    search_stock.searchStock(data, function (result) {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.get('/api/stock_detail', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.post('/api/buy', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.post('/api/sell', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.get('/api/recent_ops', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.post('/api/undo', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.get('/api/admin_search', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

app.get('/api/admin_search', function (req, res) {
    const data = req.body.data;
    kline_db.selectHis(stock_id, interval, function (result) {
        const query_result = {data: result};
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(query_result));
    });
});

server.listen(8088, function () {
    console.log("Listen on port 8088");
});
