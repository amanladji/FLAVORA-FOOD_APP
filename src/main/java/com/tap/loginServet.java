package com.tap;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.DAOImple.copy.UserDAOImple;
import com.tap.utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import jakarta.servlet.RequestDispatcher;
import com.tap.model.User;

@WebServlet("/callLoginServlet")
public class loginServet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");
		
		HttpSession session = req.getSession();
		
		UserDAOImple udao = new UserDAOImple();
		User user = udao.getUserByUserName(userName);
		
		String DBPassword = user.getPassword();
		boolean isValid = BCrypt.checkpw(password, DBPassword);
		
		if(isValid) {
			session.setAttribute("user", user);
			resp.sendRedirect("restaurantServlet");
		}else {
			RequestDispatcher rd = req.getRequestDispatcher("login.html");
			rd.forward(req, resp);
			
		}
		
		
		
	}
	

}
