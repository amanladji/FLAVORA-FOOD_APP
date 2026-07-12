package com.tap;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImple.OrderDAOImple;
import com.tap.model.Order;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callOrderHistoryServlet")
public class OrderHistorServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User user = (User)session.getAttribute("user");
	
		if(user == null) {
			RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
			rd.forward(req, resp);
			return;
		}
		
		int userId = user.getUserId();
		
		OrderDAOImple odao = new OrderDAOImple();
		List<Order> orderHistory = odao.getOrderHistoryByUserId(userId);
		
		req.setAttribute("orderHistory", orderHistory);
		
		RequestDispatcher rd = req.getRequestDispatcher("orderHistory.jsp");
		rd.forward(req, resp);
	}

}
