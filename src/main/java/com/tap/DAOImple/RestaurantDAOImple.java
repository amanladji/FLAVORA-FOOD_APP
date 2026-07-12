package com.tap.DAOImple;

import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.RestaurantDAO;

public class RestaurantDAOImple implements RestaurantDAO{
	private static final String INSERT_QUERY = "insert into restaurant"
			+ "(name, cuisineType, deliveryTime, address, adminUserId, rating, isActive, images) values(?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_QUERY = "update restaurant set name = ?, cuisineType = ?, deliveryTime = ?, address = ?, adminUserId = ?, rating = ?, isActive = ?, images = ? where restaurantId = ?";
	private static final String DELETE_QUERY = "delete from restaurant where restaurantId = ?";
	private static final String SELECT_QUERY01 = "select * from restaurant where restaurantId = ?";

	private static final String SELECT_QUERY02 = "select * from restaurant";
	
	@Override
	public void addRestaurant(Restaurant r) {
		Connection con = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY);
			pstmt.setString(1, r.getName());
			pstmt.setString(2, r.getCuisineType());
			pstmt.setInt(3, r.getDeliveryTime());
			pstmt.setString(4, r.getAddress());
			pstmt.setInt(5, r.getAdminUserId());
			pstmt.setDouble(6, r.getRating());
			pstmt.setInt(7, r.getIsActive());
			pstmt.setString(8, r.getImages());
			
			int row = pstmt.executeUpdate();
			System.out.println(row);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void updateRestaurant(Restaurant r) {
		Connection con = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY);
			pstmt.setString(1, r.getName());
			pstmt.setString(2, r.getCuisineType());
			pstmt.setInt(3, r.getDeliveryTime());
			pstmt.setString(4, r.getAddress());
			pstmt.setInt(5, r.getAdminUserId());
			pstmt.setDouble(6, r.getRating());
			pstmt.setInt(7, r.getIsActive());
			pstmt.setString(8, r.getImages());
			pstmt.setInt(9, r.getRestaurantId());
			
			int row = pstmt.executeUpdate();
			System.out.println(row);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void removeRestaurant(int restaurantId) {
		Connection con = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY);
			pstmt.setInt(1, restaurantId);
			int row  = pstmt.executeUpdate();
			System.out.println(row);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public Restaurant getRestaurant(int restaurantId) {
		Connection con = DBConnection.getConnection();
		Restaurant r = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY01);
			pstmt.setInt(1, restaurantId);
			ResultSet result = pstmt.executeQuery();
			
			while(result.next()) {
				r = ResultById(result);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return r;
	}
	
	@Override
	public List<Restaurant> getAll() {
		
		Connection con = DBConnection.getConnection();
		List<Restaurant> al = new ArrayList<Restaurant>();
		Restaurant r = null;
		
		try {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(SELECT_QUERY02);
			while(res.next()) {
				r = ResultById(res);
				al.add(r);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return al;
	}
	
	public static Restaurant ResultById(ResultSet res) throws SQLException{
		int restaurantId = res.getInt("restaurantId");
		String name = res.getString("name");
		String cuisineType = res.getString("cuisineType");
		int deliveryTime = res.getInt("deliveryTime");
		String address = res.getString("address");
		int adminUserId = res.getInt("adminUserId");
		double rating = res.getDouble("rating");
		int isActive = res.getInt("isActive");
		String image = res.getString("images");
		
		Restaurant r = new Restaurant(restaurantId, name, cuisineType, deliveryTime, address, adminUserId, rating, isActive, image);
		
		return r;
	}
	
}
