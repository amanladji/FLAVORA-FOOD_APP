package com.tap.DAOImple;

import java.sql.Connection;

import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.MenuDAO;
import com.tap.model.Menu;
import com.tap.utility.DBConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

public class MenuDAOImple implements MenuDAO{
	private static final String INSERT_QUERY = "insert into menu"
			+ "(restaurantId, itemName, description, price, isAvailable, category, createdAt, images) values(?,?,?,?,?,?,?,?)";
	private static final String UPDATED_QUERY = "update menu set itemName = ?, description = ?, price = ?, isAvailable = ?, category = ?, updatedAt = ?, images = ? where menuId = ?";
	private static final String DELETE_QUERY = "delete from menu where menuId = ?";
	private static final String SELECT_QUERY02 = "select * from menu";
	private static final String SELECT_QUERY01 = "select * from menu where restaurantId = ?";
	private static final String SELECT_QUERY03 = "select * from menu where menuId = ?";
	
	
	@Override
	public void addMenu(Menu m) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY);
			pstmt.setInt(1, m.getRestaurantId());
			pstmt.setString(2, m.getItemName());
			pstmt.setString(3, m.getDescription());
			pstmt.setDouble(4, m.getPrice());
			pstmt.setInt(5, m.getIsAvailable());
			pstmt.setString(6, m.getCategory());
			pstmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
			pstmt.setString(8, m.getImages());
			
			int row = pstmt.executeUpdate();
			System.out.println(row);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateMenu(Menu m) {
		Connection con = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(UPDATED_QUERY);
			pstmt.setString(1, m.getItemName());
			pstmt.setString(2, m.getDescription());
			pstmt.setDouble(3, m.getPrice());
			pstmt.setInt(4, m.getIsAvailable());
			pstmt.setString(5, m.getCategory());
			pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pstmt.setString(7, m.getImages());
			pstmt.setInt(8, m.getMenuId());
			
			int row = pstmt.executeUpdate();
			System.out.println(row);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	@Override
	public void removeMenu(int menuId) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY);
			pstmt.setInt(1, menuId);
			int row = pstmt.executeUpdate();
			System.out.println(row);
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	@Override
	public List<Menu> getMenusByRestaurantId(int restaurantId) {
		Connection con = DBConnection.getConnection();
		List<Menu> al = new ArrayList<Menu>();
		Menu m = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY01);
			pstmt.setInt(1, restaurantId);
			ResultSet result = pstmt.executeQuery();
			
			while(result.next()) {
				m = ResultById(result);
				al.add(m);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return al;
	}
	
	@Override
	public Menu getMenu(int menuId) {
		Connection con = DBConnection.getConnection();
		Menu m = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY03);
			pstmt.setInt(1, menuId);
			ResultSet res = pstmt.executeQuery();
			
			while(res.next()) {
				m = ResultById(res);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return m;
	}
	
	@Override
	public List<Menu> getAll() {
		Connection con = DBConnection.getConnection();
		List<Menu> al = new ArrayList<Menu>();
		Menu m = null;
		
		try {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(SELECT_QUERY02);
			while(res.next()) {
				m = ResultById(res);
				al.add(m);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return al;
	}
	
	public static Menu ResultById(ResultSet res) throws SQLException {
		int menuId = res.getInt("menuId");
		int restaurantId = res.getInt("restaurantId");
		String itemName = res.getString("itemName");	
		String description = res.getString("description");
		double price = res.getDouble("price");
		int isAvailable = res.getInt("isAvailable");
		String category = res.getString("category");
		Timestamp createdAt = res.getTimestamp("createdAt");
		Timestamp updatedAt = res.getTimestamp("updatedAt");
		Timestamp deleteAt = res.getTimestamp("deleteAt");
		String image = res.getString("images");
		
		Menu m = new Menu(menuId, restaurantId, itemName, description, price, isAvailable, category, createdAt, updatedAt, deleteAt, image);
		return m;
	}
}
