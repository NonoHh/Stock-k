var CronJob = require('cron').CronJob;

//var async = require('async');
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
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

var buy_queue = Array();
var buy_tmp = Array();
var sell_queue = Array();
var sell_tmp = Array();

function init(debug) {
    new CronJob('59 * * * * *', function () {
        close();
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

function end() {
    if (ready == 0) {
        console.log("[END ERROR] - transaction are not initialized");
        return;
    }
    center_db.end();
    ready = 0;
    console.log("transaction are stoped");
}

exports.end = end;


//buy
function cancel_buy(buy_id, callback) {
    if (buy_queue.find(function (element) {
        return element.buy_id == buy_id;
    })) {
        dbupdate.update_buy_status_byid(buy_id, 'canceled');
        buy_queue.find(function (element) {
            return element.buy_id == buy_id;
        }).nontradable = 3;
        callback(true, buy_queue.find(function (element) {
            return element.buy_id == buy_id;
        }).freeze_money);
    } else
        callback(false);
}

exports.cancel_buy = cancel_buy;

function create_offer_buy(buyer_id, stock_id, price, total) {
    if (total <= 0) return null;
    var object = new Object();
    object.nontradable = 0;//0 trade 1 finish 2 suspend 3 stop
    object.buy_id = ++cur_buy_id;
    object.buyer_id = buyer_id;
    object.stock_id = stock_id;
    object.price = price;
    object.date = new Date().Format("yyyy-MM-dd");
    object.time = new Date().Format("HH:mm:ss");
    object.total = total;
    object.rest = total;
    object.freeze_money = price * total;
    dbupdate.insert_buy(object.buy_id, object.buyer_id, object.stock_id, object.price, object.date, object.time, object.total, object.rest, "waiting");
    return object;
}

function buycmp(a, b) {
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
}

function _doBuyTrans(now) {
    var buy_s = 0;
    for (var i = buy_queue.length - 1; i > 0; i--) {
        if (buycmp(buy_queue[i - 1], buy_queue[i])) {
            var tmp = buy_queue[i - 1];
            buy_queue[i - 1] = buy_queue[i];
            buy_queue[i] = tmp;
        } else {
            buy_s = i;
        }
    }
    var sell_s = 0, sell_t = 0, flag = 0;
    for (var i = 0; i < sell_queue.length; i++) {
        if (!flag && sell_queue[i].stock_id == now.stock_id) {
            flag = 1;
            sell_s = i;
        }
        if (flag && sell_queue[i].stock_id != now.stock_id) {
            sell_t = i;
            break;
        }
    }
    transaction_one(buy_s, buy_s + 1, sell_s, sell_t + 1);
}

function add_buy(buyer_id, stock_id, price, total, callback) {
    if (ready == 0) {
        console.log("[ADD BUY ERROR] - transaction are not initialized");
        callback(false);
        return;
    }
    var tmp = create_offer_buy(buyer_id, stock_id, price, total);
    buy_tmp.push(tmp);
    buy_queue.push(tmp);
    _doBuyTrans(tmp);
    callback(true, tmp.buy_id);
    return;
}

exports.add_buy = add_buy;

//sell
function cancel_sell(sell_id, callback) {
    if (sell_queue.find(function (element) {


        return element.sell_id == sell_id;
    })) {
        sell_queue.find(function (element) {
            return element.sell_id == sell_id;
        }).nontradable = 3;
        dbupdate.update_sell_status_byid(sell_id, 'canceled');
        callback(true);

    } else
        callback(false);
}

exports.cancel_sell = cancel_sell;

function create_offer_sell(seller_id, stock_id, price, total) {
    if (total <= 0) return null;
    var object = new Object();
    object.nontradable = 0;
    object.sell_id = ++cur_sell_id;
    object.seller_id = seller_id;
    object.stock_id = stock_id;
    object.price = price;
    object.date = new Date().Format("yyyy-MM-dd");
    object.time = new Date().Format("HH:mm:ss");
    object.total = total;
    object.rest = total;
    dbupdate.insert_sell(object.sell_id, object.seller_id, object.stock_id, object.price, object.date, object.time, object.total, object.rest, "waiting");
    dbupdate.update_accountstock_byid(object.seller_id, object.stock_id, 0, object.total);//freeze
    return object;
}


function sellcmp(a, b) {
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
}

function _doSellTrans(now) {
    var sell_s = 0;
    for (var i = sell_queue.length - 1; i > 0; i--) {
        if (buycmp(sell_queue[i - 1], sell_queue[i])) {
            var tmp = sell_queue[i - 1];
            sell_queue[i - 1] = sell_queue[i];
            sell_queue[i] = tmp;
        } else {
            sell_s = i;
        }
    }
    var buy_s = 0, buy_t = 0, flag = 0;
    for (var i = 0; i < buy_queue.length; i++) {
        if (!flag && buy_queue[i].stock_id == now.stock_id) {
            flag = 1;
            buy_s = i;
        }
        if (flag && buy_queue[i].stock_id != now.stock_id) {
            buy_t = i;
            break;
        }
    }
    transaction_one(buy_s, buy_t + 1, sell_s, sell_s + 1);
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
            sell_queue.push(tmp);
            _doSellTrans(tmp);
            callback(true, tmp.sell_id);
        } else {
            console.log("[ADD SELL OFFER FAILED] - stock not enough");
            callback(false);
        }
    }
}

exports.add_sell = add_sell;

//transaction
function create_transaction(stock_id, buy_id, buyer_id, sell_id, seller_id, bprice, sprice, trans_num, bp, sp) {//出价最高者可能由于涨停永远买不到股票， 可以考虑修改成交价计算方式改善
    if (trans_num <= 0) return;
    //TODO dubug
    var price = (bprice + sprice) / 2;
    var date = new Date().Format("yyyy-MM-dd");
    var time = new Date().Format("HH:mm:ss");

    dbupdate.insert_transaction(++cur_trans_id, stock_id, price, trans_num, buy_id, sell_id, date, time);
    dbupdate.update_buy_rest_byid(buy_id, -trans_num);
    if (buy_queue[bp].rest == 0) {
        dbupdate.update_buy_status_byid(buy_id, "finish");
    }
    dbupdate.update_sell_rest_byid(sell_id, -trans_num);
    buy_queue[bp].freeze_money -= price * trans_num;
    if (sell_queue[sp].rest == 0) {
        dbupdate.update_sell_status_byid(sell_id, "finish");
    }
    update.update(stock_id, date, time, price, trans_num)

    //TODO：limit check

    // var mqt = new dbselect.limite_check(stock_id);
    // mqt.select(processdata);
    //
    // function processdata(result) {
    //     var price = (bprice + sprice) / 2;
    //     var date = new Date().Format("yyyy-MM-dd");
    //     var time = new Date().Format("HH:mm:ss");

    //     dbupdate.insert_transaction(++cur_trans_id, stock_id, price, trans_num, buy_id, sell_id, date, time);
    //     dbupdate.update_buy_rest_byid(buy_id, -trans_num);
    //     if(buy_queue[bp].rest==0){
    //         dbupdate.update_buy_status_byid(buy_id, "finish");
    //     }
    //     dbupdate.update_sell_rest_byid(sell_id, -trans_num, -price*trans_num);
    //     if(sell_queue[sp].rest==0){
    //         dbupdate.update_sell_status_byid(sell_id, "finish");
    //     }
    //     update.update(stock_id, date, time, price, trans_num)
    //     } else {
    //         console.log("make transaction failed, price ", price, " of stock ", stock_id, " is limited");
    //         if (buy_queue[bp].nontradable == 1) buy_queue[bp].nontradable = 0;
    //         if (sell_queue[sp].nontradable == 1) sell_queue[sp].nontradable = 0;
    //         buy_queue[bp].rest += trans_num;
    //         sell_queue[sp].rest += trans_num;
    //     }
    //
    // }

}

function transaction_one(buy_top, buy_bottom, sell_top, sell_bottom) {
    console.log('1');
    if (buy_top >= buy_bottom || sell_top >= sell_bottom)
        return;
    console.log('2');
    var trans_num = 0;
    for (var i = buy_top; i < buy_bottom; i++) {
        if (buy_queue.length == 0 || buy_queue[i].nontradable)
            continue;
        for (var j = sell_top; j < sell_bottom; j++) {
            if (sell_queue.length == 0 || sell_queue[j].nontradable)
                continue;
            if (buy_queue[i].price >= sell_queue[j].price) {
                trans_num = buy_queue[i].rest < sell_queue[j].rest ? buy_queue[i].rest : sell_queue[j].rest;
                buy_queue[i].rest -= trans_num;
                sell_queue[j].rest -= trans_num;
                if (buy_queue[i].rest == 0)
                    buy_queue[i].nontradable = 1;
                if (sell_queue[j].rest == 0)
                    sell_queue[j].nontradable = 1;
                create_transaction(buy_queue[i].stock_id, buy_queue[i].buy_id, buy_queue[i].buyer_id, sell_queue[j].sell_id, sell_queue[j].seller_id, buy_queue[i].price, sell_queue[j].price, trans_num, i, j);
            }
        }
    }
    //console.log(sell_queue, "\n", buy_queue);
}

function transaction_ones() {
    var x = 0;
    var x_p = 0;
    var y = 0;
    var y_p = 0;
    while (x < buy_queue.length) {
        while (x < buy_queue.length && y < sell_queue.length && buy_queue[x].stock_id < sell_queue[y].stock_id) x++;
        x_p = x;
        while (x < buy_queue.length && y_p < sell_queue.length && buy_queue[x].stock_id > sell_queue[y_p].stock_id) y_p++;
        y = y_p;
        while (x_p < buy_queue.length && y < sell_queue.length && buy_queue[x_p].stock_id == sell_queue[y].stock_id) y++;
        while (x < buy_queue.length && y_p < sell_queue.length && buy_queue[x].stock_id == sell_queue[y_p].stock_id) x++;
        if (x > x_p) transaction_one(x_p, x, y_p, y);
        x = x_p;
        y = y_p;
    }
}

/*
function transaction() {
    if (ready == 0) {
        console.log("[TRANSACTION ERROR] - transaction are not initialized");
        return;
    } else {
        async.series({
            one: function (done) {
                buy_queue.push.apply(buy_queue, buy_tmp);
                sell_queue.push.apply(sell_queue, sell_tmp);
                //console.log("#1",buy_queue);
                //console.log("#1",sell_queue);
                done(null, 'one');
            },
            two: function (done) {
                buy_tmp.splice(0, buy_tmp.length);
                sell_tmp.splice(0, sell_tmp.length);
                //console.log("#2",buy_tmp);
                //console.log("#2",sell_tmp);
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
                //console.log("#3",buy_queue);
                //console.log("#3",sell_queue);
                done(null, 'three');
            },
            four: function (done) {
                transaction_one();
                //console.log("#4",buy_queue);
                //console.log("#4",sell_queue);
                done(null, 'four');
            }
        }, function (error, result) {
        })
    }
}

exports.transaction = transaction;
*/


function close() {
    /*
        console.log("closed");
        for(var i =0; i<sell_queue.length; i++){
            if(sell_queue[i].nontradable==0)
                dbupdate.update_sell_status_byid(sell_queue[i].sell_id,'outdate');
        }
        for(var i =0; i<buy_queue.length; i++){
            if(buy_queue[i].nontradable==0)
                dbupdate.update_buy_status_byid(buy_queue[i].buy_id,'outdate');
        }
        update_close()
        end();
    */
};




