package com.bizmate.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

//JDBC 연결하는 역할
public class DbConnection {
    public static Connection getConnection() throws SQLException {
        String password = System.getenv("BIZMATE_DB_PASSWORD");

        if (password == null) {
            throw new SQLException("BIZMATE_DB_PASSWORD 환경 변수를 설정해 주세요.");
        }

        try {
            Class.forName("org.h2.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("H2 JDBC 드라이버를 찾을 수 없습니다.", e);
        }

        return DriverManager.getConnection("jdbc:h2:tcp://localhost/~/bizmate", "sa", password);
    }
}