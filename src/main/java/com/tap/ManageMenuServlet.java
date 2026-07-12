package com.tap;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.tap.DAOImple.MenuDAOImple;
import com.tap.model.Menu;

import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/callManageMenuServlet")
public class ManageMenuServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		
		MenuDAOImple mdao = new MenuDAOImple();
		List<Menu> menuList = mdao.getMenusByRestaurantId(restaurantId);
		
		req.setAttribute("restaurantId", restaurantId);
		req.setAttribute("menuList", menuList);
		
		RequestDispatcher rd = req.getRequestDispatcher("admin/manageMenu.jsp");
		rd.forward(req, resp);
		
	}
}
