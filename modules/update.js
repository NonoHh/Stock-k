var mysql = require("mysql");
var con_host = "localhost";
var con_user = "root";
var con_pass = "mysql";
var con_db = "stock_test";

function get_close_price(stock, date, last) {
  var sql =
    "SELECT * FROM `" +
    stock +
    "_rt` WHERE time = (SELECT max(time) FROM `" +
    stock +
    "_rt`)";
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  connection.connect();
  connection.query(sql, function(err, result) {
    if (err) {
      console.log("[SELECT ERROR in get_close_price] - ", err.message);
      connection.end();
      return;
    }
    var price = result[0].price;
    update_close_db(stock, date, price, last);
    connection.end();
  });
}

function get_lastday(stock, date) {
  var sql =
    "SELECT * FROM `" +
    stock +
    "`" +
    " WHERE date = date_sub('" +
    date +
    "', interval 1 day)";
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  connection.connect();
  connection.query(sql, function(err, result) {
    if (err) {
      console.log("[SELECT ERROR in get_lastday] - ", err.message);
      connection.end();
      return;
    }
    get_close_price(stock, date, result);
    connection.end();
  });
}

function insert_getsum(stock, date, price, volume) {
  var selectSql =
    "SELECT FROM `" +
    stock +
    "` WHERE date = date_sub('" +
    date +
    "', interval 1 day)";
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  connection.connect();
  connection.query(sql, function(err, result) {
    if (err) {
      console.log("[SELECT ERROR in insert_getsum] - ", err.message);
      connection.end();
      return;
    }
    var sum = result[0].total_volume;
    insert_open(stock, date, price, volume, sum);
    connection.end();
  });
}

function insert_open(stock, date, price, volume, sum) {
  var addSql =
    "INSERT INTO `" + stock + "` VALUES(?,?,0,?,?,?,?,0,0,?,0,0,0,0,0,?)";
  var addSqlParams = [
    date,
    price,
    price,
    price,
    volume,
    volume * price,
    volume / sum,
    sum
  ];
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  connection.connect();
  connection.query(addSql, addSqlParams, function(err, result) {
    if (err) {
      console.log("[INSERT ERROR in insert_open] - ", err.message);
      connection.end();
      return;
    }
    connection.end();
  });
}

function update_tot(stock, date, price, volume, result) {
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  connection.connect();
  var updateSql = "UPDATE `" + stock + "` SET ";
  var flag = false;
  var max = price;
  var min = price;

  if (price > result[0].max_price) {
    updateSql += "max_price = " + price;
    flag = true;
  } else max = result[0].max_price;

  if (price < result[0].min_price) {
    if (flag) updateSql += ", ";
    updateSql += "min_price = " + price;
    flag = true;
  } else min = result[0].min_price;

  if (flag) updateSql += ", ";
  var newVolume = volume + result[0].volume;
  updateSql += "volume = " + newVolume;

  updateSql += ", ";
  var newAmount = volume * price + result[0].amount;
  updateSql += "amount = " + newAmount;

  updateSql += ", ";
  var newexchage_rate = newVolume / result[0].total_volume;
  updateSql += "exchange_rate = " + newexchage_rate;

  updateSql += " WHERE date = '" + date + "'";
  connection.query(updateSql, function(err, result) {
    if (err) {
      console.log("[UPDATE ERROR in update_tot] - ", err.message);
      connection.end();
      return;
    }
    connection.end();
  });
}

function update_close_db(stock, date, price, result) {
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  connection.connect();
  var updateSql = "UPDATE `" + stock + "` SET close_price = " + price;
  if (result != false) {
    var newchange_percent =
      ((price - result[0].close_price) / result[0].close_price) * 100;
    updateSql += ", change_percent = " + newchange_percent;
    var newEMA12 = (result[0].EMA12 * 11) / 13 + (price * 2) / 13;
    updateSql += ", EMA12 = " + newEMA12;
    var newEMA26 = (result[0].EMA26 * 25) / 27 + (price * 2) / 27;
    updateSql += ", EMA26 = " + newEMA26;
    var newDIF = newEMA12 - newEMA26;
    updateSql += ", DIF = " + newDIF;
    var newDEA = (result[0].DEA * 8) / 10 + (newDIF * 2) / 10;
    updateSql += ", DEA = " + newDEA;
    var newMACD = 2 * (newDIF - newDEA);
    updateSql += ", MACD = " + newMACD;
  }
  updateSql += " WHERE date = '" + date + "'";
  connection.query(updateSql, function(err, result) {
    if (err) {
      console.log("[UPDATE ERROR in update_close] - ", err.message);
      connection.end();
      return;
    }
    connection.end();
  });
}

function update1(stock, date, price, volume) {
  var sql = "SELECT * FROM `" + stock + "`" + " WHERE date = '" + date + "'";
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  connection.connect();
  connection.query(sql, function(err, result) {
    if (err) {
      console.log("[SELECT ERROR in update1] - ", err.message);
      connection.end();
      return;
    }
    if (result == false) {
      insert_getsum(stock, date, price, volume);
    } else {
      update_tot(stock, date, price, volume, result);
    }
    connection.end();
  });
}

function insert_rt(stock, date, time, price, volume, last) {
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  var addSql = "INSERT INTO `" + stock + "_rt` VALUES(?,?,?,?,?)";
  var newchange_percent = 0.0;
  if (last != false) {
    if (last[0].price != 0)
      newchange_percent = (price - last[0].price) / last[0].price;
  }
  var addSqlParams = [date, time, price, newchange_percent, volume / 100];
  connection.connect();
  connection.query(addSql, addSqlParams, function(err, result) {
    if (err) {
      console.log("[INSERT ERROR in insert_rt] - ", err.message);
      connection.end();
      return;
    }
    connection.end();
  });
}

function update_rt(stock, date, time, price, volume, result, last) {
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  connection.connect();
  var updateSql = "UPDATE `" + stock + "_rt` SET ";
  updateSql +=
    "price = " + price + ", amount = " + (volume / 100 + result[0].amount);
  if (last != false) {
    if (last[0].price != 0)
      updateSql +=
        ", change_percent = " + (price - last[0].price) / last[0].price;
  }
  updateSql += " WHERE date = '" + date + "' and time = '" + time + "'";
  connection.query(updateSql, function(err, result) {
    if (err) {
      console.log("[UPDATE ERROR in update_rt] - ", err.message);
      connection.end();
      return;
    }
    connection.end();
  });
}

function update2(stock, date, time, price, volume, last) {
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  var sql =
    "SELECT * FROM `" +
    stock +
    "_rt`" +
    "WHERE date = '" +
    date +
    "' and time = '" +
    time +
    "'";
  connection.connect();
  connection.query(sql, function(err, result) {
    if (err) {
      console.log("[SELECT ERROR in update2] - ", err.message);
      connection.end();
      return;
    }
    if (result == false) {
      insert_rt(stock, date, time, price, volume, last);
    } else {
      update_rt(stock, date, time, price, volume, result, last);
    }
    connection.end();
  });
}

function get_lastmin(stock, date, time, price, volume) {
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  var last_time = "";
  if (time[4] != 0) {
    last_time += time[0];
    last_time += time[1];
    last_time += time[2];
    last_time += time[3];
    last_time += time[4] - 1;
  } else if (time[3] != 0) {
    last_time += time[0];
    last_time += time[1];
    last_time += time[2];
    last_time += time[3] - 1;
    last_time += 9;
  } else if (time[1] != 0) {
    last_time += time[0];
    last_time += time[1] - 1;
    last_time += time[2];
    last_time += "59";
  } else if (time[1] != 0) {
    last_time += time[0] - 1;
    last_time += "9:59";
  } else {
    last_time = "23:59";
  }
  //	console.log(last_time);
  var sql =
    "SELECT * FROM `" +
    stock +
    "_rt`" +
    "WHERE date = '" +
    date +
    "' and time = '" +
    last_time +
    "'";
  connection.connect();
  connection.query(sql, function(err, result) {
    if (err) {
      console.log("[SELECT ERROR in get_lastmin] - ", err.message);
      connection.end();
      return;
    }
    update2(stock, date, time, price, volume, result);
    connection.end();
  });
}

function update(stock, date, time, price, volume) {
  update1(stock, date, price, volume);
  get_lastmin(stock, date, time, price, volume);
}

function update_loop(result) {
  for (var i = 0; i < result.length; i++) {
    var stock = result[i].table_name;
    var len = stock.length;
    var flag = true;
    var myDate = new Date();
    var dateString = myDate.getFullYear() + "-";
    if (myDate.getMonth() < 10) {
      dateString += "0";
      dateString += myDate.getMonth();
    } else dateString += myDate.getMonth();
    dateString += "-";
    if (myDate.getDay() < 10) {
      dateString += "0";
      dateString += myDate.getDay();
    } else dateString += myDate.getDay();
    // dateString = '2016-12-07';
    if (len > 3) {
      if (stock.substring(len - 3) != "_rt" && !isNaN(stock)) {
        get_lastday(stock, dateString);
      }
    }
  }
}
exports.update_loop=update_loop;
function update_close() {
  var connection = mysql.createConnection({
    host: con_host,
    user: con_user,
    password: con_pass,
    database: con_db
  });
  var sql =
    "select table_name from information_schema.tables where table_schema = '" +
    con_db +
    "'";
  connection.connect();
  connection.query(sql, function(err, result) {
    if (err) {
      console.log("[SELECT ERROR in update_close] - ", err.message);
      connection.end();
      return;
    }
    update_loop(result);
    connection.end();
  });
}
exports.update_close=update_close;

//股票代码，交易日期，交易时间，交易单价，交易数量
//update("600909", "2016-12-07", "18:01", 21, 10);
//update("600909", "2016-12-07", "18:02", 22, 10);
//	收盘的更新
//update_close();
