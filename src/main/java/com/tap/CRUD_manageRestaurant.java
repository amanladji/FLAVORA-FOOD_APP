package com.tap;

import java.io.File;

import java.io.IOException;

import com.tap.DAOImple.RestaurantDAOImple;
import com.tap.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/callRestaurantManager_CRUD")
@MultipartConfig
public class CRUD_manageRestaurant extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		if("add".equals(action)) {
			addRestaurantIntoDataBase(req);
		}else if("edit".equals(action)) {
			editRestaurant(req,resp);
			return;
		}else if("update".equals(action)) {
			updateRestaurant(req, resp);
		}
		else if("delete".equals(action)) {
			deleteRestaurant(req, resp);
		}
		
		resp.sendRedirect(req.getContextPath() + "/callManageRestaurantServlet");
	}
	private void deleteRestaurant(HttpServletRequest req, HttpServletResponse resp) {
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		
		RestaurantDAOImple rdao = new RestaurantDAOImple();
		rdao.removeRestaurant(restaurantId);
		
	}
	private void updateRestaurant(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		String name = req.getParameter("restaurantName");
		String cuisineType = req.getParameter("cuisineType");
		int deliveryTime = Integer.parseInt(req.getParameter("deliveryTime"));
		String address = req.getParameter("address");
		int adminUserId = Integer.parseInt(req.getParameter("adminUserId"));
		double rating = Double.parseDouble(req.getParameter("rating"));
		int isActive = Integer.parseInt(req.getParameter("isActive"));
		
		Part imagePart = req.getPart("imageFile");
		String imageName;
		if(imagePart != null && imagePart.getSize() > 0) {
			imageName = imagePart.getSubmittedFileName();
			String uploadPath = getServletContext().getRealPath("/assets");
			
			imagePart.write(uploadPath + File.separator + imageName);
		}else {
			imageName = req.getParameter("oldImage");
		}
		
		Restaurant r = new Restaurant(restaurantId, name, cuisineType, deliveryTime, address, adminUserId, rating,
				isActive, imageName);
		
		RestaurantDAOImple rdao = new RestaurantDAOImple();
		rdao.updateRestaurant(r);
	}
	private void editRestaurant(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		
		RestaurantDAOImple rdao = new RestaurantDAOImple();
		Restaurant restaurant = rdao.getRestaurant(restaurantId);
		
		req.setAttribute("restaurant", restaurant);
		
		RequestDispatcher rd = req.getRequestDispatcher("admin/manageRestaurants.jsp");
		rd.forward(req, resp);
		
	}
	private void addRestaurantIntoDataBase(HttpServletRequest req) throws IOException, ServletException {
		String name = req.getParameter("restaurantName");
		String cuisineType = req.getParameter("cuisineType");
		int deliveryTime = Integer.parseInt(req.getParameter("deliveryTime"));
		String address = req.getParameter("address");
		int adminUserId = Integer.parseInt(req.getParameter("adminUserId"));
		double rating = Double.parseDouble(req.getParameter("rating"));
		int isActive = Integer.parseInt(req.getParameter("isActive"));
		
		Part imagePart = req.getPart("imageFile");
		String imageName = imagePart.getSubmittedFileName();
		
		String uploadPath = getServletContext().getRealPath("/assets");
		imagePart.write(uploadPath + File.separator + imageName);
		
		Restaurant r = new Restaurant(name, cuisineType, deliveryTime, address, adminUserId, rating,
				isActive, imageName);
		
		RestaurantDAOImple rdao = new RestaurantDAOImple();
		rdao.addRestaurant(r);
		
	}
}
