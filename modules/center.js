var dbselect = require("./dbselect.js");

function client_request(str, callback) {
    var mess = str;
    const data = JSON.parse(mess.account_id);
    client_request_mid(mess, function (result) {
        callback(result);
    });
}

function client_request_mid(mess, callback) {
    if (mess.type == "stock") {
        const data = JSON.parse(mess.account_id);
        var id = '(';
        for (let i = 0; i < data.length; i++) {
            id += data[i].id;
            id += ',';
        }
        id = id.substring(0, id.length - 1);
        id += ')';
        var packet = [];
        dbselect.select_account_stock(id, function (result) {
            for (var j = 0; j < result.length; j++)
                packet.push({
                    stock_name: result[j].stock_name,
                    card_id: result[j].account_id,
                    stock_id: result[j].stock_id,
                    num: result[j].num,
                    freeze_num: result[j].freeze_num,
                    stock_type: result[j].stock_type,
                    stock_sum: result[j].stock_sum
                });
            callback(packet);
        });
    } else if (mess.type == "offer") {
        const data = JSON.parse(mess.account_id);
        var id = '(';
        for (let i = 0; i < data.length; i++) {
            id += data[i].id;
            id += ',';
        }
        id = id.substring(0, id.length - 1);
        id += ')';
        var packet = [];
        dbselect.select_account_offer_buy(id, function (result) {
            for (var j = 0; j < result.length; j++) {
                packet.push({
                    stock_name: result[j].stock_name,
                    card_id: result[j].buyer_id,
                    stock_id: result[j].stock_id,
                    price: result[j].price,
                    total: result[j].total,
                    date: result[j].date,
                    time: result[j].time,
                    rest: result[j].rest,
                    status: result[j].status,
                    id: result[j].buy_id,
                    type: 0
                });
            }
            dbselect.select_account_offer_sell(id, function (result) {
                for (var j = 0; j < result.length; j++)
                    packet.push({
                        stock_name: result[j].stock_name,
                        card_id: result[j].seller_id,
                        stock_id: result[j].stock_id,
                        price: result[j].price,
                        total: result[j].total,
                        date: result[j].date,
                        time: result[j].time,
                        rest: result[j].rest,
                        status: result[j].status,
                        id: result[j].sell_id,
                        type: 1
                    });
                callback(packet);
            });
        });
    }
}

exports.client_request = client_request;
