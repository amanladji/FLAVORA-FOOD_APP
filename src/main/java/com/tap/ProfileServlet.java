package com.tap;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.DAOImple.UserDAOImple;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callProfileServlet")
public class ProfileServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User user = (User)session.getAttribute("user");
		
		int userId = user.getUserId();
		
		UserDAOImple udao = new UserDAOImple();
		User userr = udao.getUser(userId);
		
		req.setAttribute("user", userr);
		
		RequestDispatcher rd = req.getRequestDispatcher("profile.jsp");
		rd.forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		String userName = req.getParameter("userName");
		String email = req.getParameter("email");
		String address = req.getParameter("address");
		
		int userId = Integer.parseInt(req.getParameter("userId"));
		
		String oldPassword = req.getParameter("oldPassword");
		String DBPassword = req.getParameter("DBPassword");
		String newPassword = req.getParameter("newPassword");
		
		boolean isValid = BCrypt.checkpw(oldPassword, DBPassword);
		if(isValid) {
			UserDAOImple udao = new UserDAOImple();
			
			String newPasswordd = BCrypt.hashpw(newPassword, BCrypt.gensalt(8));
			User user = new User(userName, email, newPasswordd, address, userId);
			udao.updateUser(user);
			
			resp.sendRedirect("restaurantServlet");
			
		}else {
			resp.sendRedirect("callProfileServlet");
		}
	}
	

}
