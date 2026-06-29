package com.tap;

import java.io.IOException;

import com.tap.DAOImple.copy.OrderDAOImple;
import com.tap.DAOImple.copy.OrderItemDAOImple;
import com.tap.model.CartItems;
import com.tap.model.Cart;
import com.tap.model.Order;
import com.tap.model.User;
import com.tap.model.OrderItem;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User user = (User)session.getAttribute("user");
		Cart cart = (Cart)session.getAttribute("cart");
		int restaurantId = (Integer)session.getAttribute("oldRestaurantId");
		double finalAmount = (Double)session.getAttribute("finalAmount");
		
		if(user == null) {
			RequestDispatcher rd = req.getRequestDispatcher("login.html");
			rd.forward(req, resp);
			return;
		}
		
		if(user != null && cart != null && !cart.getItems().isEmpty()) {
			
			Order order = new Order();
			order.setUserId(user.getUserId());
			order.setRestaurentId(restaurantId);
			order.setOrderDate(new Timestamp(System.currentTimeMillis()));
			order.setPaymentMethod(req.getParameter("paymentMethod"));
			order.setStatus("pending");
			order.setTotalAmount(finalAmount);
			
			OrderDAOImple odao = new OrderDAOImple();
			int orderId = odao.addOrder(order);
			
			OrderItem orderItem = new OrderItem();
			orderItem.setOrderId(orderId);
			System.out.println("orderId: " + orderId);
			
			for(CartItems item: cart.getItems().values()) {
				orderItem.setMenuId(item.getMenuId());
				orderItem.setQuantity(item.getQuantity());
				orderItem.setItemTotal(item.getTotalPrice());
			}
			
			OrderItemDAOImple oidao = new OrderItemDAOImple();
			oidao.addItem(orderItem);
			
			session.removeAttribute("cart");
			session.removeAttribute("restaurantId");
			session.removeAttribute("finalAmount");
			
			resp.sendRedirect("orderConformation.jsp");
		}
		else 
		{
			resp.sendRedirect("cart.jsp");
		}
		
	}
}
