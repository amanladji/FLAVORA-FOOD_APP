package com.tap.utility;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;

public class DBConnection {
	private static final String URL =
	"jdbc:mysql://gateway01.ap-southeast-1.prod.aws.tidbcloud.com:4000/instantfood4?useSSL=true&requireSSL=true";
	private static final String USERNAME = "3ow8ciTqi8w4CZQ.root";
	private static final String PASSWORD = "4FfpVNKm7foVxj8q";
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

