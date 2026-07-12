package com.tap.DAOImple;

import java.util.List;

import com.tap.DAO.OrderItemDAO;
import com.tap.model.OrderItem;
import com.tap.utility.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class OrderItemDAOImple implements OrderItemDAO{
	private static final String INSERT_QUERY = "insert into orderitem(orderId, menuId, quantity, itemTotal) values(?,?,?,?)";
	private static final String UPDATE_QUERY = "update orderitem set menuId = ?, quantity = ?, itemTotal = ? where orderItemId = ?";
	private static final String SELECT_QUERY01 = "select * from orderitem where orderItemId = ?";
	private static final String SELECT_QUERY02 = "select * from orderitem";
	private static final String DELETE_QUERY = "delete from orderitem where orderItemId = ?";
	
	@Override
	public void addItem(OrderItem oi) {
		Connection con = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY);
			pstmt.setInt(1, oi.getOrderId());
			pstmt.setInt(2, oi.getMenuId());
			pstmt.setInt(3, oi.getQuantity());
			pstmt.setDouble(4, oi.getItemTotal());
			
			int row = pstmt.executeUpdate();
			System.out.println(row);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void updateItem(OrderItem oi) {
		Connection con = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY);
			pstmt.setInt(1, oi.getMenuId());
			pstmt.setInt(2, oi.getQuantity());
			pstmt.setDouble(3, oi.getItemTotal());
			pstmt.setInt(4, oi.getOrderItemId());
			
			int row = pstmt.executeUpdate();
			System.out.println(row);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void removeItem(int orderItemId) {
		Connection con = DBConnection.getConnection();
		
		try {
			
			PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY);
			pstmt.setInt(1, orderItemId);
			int row = pstmt.executeUpdate();
			System.out.println(row);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public OrderItem getUser(int orderItemId) {
		Connection con = DBConnection.getConnection();
		OrderItem oi = null;
		
		try {
			PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY01);
			pstmt.setInt(1, orderItemId);
			ResultSet res = pstmt.executeQuery();
			while(res.next()) {
				oi = resultById(res);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return oi;
	}
	
	@Override
	public List<OrderItem> getAll() {
		Connection con = DBConnection.getConnection();
		List<OrderItem> al = new ArrayList<OrderItem>();
		OrderItem oi = null;
		
		try {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(SELECT_QUERY02);
			while(res.next()) {
				oi = resultById(res);
				al.add(oi);
			}
			
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return al;
	}
	
	public static OrderItem resultById(ResultSet res) throws SQLException{
		int orderItemId = res.getInt("orderItemId");
		int orderId = res.getInt("orderId");
		int menuId = res.getInt("menuId");
		int quantity = res.getInt("quantity");
		double itemTotal = res.getDouble("itemTotal");
		
		OrderItem oi = new OrderItem(orderItemId, orderId, menuId, quantity, itemTotal);
		return oi;
	}

}
