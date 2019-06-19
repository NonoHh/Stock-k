var dbselect = require("./dbselect.js");

function client_request(str, callback) {
    var res = new Array();
    var cnt = 0;
    var mess = str;
    console.log(mess);
    // mess = {"request_type":"stock",
    // "account_id":[{"id":1000059},{"id":1000011}]
    // };
    if (mess.type == "stock") {
        for (var i = 0; i < mess.account_id.length; i++) {
            dbselect.select_account_stock(mess.account_id[i].id, function (result) {
                res.push(result);
                if (res.length == mess.account_id.length) {
                    callback(res);
                }
            });
        }
    } else if (mess.type == "offer") {
        const data = JSON.parse(mess.account_id);
        for (var i = 0; i < data.length; i++) {
            dbselect.select_account_offer_buy(data[i].id, function (result) {
                res.push(result);
                if (res.length == 2 * data.length) {
                    callback(res);
                }
            });
            dbselect.select_account_offer_sell(data[i].id, function (result) {
                res.push(result);
                if (res.length == 2 * data.length) {
                    callback(res);
                }
            });
        }
    }
}

exports.client_request = client_request;


