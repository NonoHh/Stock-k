const capital = require('./CapitalBackend.js');
console.log(capital);
var CronJob = require('cron').CronJob;
var async = require('async');

var center_db = require('./center_db.js');
var dbupdate = require('./dbupdate.js');
var dbselect = require('./dbselect.js');
var update = require('./update.js');

var cur_buy_id = 0, cur_sell_id = 0, cur_trans_id = 0, ready = 0;

var debug_nocheck_stock_;

function debug_nocheck_stock() {
    debug_nocheck_stock_ = 1;
}

exports.debug_nocheck_stock = debug_nocheck_stock;

Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "H+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3),  //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};

var buy_queue = Array();
var buy_tmp = Array();
var sell_queue = Array();
var sell_tmp = Array();


function init(debug) {
    new CronJob('0 0 22 * * *', function () {
        close();
    }, null, true);

    new CronJob('0 0 8 * * *', function () {
        ready = 1;
    }, null, true);

    new CronJob('* * * * * *', function () {
        transaction();
    }, null, true);

    center_db.init();
    dbselect.select_max_buy_id(function (result) {
        cur_buy_id = result;
        console.log("cur_buy_id:", cur_buy_id);
    });
    dbselect.select_max_sell_id(function (result) {
        cur_sell_id = result;
        console.log("cur_sell_id:", cur_sell_id);
    });
    dbselect.select_max_trans_id(function (result) {
        cur_trans_id = result;
        console.log("cur_trans_id:", cur_trans_id);
    });
    ready = 1;
    debug_nocheck_stock_ = debug;
    console.log("transaction are initialized");
}

exports.init = init;

function transaction() {
    console.log("----------new round----------");
    if (ready == 0) {
        console.log("[TRANSACTION ERROR] - transaction are not initialized");

    } else {
        async.series({
            one: function (done) {
                buy_queue.push.apply(buy_queue, buy_tmp);
                sell_queue.push.apply(sell_queue, sell_tmp);
                //console.log("#1 buy_queue",buy_queue);
                //console.log("#1 sell_queue",sell_queue);
                done(null, 'one');
            },
            two: function (done) {
                buy_tmp.splice(0, buy_tmp.length);
                sell_tmp.splice(0, sell_tmp.length);
                done(null, 'two');
            },
            three: function (done) {
                buy_queue.sort(function (a, b) {
                    if (a.stock_id == b.stock_id) {//股票序号小在前
                        if (a.price == b.price) {//价格高在前
                            return true;//插入时已经按时间排序，早在前
                        } else if (a.price < b.price) {
                            return true;
                        } else {
                            return false;
                        }
                    } else if (a.stock_id > b.stock_id) {
                        return true;
                    } else {
                        return false;
                    }
                });
                sell_queue.sort(function (a, b) {
                    if (a.stock_id == b.stock_id) {//股票序号小在前
                        if (a.price == b.price) {//价格低在前
                            return true;//插入已经按时间排序，早在前
                        } else if (a.price > b.price) {
                            return true;
                        } else {
                            return false;
                        }
                    } else if (a.stock_id > b.stock_id) {
                        return true;
                    } else {
                        return false;
                    }
                });
                //console.log("#3 buy_queue",buy_queue);
                //console.log("#3 sell_queue",sell_queue);
                done(null, 'three');
            },
            four: function (done) {
                var buy_top = 0;
                var buy_bottom = 0;
                var sell_top = 0;
                var sell_bottom = 0;
                var buy_ready = 0;
                var sell_ready = 0;
                var buy_next = 1;
                var sell_next = 1;
                while (buy_bottom < buy_queue.length && sell_bottom < sell_queue.length) {
                    for (buy_top = buy_bottom, buy_ready = 0; buy_next && (buy_bottom < buy_queue.length && buy_queue[buy_bottom].stock_id == buy_queue[buy_top].stock_id); buy_bottom++)
                        buy_ready = 1;
                    for (sell_top = sell_bottom, sell_ready = 0; sell_next && (sell_bottom < sell_queue.length && sell_queue[sell_bottom].stock_id == sell_queue[sell_top].stock_id); sell_bottom++)
                        sell_ready = 1;
                    if (buy_ready && sell_ready) {
                        if (sell_queue[sell_top].stock_id == buy_queue[buy_top].stock_id) {
                            transaction_one(buy_top, buy_bottom, sell_top, sell_bottom);
                            sell_next = 1;
                            buy_next = 1;
                        } else if (sell_queue[sell_top].stock_id < buy_queue[buy_top].stock_id) {
                            sell_next = 1;
                            buy_next = 0;
                        } else if (sell_queue[sell_top].stock_id > buy_queue[buy_top].stock_id) {
                            sell_next = 0;
                            buy_next = 1;
                        }
                    }
                }
                //console.log("#4 buy_queue",buy_queue);
                //console.log("#4 sell_queue",sell_queue);
                done(null, 'four');
            }
        }, function (error, result) {
        })
    }
}

function transaction_one(buy_top, buy_bottom, sell_top, sell_bottom) {
    if (buy_top >= buy_bottom || sell_top >= sell_bottom)
        return;
    var trans_num = 0;
    for (var i = buy_top; i < buy_bottom; i++) {
        if (buy_queue.length == 0 || buy_queue[i].nontradable)
            continue;
        for (var j = sell_top; j < sell_bottom; j++) {
            if (sell_queue.length == 0 || sell_queue[j].nontradable)
                continue;
            if (buy_queue[i].price >= sell_queue[j].price) {

                var price = (buy_queue[i].price + sell_queue[j].price) / 2;
                var buy_ptr = i;
                var sell_ptr = j;
                dbselect.limite_check(buy_queue[buy_ptr].stock_id, function (result) {
                    if ((result.length == 0) || (result[0].trade && result[0].up_price >= price && result[0].down_price <= price)) {
                        make_transaction(buy_ptr, sell_ptr, price);
                    } else {
                        console.log("make transaction failed, price ", price, " of stock ", buy_queue[buy_ptr].stock_id, " is limited or the stock is none tradable");
                    }
                });
            }
        }
    }
}

function make_transaction(buy_ptr, sell_ptr, price) {

    var trans_num = buy_queue[buy_ptr].rest < sell_queue[sell_ptr].rest ? buy_queue[buy_ptr].rest : sell_queue[sell_ptr].rest;
    if (trans_num <= 0) return;

    buy_queue[buy_ptr].rest -= trans_num;
    sell_queue[sell_ptr].rest -= trans_num;
    if (buy_queue[buy_ptr].rest == 0)
        buy_queue[buy_ptr].nontradable = 1;
    if (sell_queue[sell_ptr].rest == 0)
        sell_queue[sell_ptr].nontradable = 1;

    var date = new Date().Format("yyyy-MM-dd");
    var time = new Date().Format("HH:mm:ss");

    dbupdate.insert_transaction(++cur_trans_id, buy_queue[buy_ptr].stock_id, price, trans_num, buy_queue[buy_ptr].buy_id, sell_queue[sell_ptr].sell_id, date, time);
    dbupdate.update_buy_rest_byid(buy_queue[buy_ptr].buy_id, -trans_num);
    buy_queue[buy_ptr].freeze_money -= price * trans_num;
    if (buy_queue[buy_ptr].rest == 0) {
        dbupdate.update_buy_status_byid(buy_queue[buy_ptr].buy_id, "finish");
        var result;

        async function handle() {
            result = await capital.unfreezeBalance(buy_queue[buy_ptr].buyer_id, buy_queue[buy_ptr].freeze_money);
        }

        handle();
    }

    dbupdate.update_sell_rest_byid(sell_queue[sell_ptr].sell_id, -trans_num);
    if (sell_queue[sell_ptr].rest == 0) {
        dbupdate.update_sell_status_byid(sell_queue[sell_ptr].sell_id, "finish");
    }
    dbupdate.update_accountstock_byid(sell_queue[sell_ptr].seller_id, sell_queue[sell_ptr].stock_id, -trans_num, -trans_num);
    dbupdate.update_accountstock_byid(buy_queue[buy_ptr].buyer_id, buy_queue[buy_ptr].stock_id, trans_num, 0);

    update.update(buy_queue[buy_ptr].stock_id, date, (time + '').substring(0, (time + '').length - 3), price, trans_num);
    var result;

    async function handle() {
        result = await capital.deductFrozen(buy_queue[buy_ptr].buyer_id, trans_num * price);
    }

    async function handle1() {
        result = await capital.addBalance(sell_queue[sell_ptr].seller_id, trans_num * price);
    }

    handle();
    handle1();
}


function close() {
    console.log("closed");
    for (var i = 0; i < sell_queue.length; i++) {
        if (sell_queue[i].nontradable == 0) {
            sell_queue[i].nontradable = 4;
            dbupdate.update_sell_status_byid(sell_queue[i].sell_id, "outdate");
            dbupdate.update_accountstock_byid(sell_queue[i].seller_id, sell_queue[i].stock_id, 0, sell_queue[i].rest);
            // capital.deductFrozen(sell_queue[i].seller_id,)
            var result;

            async function handle() {
                result = await capital.unfreezeBalance(sell_queue[i].seller_id, sell_queue[i].freeze_money);
            }

            handle();
        }
    }
    for (var i = 0; i < buy_queue.length; i++) {
        if (buy_queue[i].nontradable == 0) {
            buy_queue[i].nontradable = 4;
            dbupdate.update_buy_status_byid(buy_queue[i].buy_id, "outdate");
        }
    }
    update.update_close();
    end();
}

function cancel_buy(buy_id, callback) {
    if (buy_queue.find(function (element) {
        return element.buy_id == buy_id;
    })) {
        dbupdate.update_buy_status_byid(buy_id, 'canceled');
        buy_queue.find(function (element) {
            return element.buy_id == buy_id;
        }).nontradable = 3;
        console.log(buy_id, "canceled");
        callback(true, buy_queue.find(function (element) {
            return element.buy_id == buy_id;
        }).freeze_money);
    } else {

        console.log(buy_id, "cancel failed");
        callback(false);
    }
}

exports.cancel_buy = cancel_buy;

function create_offer_buy(buyer_id, stock_id, price, total) {
    if (total <= 0) return null;
    var object = {};
    object.nontradable = 0;//0 trade 1 finish 2 suspend 3 stop
    object.buy_id = ++cur_buy_id;
    object.buyer_id = buyer_id;
    object.stock_id = stock_id;
    object.price = Number(price);
    object.date = new Date().Format("yyyy-MM-dd");
    object.time = new Date().Format("HH:mm:ss");
    object.total = Number(total);
    object.rest = Number(total);
    object.freeze_money = Number(price) * Number(total);
    dbupdate.insert_buy(object.buy_id, object.buyer_id, object.stock_id, object.price, object.date, object.time, object.total, object.rest, "waiting");
    return object;
}

function add_buy(buyer_id, stock_id, price, total, callback) {
    if (ready == 0) {
        console.log("[ADD BUY ERROR] - transaction are not initialized");
        callback(false);
        return;
    }
    var tmp = create_offer_buy(buyer_id, stock_id, price, total);
    buy_tmp.push(tmp);
    //buy_queue.push(tmp);
    callback(true, tmp.buy_id);

}

exports.add_buy = add_buy;

function cancel_sell(sell_id, callback) {
    if (sell_queue.find(function (element) {


        return element.sell_id == sell_id;
    })) {
        sell_queue.find(function (element) {
            return element.sell_id == sell_id;
        }).nontradable = 3;
        dbupdate.update_sell_status_byid(sell_id, 'canceled');
        dbupdate.update_accountstock_byid(sell_queue.find(function (element) {
                return element.sell_id == sell_id;
            }).seller_id,
            sell_queue.find(function (element) {
                return element.sell_id == sell_id;
            }).stock_id,
            0,
            sell_queue.find(function (element) {
                return element.sell_id == sell_id;
            }).rest);
        console.log(sell_id, "canceled");
        callback(true);

    } else {
        console.log(sell_id, "cancel failed");
        callback(false);
    }
}

exports.cancel_sell = cancel_sell;

function create_offer_sell(seller_id, stock_id, price, total) {
    if (total <= 0) return null;
    var object = {};
    object.nontradable = 0;
    object.sell_id = ++cur_sell_id;
    object.seller_id = seller_id;
    object.stock_id = stock_id;
    object.price = Number(price);
    object.date = new Date().Format("yyyy-MM-dd");
    object.time = new Date().Format("HH:mm:ss");
    object.total = Number(total);
    object.rest = Number(total);
    dbupdate.insert_sell(object.sell_id, object.seller_id, object.stock_id, object.price, object.date, object.time, object.total, object.rest, "waiting");
    dbupdate.update_accountstock_byid(object.seller_id, object.stock_id, 0, object.total);//freeze
    return object;
}

function add_sell(seller_id, stock_id, price, total, callback) {
    if (ready == 0) {
        console.log("[ADD SELL ERROR] - transaction are not initialized");
        callback(false);
        return;
    }
    if (total <= 0) {
        callback(false);
        return;
    }
    var mqt = new dbselect.stock_check(seller_id, stock_id, total);
    mqt.select(processdata);

    function processdata(result) {
        if (debug_nocheck_stock_ || (result.length != 0 && result[0].num - result[0].freeze_num >= total)) {
            var tmp = create_offer_sell(seller_id, stock_id, price, total);
            sell_tmp.push(tmp);
            //sell_queue.push(tmp);
            callback(true, tmp.sell_id);
        } else {
            console.log("[ADD SELL OFFER FAILED] - stock not enough");
            callback(false);
        }
    }
}

exports.add_sell = add_sell;
