package com.tap;

import java.io.File;

import java.io.IOException;
import java.sql.Timestamp;

import com.tap.DAOImple.MenuDAOImple;
import com.tap.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.util.List;

@WebServlet("/callMenuManager_CRUD")
@MultipartConfig
public class CRUD_ManageMenu extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		String action = req.getParameter("action");
		
		if("add".equals(action)) {
			addMenuToDataBase(req, resp);
		}else if("edit".equals(action)) {
			editMenu(req, resp);
			return;
		}else if("update".equals(action)) {
			updateMenu(req, resp);
		}else if("delete".equals(action)) {
			deleteMenu(req, resp);
		}
		resp.sendRedirect(req.getContextPath() + "/callManageMenuServlet?restaurantId="+restaurantId);
	}

	private void deleteMenu(HttpServletRequest req, HttpServletResponse resp) {
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		
		MenuDAOImple mdao = new MenuDAOImple();
		
		mdao.removeMenu(menuId);
		
		
	}

	private void updateMenu(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		String itemName = req.getParameter("itemName");
		String description = req.getParameter("description");
		double price = Double.parseDouble(req.getParameter("price"));
		int isAvailable = Integer.parseInt(req.getParameter("isAvailable"));
		String category = req.getParameter("category");
		
		Part imagePart = req.getPart("imageFile");
		String imageName;
		if(imagePart != null && imagePart.getSize() > 0) {
			imageName = imagePart.getSubmittedFileName();
			String uploadPath = getServletContext().getRealPath("/assets");
			
			imagePart.write(uploadPath + File.separator + imageName); 
		}else {
			imageName = req.getParameter("oldImage");
		}
		MenuDAOImple mdao = new MenuDAOImple();
		
		Menu m = new Menu(itemName, description, price, isAvailable, category,
				imageName, menuId);
		
		mdao.updateMenu(m);
	}

	private void editMenu(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		
		MenuDAOImple mdao = new MenuDAOImple();
		Menu menu = mdao.getMenu(menuId);
		
		List<Menu> menuList = mdao.getMenusByRestaurantId(restaurantId);
		
		req.setAttribute("menu", menu);
		req.setAttribute("restaurantId", restaurantId);
		req.setAttribute("menuList", menuList);
		
		RequestDispatcher rd = req.getRequestDispatcher("admin/manageMenu.jsp");
		rd.forward(req, resp);
	}
	
	 
	private void addMenuToDataBase(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		String itemName = req.getParameter("itemName");
		String description = req.getParameter("description");
		double price = Double.parseDouble(req.getParameter("price"));
		int isAvailable = Integer.parseInt(req.getParameter("isAvailable"));
		String category = req.getParameter("category");
		
		Part imagePart = req.getPart("imageFile");
		String imageName = imagePart.getSubmittedFileName();
		
		String uploadPath = getServletContext().getRealPath("/assets");
		imagePart.write(uploadPath + File.separator + imageName); 
		
		MenuDAOImple mdao = new MenuDAOImple();
		
		Menu m = new Menu(restaurantId, itemName, description, price, isAvailable, category, imageName);
		mdao.addMenu(m);
	}

}
