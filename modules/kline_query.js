const conn = require('../js/config');
const connection = conn();

const selectHt = (num, callback) => {
    var sql_ht = 'SELECT * FROM `' + num + '`';
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

const selectWeek = (num, callback) => {
    var sql_ht = 'SELECT * FROM `' + num + '`';
    connection.query(sql_ht, (err, rows) => {
        if (err) {
            console.log('[SELECT ERROR] - ', err.sqlMessage);
            let errNews = err.sqlMessage;
            callback(errNews, '');
            return;
        }
        var arr = [];
        var EMA12, EMA26;
        var overall_len = rows.length;
        var section_num;
        // calculate the number of weeks
        if (overall_len % 5 == 0) {
            section_num = overall_len / 5;
        } else {
            section_num = Math.ceil(overall_len / 5);
        }
        for (var i = 0; i < section_num; i++) {
            var count = 0;
            var date_w, min_w, max_w, vol_w, open_w, close_w, MACD_W, DIF_W, DEA_W;
            vol_w = 0;
            min_w = Number.MAX_VALUE;
            max_w = -Number.MAX_VALUE;
            while (count != 5 && rows[5 * i + count]) {
                if (count == 0) { // 1st day
                    open_w = rows[5 * i + count].open_price;
                }
                if (count == 4 || !(rows[5 * i + count + 1])) { // 5th day or last day
                    close_w = rows[5 * i + count].close_price;
                    date_w = rows[5 * i + count].date.getFullYear() + "-" + (rows[5 * i + count].date.getMonth() + 1) + "-" + rows[5 * i + count].date.getDate();
                }
                if (rows[5 * i + count].min_price < min_w) {
                    min_w = rows[5 * i + count].min_price;
                }
                if (rows[5 * i + count].max_price > max_w) {
                    max_w = rows[5 * i + count].max_price;
                }
                vol_w = vol_w + rows[5 * i + count].volume;
                count++;
            }
            if (i == 0) { // 1st week
                MACD_W = 0;
                DEA_W = 0;
                DIF_W = 0;
                EMA12 = close_w;
                EMA26 = close_w;
            } else { // following weeks
                EMA12 = EMA12 * (11 / 13) + close_w * (2 / 13);
                EMA26 = EMA26 * (25 / 27) + close_w * (2 / 27);
                DIF_W = EMA12 - EMA26;
                DEA_W = arr[i - 1][8] * (8 / 10) + DIF_W * (2 / 10);
                MACD_W = 2 * (DIF_W - DEA_W);
            }
            // insert current week
            arr[i] = [date_w,
                open_w,
                close_w,
                min_w,
                max_w,
                vol_w,
                MACD_W.toFixed(2),
                DIF_W.toFixed(2),
                DEA_W.toFixed(2)
            ];
        }
        callback(arr);
    })
};

const selectMonth = (num, callback) => {
    var sql_ht = 'SELECT * FROM `' + num + '`';
    connection.query(sql_ht, (err, rows) => {
        if (err) {
            console.log('[SELECT ERROR] - ', err.sqlMessage);
            let errNews = err.sqlMessage;
            callback(errNews, '');
            return;
        }

        var arr = [];
        var EMA12, EMA26;
        var current_month;
        var open_m, close_m, date_m, MACD_M, DIF_M, DEA_M;
        var mstart_flag = 1;
        var mend_flag = 0;
        var min_m = Number.MAX_VALUE;
        var max_m = -Number.MAX_VALUE;
        var count = 0;
        var vol_m = 0;

        for (var i = 0; i < rows.length; i++) {
            if (mstart_flag == 1) {
                vol_m = 0;
                open_m = rows[i].open_price;
                current_month = rows[i].date.getMonth();
                mstart_flag = 0;
                min_m = Number.MAX_VALUE;
                max_m = -Number.MAX_VALUE;
            }
            if (!(rows[i + 1])) {
                close_m = rows[i].open_price;
                date_m = rows[i].date.getFullYear() + "-" + (rows[i].date.getMonth() + 1) + "-" + rows[i].date.getDate();
                mend_flag = 1;
            } else if ((current_month != rows[i + 1].date.getMonth())) {
                close_m = rows[i].open_price;
                date_m = rows[i].date.getFullYear() + "-" + (rows[i].date.getMonth() + 1) + "-" + rows[i].date.getDate();
                mstart_flag = 1;
                mend_flag = 1;
            }
            if (rows[i].min_price < min_m) {
                min_m = rows[i].min_price;
            }
            if (rows[i].max_price > max_m) {
                max_m = rows[i].max_price;
            }
            vol_m = vol_m + rows[i].volume;
            if (mend_flag == 1) {
                if (count == 0) {
                    MACD_M = 0;
                    DEA_M = 0;
                    DIF_M = 0;
                    EMA12 = close_m;
                    EMA26 = close_m;
                } else {
                    EMA12 = EMA12 * (11 / 13) + close_m * (2 / 13);
                    EMA26 = EMA26 * (25 / 27) + close_m * (2 / 27);
                    DIF_M = EMA12 - EMA26;
                    DEA_M = arr[count - 1][8] * (8 / 10) + DIF_M * (2 / 10);
                    MACD_M = 2 * (DIF_M - DEA_M);
                }
                mend_flag = 0;
                arr[count] = [date_m,
                    open_m,
                    close_m,
                    min_m,
                    max_m,
                    vol_m,
                    MACD_M.toFixed(2),
                    DIF_M.toFixed(2),
                    DEA_M.toFixed(2)
                ];
                count++;
            }
        }
        callback(arr);
    })
};

const selectYear = (num, callback) => {
    var sql_ht = 'SELECT * FROM `' + num + '`';
    connection.query(sql_ht, (err, rows) => {
        if (err) {
            console.log('[SELECT ERROR] - ', err.sqlMessage);
            let errNews = err.sqlMessage;
            callback(errNews, '');
            return;
        }

        var arr = [];
        var EMA12, EMA26;
        var current_year;
        var open_y, close_y, date_y, MACD_Y, DIF_Y, DEA_Y;
        var ystart_flag = 1;
        var yend_flag = 0;
        var min_y = Number.MAX_VALUE;
        var max_y = -Number.MAX_VALUE;
        var count = 0;
        var vol_y = 0;

        for (var i = 0; i < rows.length; i++) {
            if (ystart_flag == 1) {
                vol_y = 0;
                open_y = rows[i].open_price;
                current_year = rows[i].date.getYear();
                ystart_flag = 0;
                min_y = Number.MAX_VALUE;
                max_y = -Number.MAX_VALUE;
            }
            if (!(rows[i + 1])) {
                close_y = rows[i].open_price;
                date_y = rows[i].date.getFullYear() + "-" + (rows[i].date.getMonth() + 1) + "-" + rows[i].date.getDate();
                yend_flag = 1;
            } else if ((current_year != rows[i + 1].date.getYear())) {
                close_y = rows[i].open_price;
                date_y = rows[i].date.getFullYear() + "-" + (rows[i].date.getMonth() + 1) + "-" + rows[i].date.getDate();
                ystart_flag = 1;
                yend_flag = 1;
            }
            if (rows[i].min_price < min_y) {
                min_y = rows[i].min_price;
            }
            if (rows[i].max_price > max_y) {
                max_y = rows[i].max_price;
            }
            vol_y = vol_y + rows[i].volume;
            if (yend_flag == 1) {
                if (count == 0) {
                    MACD_Y = 0;
                    DEA_Y = 0;
                    DIF_Y = 0;
                    EMA12 = close_y;
                    EMA26 = close_y;
                } else {
                    EMA12 = EMA12 * (11 / 13) + close_y * (2 / 13);
                    EMA26 = EMA26 * (25 / 27) + close_y * (2 / 27);
                    DIF_Y = EMA12 - EMA26;
                    DEA_Y = arr[count - 1][8] * (8 / 10) + DIF_Y * (2 / 10);
                    MACD_Y = 2 * (DIF_Y - DEA_Y);
                }
                yend_flag = 0;
                arr[count] = [date_y,
                    open_y,
                    close_y,
                    min_y,
                    max_y,
                    vol_y,
                    MACD_Y.toFixed(2),
                    DIF_Y.toFixed(2),
                    DEA_Y.toFixed(2)
                ];
                count++;
            }
        }
        callback(arr);
    })
};

const selectRt = (num, callback) => {
    var sql_rt = 'SELECT * FROM ' + num + '_RT';
    var arr = [];
    var result = {};
    connection.query(sql_rt, (err, rows) => {
        if (err) {
            console.log('[SELECT ERROR] - ', err.sqlMessage);
            let errNews = err.sqlMessage;
            callback(errNews, '');
            return;
        }
        for (var i = 0; i < rows.length; i++) {
            var mydate = rows[i].date.getFullYear() + "-" + (rows[i].date.getMonth() + 1) + "-" + rows[i].date.getDate();
            arr[i] = [
                rows[i].time,
                rows[i].price,
                rows[i].change_percent,
                rows[i].amount
            ];
        }
        result.data = arr;
    });
    var sql_base = 'SELECT close_price FROM `' + num + '` ORDER BY date DESC LIMIT 1';
    var base_price;
    connection.query(sql_base, (err, rows) => {
        if (err) {
            console.log('[SELECT ERROR] - ', err.sqlMessage);
            let errNews = err.sqlMessage;
            callback(errNews, '');
            return;
        }
        base_price = rows[0].close_price;
        result.base_price = base_price;
        callback(result);
    });
};

const selectCurrentRt = (num, callback) => {
    var sql_rt = 'SELECT * FROM ' + num + '_RT';
    const server_date = new Date().toLocaleDateString('zh-CN');
    const date = server_date.split(' ')[0];
    const time_with_sec = server_date.split(' ')[1];
    let hour = time_with_sec.split(':')[0];
    let minute = time_with_sec.split(':')[1];
    if (hour.length === 1) {
        hour = '0' + hour;
    }
    if (minute.length === 1) {
        minute = '0' + minute;
    }
    let where = ' where date=\'' + date + '\' and time=\'' + hour + ':' + minute + '\'';
    sql_rt = sql_rt + where;
    connection.query(sql_rt, (err, rows) => {
        if (err) {
            console.log('[SELECT ERROR] - ', err.sqlMessage);
            let errNews = err.sqlMessage;
            callback(errNews, '');
            return;
        }
        const arr = [
            rows[0].time,
            rows[0].price,
            rows[0].change_percent,
            rows[0].amount
        ];
        callback(arr);
    })
};

const selectHis = (num, interval, callback) => {
    switch (interval) {
        case 'day':
            selectHt(num, callback);
            break;
        case 'week':
            selectWeek(num, callback);
            break;
        case 'month':
            selectMonth(num, callback);
            break;
        case 'year':
            selectYear(num, callback);
            break;
    }
};

// exports.selectHt = selectHt;
// exports.selectWeek = selectWeek;
// exports.selectMonth = selectMonth;
// exports.selectYear = selectYear;
exports.selectRt = selectRt;
exports.selectCurrentRt = selectCurrentRt;
exports.selectHis = selectHis;