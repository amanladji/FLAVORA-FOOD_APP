package com.tap.DAOImple;
import com.tap.DAO.UserDAO;
import com.tap.model.User;
import com.tap.utility.DBConnection;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class UserDAOImple implements UserDAO{
	private static final String INSERT_QUERY = "insert into user"
			+ "(userName, email, password, address, role, lastLoginDate) values(?,?,?,?,?,?)";
	private static final String SELECT_QUERY01 = "select * from user where userId = ?";
	private static final String SELECT_QUERY02 = "select * from user";
	private static final String UPDATE_QUERY = "update user set userName = ?, email = ?, password = ?, address = ?, lastLoginDate = ? where userId = ?";
	private static final String DELETE_QUERY = "delete from user where userId = ?";
	private static final String SELECT_QUERY03 = "select * from user where userName = ?";
	
	
	@Override
	public void addUser(User u) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY);
			pstmt.setString(1, u.getUserName());
			pstmt.setString(2, u.getEmail());
			pstmt.setString(3, u.getPassword());
			pstmt.setString(4, u.getAddress());
			pstmt.setString(5, u.getRole());
			pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			
			int row = pstmt.executeUpdate();
			System.out.println(row);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void updateUser(User u) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY);
			pstmt.setString(1, u.getUserName());
			pstmt.setString(2, u.getEmail());
			pstmt.setString(3, u.getPassword());
			pstmt.setString(4, u.getAddress());
			pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
			pstmt.setInt(6, u.getUserId());
			
			int row = pstmt.executeUpdate();
			System.out.println(row);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void removeUser(int id) {
		Connection con = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY);
			pstmt.setInt(1, id);
			int row  = pstmt.executeUpdate();
			System.out.println(row);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public User getUser(int id) {
		Connection con = DBConnection.getConnection();
		User u = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY01);
			pstmt.setInt(1, id);
			ResultSet result = pstmt.executeQuery();
			
			while(result.next()) {
				u = resultById(result);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return u;
	}
	
	@Override
	public List<User> getAll(){
		Connection con = DBConnection.getConnection();
		List<User> al = new ArrayList<User>();
		User u = null;
		
		try {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(SELECT_QUERY02);
			while(res.next()) {
				u = resultById(res);
				al.add(u);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return al;
	}
	public User getUserByUserName(String name) {
		Connection con = DBConnection.getConnection();
		User u = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY03);
			pstmt.setString(1, name);
			ResultSet res = pstmt.executeQuery();
			while(res.next()) {
				u = resultById(res);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return u;
		
	}
	
	public static User resultById(ResultSet res) throws SQLException{
		int userId = res.getInt("userId");
		String userName = res.getString("userName");
		String email = res.getString("email");
		String password = res.getString("password");
		String address = res.getString("address");
		String role = res.getString("role");
		Timestamp createdDate = res.getTimestamp("createdDate");
		Timestamp lastLoginDate = res.getTimestamp("lastLoginDate");
		
		User u = new User(userId, userName, email, password, address, role, createdDate, lastLoginDate);
		
		return u;
	}
}
