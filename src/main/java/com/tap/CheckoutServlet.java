package com.tap;

import java.io.IOException;

import com.tap.model.CartItems;
import com.tap.DAOImple.OrderDAOImple;
import com.tap.DAOImple.OrderItemDAOImple;
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
		String paymentMethod = req.getParameter("paymentMethod");

		String razorpayPaymentId = req.getParameter("razorpayPaymentId");
		User user = (User)session.getAttribute("user");
		Cart cart = (Cart)session.getAttribute("cart");
		int restaurantId = (Integer)session.getAttribute("oldRestaurantId");
		double finalAmount = (Double)session.getAttribute("finalAmount");
		
		if(user == null) {
			RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
			rd.forward(req, resp);
			return;
		}
		
		if(user != null && cart != null && !cart.getItems().isEmpty()) {
			
			Order order = new Order();
			order.setUserId(user.getUserId());
			order.setRestaurentId(restaurantId);
			order.setOrderDate(new Timestamp(System.currentTimeMillis()));
			order.setPaymentMethod(paymentMethod);
			if (paymentMethod.equals("cash")) {
			    order.setStatus("pending");
			} else {
			    order.setStatus("pending");
			}
			order.setTotalAmount(finalAmount);
			
			
			
			if(!paymentMethod.equals("cash") &&
					   razorpayPaymentId == null){

					    resp.sendRedirect("checkout.jsp");

					    return;

					}
			
			OrderDAOImple odao = new OrderDAOImple();
			int orderId = odao.addOrder(order);
			if (orderId <= 0) {
			    System.out.println("Order insertion failed.");
			    resp.sendRedirect("checkout.jsp");
			    return;
			}
//			--old---
//			OrderItem orderItem = new OrderItem();
//			orderItem.setOrderId(orderId);
//			System.out.println("orderId: " + orderId);
//			
//			for(CartItems item: cart.getItems().values()) {
//				orderItem.setMenuId(item.getMenuId());
//				orderItem.setQuantity(item.getQuantity());
//				orderItem.setItemTotal(item.getTotalPrice());
//			}
//			
//			OrderItemDAOImple oidao = new OrderItemDAOImple();
//			oidao.addItem(orderItem);
			
			//----new with fixed big
			OrderItemDAOImple oidao = new OrderItemDAOImple();

			System.out.println("orderId: " + orderId);

			for (CartItems item : cart.getItems().values()) {

			    OrderItem orderItem = new OrderItem();

			    orderItem.setOrderId(orderId);
			    orderItem.setMenuId(item.getMenuId());
			    orderItem.setQuantity(item.getQuantity());
			    orderItem.setItemTotal(item.getTotalPrice());

			    oidao.addItem(orderItem);
			}
			//--new 
			
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
