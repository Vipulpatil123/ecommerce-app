package com.conn;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect 
{
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/app";
    private static final String USER = "root";
    private static final String PASSWORD = "root"; // Change this in production
    private static Connection conn = null;

    public static Connection getConn()
    {
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
