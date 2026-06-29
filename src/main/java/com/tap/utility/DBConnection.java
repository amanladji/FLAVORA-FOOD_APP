package com.tap.utility;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;

public class DBConnection {
	private static final String URL = "jdbc:mysql://localhost:3306/instantfood4";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "MYmysql@#$12124";
	static Connection con = null;
	
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(URL, USERNAME, PASSWORD);

		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return con;
	}		
}

