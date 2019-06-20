//check if initialized
var mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'stock'
});

// var connection = mysql.createConnection({
//   host     : 'localhost',
//   user     : 'OSTS-4',
//   password : '89456415',
//   port: '3306',
//   database: 'test'
// });

exports.connection = connection;
var ready = 0;

function init() {
    connection.connect();
    ready = 1;
    console.log("center database are initialized");
}

exports.init = init;

function end() {
    if (ready == 0) {
        console.log("[END ERROR] - center database are not initialized");
        return;
    }
    connection.end();
    ready = 0;
    console.log("center database are stoped");
}

exports.end = end;
