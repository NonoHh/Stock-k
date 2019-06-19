const mysql = require("mysql");

const connectDB = () => {
    return mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "stock"
    });
};

module.exports = connectDB;
