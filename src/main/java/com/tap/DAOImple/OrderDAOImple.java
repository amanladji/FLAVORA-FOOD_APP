package com.tap.DAOImple;

import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderDAO;
import com.tap.model.Order;
import com.tap.utility.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

public class OrderDAOImple implements OrderDAO{
	
	private static final String INSERT_QUERY = "insert into ordertable"
			+ "(userId, restaurentId, orderDate, totalAmount, status, paymentMethod) values(?,?,?,?,?,?)";
	private static final String SELECT_QUERY01 = "select * from ordertable where orderId = ?";
	private static final String SELECT_QUERY02 = "select * from ordertable";
	private static final String DELETE_QUERY = "delete from ordertable where orderId = ?";
	private static final String UPDATE_QUERY = "update ordertable set status = ?, paymentMethod = ? where orderId = ?";
	
	private static final String SELECT_QUERY03 = "select * from ordertable where userId = ?";
	@Override
	public int addOrder(Order o) {
		int orderId = 0;
		Connection con = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, o.getUserId());
			pstmt.setInt(2, o.getRestaurentId());
			pstmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
			pstmt.setDouble(4, o.getTotalAmount());
			pstmt.setString(5, o.getStatus());
			pstmt.setString(6, o.getPaymentMethod());
			
			pstmt.executeUpdate();
			
			ResultSet res = pstmt.getGeneratedKeys();
			while(res.next()) {
				orderId = res.getInt(1);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return orderId;
	}
	
	@Override
	public void updateOrder(Order o) {
		Connection con = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY);
			
			pstmt.setString(1, o.getStatus());
			pstmt.setString(2, o.getPaymentMethod());
			pstmt.setInt(3, o.getOrderId());
			
			int row = pstmt.executeUpdate();
			System.out.println(row);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void removeOrder(int OrderId) {
		Connection con = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY);
			pstmt.setInt(1, OrderId);
			int row  = pstmt.executeUpdate();
			System.out.println(row);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public Order getOrder(int OrderId) {
		Connection con = DBConnection.getConnection();
		Order o = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY01);
			pstmt.setInt(1, OrderId);
			ResultSet result = pstmt.executeQuery();
			
			while(result.next()) {
				o = ResultById(result);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return o;
	}
	
	public List<Order> getOrderHistoryByUserId(int userId) {
		Connection con = DBConnection.getConnection();
		List<Order> al = new ArrayList<Order>();
		Order o = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY03);
			pstmt.setInt(1, userId);
			ResultSet res = pstmt.executeQuery();
			
			while(res.next()) {
				o = ResultById(res);
				al.add(o);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return al;
	}
	
	@Override
	public List<Order> getAll() {
		Connection con = DBConnection.getConnection();
		List<Order> al = new ArrayList<Order>();
		Order o = null;
		
		try {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(SELECT_QUERY02);
			while(res.next()) {
				o = ResultById(res);
				al.add(o);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return al;
	}
	
	public static Order ResultById(ResultSet res) throws SQLException{
		int orderId = res.getInt("orderId");
		int userId = res.getInt("userId");
		int restaurentId = res.getInt("restaurentId");
		Timestamp orderDate = res.getTimestamp("orderDate");
		double totalAmount = res.getDouble("totalAmount");
		String status = res.getString("status");
		String paymentMethod = res.getString("paymentMethod");
		
		Order o = new Order(orderId, userId, restaurentId, orderDate, totalAmount, status, paymentMethod);
		return o;
	}
}


