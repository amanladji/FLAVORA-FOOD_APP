package com.tap;

import jakarta.servlet.http.HttpServlet;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.awt.event.ItemEvent;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import com.tap.DAOImple.MenuDAOImple;
import com.tap.model.Cart;
import com.tap.model.Menu;
import com.tap.model.CartItems;

@WebServlet("/callCartServlet")
public class CartServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		HttpSession session = req.getSession();
		Cart cart = (Cart)session.getAttribute("cart");
		Integer oldRestaurantId = (Integer)session.getAttribute("oldRestaurantId");
		
		Integer newRestaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		
		if(cart == null || oldRestaurantId != newRestaurantId) {
			cart = new Cart();
			session.setAttribute("cart", cart);
			session.setAttribute("oldRestaurantId", oldRestaurantId);	
		}
	
		
		String action = req.getParameter("action");
		if(action.equals("add")) {
			addItemToCart(req, cart);
		}
		else if(action.equals("update")) {
			updateCart(req, cart);
		}
		else if(action.equals("remove")) {
			removeItemFromCart(req, cart);
		}
		
		
		resp.sendRedirect("cart.jsp");
	}
	
	
	private void addItemToCart(HttpServletRequest req, Cart cart) {
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		
		MenuDAOImple mdao = new MenuDAOImple();
		Menu menu = mdao.getMenu(menuId);
		
		HttpSession session = req.getSession();
		session.setAttribute("oldRestaurantId", menu.getRestaurantId());
		
		if(menu != null) {
			CartItems cartItem = new CartItems(menuId, 
												menu.getRestaurantId(), 
												menu.getItemName(), 
												menu.getPrice(),
												quantity);
			Cart.addItem(cartItem);
		}
	}
	
	private void removeItemFromCart(HttpServletRequest req, Cart cart) {
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		Cart.removeItem(menuId);
		
	}

	private void updateCart(HttpServletRequest req, Cart cart) {
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		Cart.updateItem(menuId, quantity);
		
	}


}
