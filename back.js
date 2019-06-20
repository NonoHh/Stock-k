// var http = require('http');
const URL = require('url');
const kline_db = require('./modules/kline_query');
const search_stock = require('./modules/search_stock');
const account = require('./modules/account');
const center = require('./modules/center');
const transaction = require('./modules/transaction');
const capital = require('./modules/CapitalBackend').capital;
const express = require('express');
const app = express();
const server = require('http').createServer(app);

transaction.init(1000305, 1000305, 1000302);
transaction.debug_nocheck_stock();
capital.init('127.0.0.1', 'root', 'root', 'stock');

var multipart = require('connect-multiparty');
var multipartMiddleware = multipart();
app.use(multipartMiddleware);

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

app.post('/api/login', function (req, res) {
    const data = req.body;
    account.login(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/register', function (req, res) {
    const data = req.body;
    console.log(data);
    account.register(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/change_account_info', function (req, res) {
    const data = req.body;
    account.change_account_info(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/get_account_info', function (req, res) {
    const data = req.body;
    account.get_account_info(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/raise', function (req, res) {
    const data = req.body;
    account.raise(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/suspend', function (req, res) {
    const data = req.body;
    account.suspend(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/cancel', function (req, res) {
    const data = req.body;
    account.cancel(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/admin_login', function (req, res) {
    const data = req.body;
    account.admin_login(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/change_pass', function (req, res) {
    const data = req.body;
    account.change_password(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/admin_get_account_by_limit', function (req, res) {
    const data = req.body;
    account.admin_get_account_by_limit(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/admin_get_account_by_name', function (req, res) {
    const data = req.body;
    account.admin_get_account_by_name(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/get_account_stock', function (req, res) {
    const data = req.body;
    center.client_request(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/create_capital', function (req, res) {
    var result;

    async function handle() {
        result = await capital.createAccount(req.body.user_id, req.body.password);
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    }

    handle();
});

app.post('/api/change_capital_password', function (req, res) {
    var result;

    async function handle() {
        result = await capital.updatePassword(req.body.account_id, req.body.ori_pass, req.body.new_pass);
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    }

    handle();
});

app.post('/api/delete_capital', function (req, res) {
    var result;

    async function handle() {
        result = await capital.deleteAccount(req.body.account_id, req.body.password);
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    }

    handle();
});

app.post('/api/restore_capital', function (req, res) {
    var result;

    async function handle() {
        result = await capital.restoreAccount(req.body.account_id, req.body.password);
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    }

    handle();
});

app.get('/api/get_all_capital', function (req, res) {
    var result;

    async function handle() {
        result = await capital.getAllAcounts(req.query.user_id);
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    }

    handle();
});

app.post('/api/search_stock_ambiguous', function (req, res) {
    const data = req.body;
    search_stock.search_stock(data, function (result) {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/search_stock_accurate', function (req, res) {
    const data = req.body;
    search_stock.stock_detail(data, function (result) {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

app.post('/api/buy', function (req, res) {
    var result;

    async function handle() {
        result = await capital.create_buy(req.body.card_id, req.body.stock_id, req.body.password, req.body.stock_price, req.body.buy_amount);
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    }

    handle();
});

app.post('/api/sell', function (req, res) {
    var result;

    async function handle() {
        result = await capital.create_sell(req.body.card_id, req.body.stock_id, req.body.password, req.body.stock_price, req.body.buy_amount);
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    }

    handle();
});

app.post('/api/undo', function (req, res) {
    var result;

    async function handle() {
        if (req.body.type == 0) {
            result = await capital.delete_buy(req.body.account_id, req.body.order_id, req.body.password);
        } else {
            result = await capital.delete_sell(req.body.account_id, req.body.order_id, req.body.password);
        }
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    }

    handle();
});

app.post('/api/recent_ops', function (req, res) {
    const data = req.body;
    center.client_request(data, (result) => {
        res.writeHead(200, {'Content-Type': 'text/plain', 'Access-Control-Allow-Origin': '*'});
        res.end(JSON.stringify(result));
    });
});

server.listen(8088, function () {
    console.log("Listen on port 8088");
});
