const mysql = require("mysql");

const connectDB = () => {
    return mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "se"
    });
};

module.exports = connectDB;
