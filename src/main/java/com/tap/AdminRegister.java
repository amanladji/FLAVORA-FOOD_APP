package com.tap;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

import com.tap.DAOImple.UserDAOImple;
import com.tap.model.User;

@WebServlet("/callAdminRegister")
public class AdminRegister extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userName = req.getParameter("userName");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String address = req.getParameter("address");
		String role = req.getParameter("role");
		
		String companyPassword = req.getParameter("companyPassword");
        if(!"Flavora".equals(companyPassword)) {
			RequestDispatcher rd = req.getRequestDispatcher("admin/adminRegister.jsp");
			rd.forward(req, resp);
			return;
		}else {
			RequestDispatcher rd = req.getRequestDispatcher("admin/adminLogin.jsp");
			rd.forward(req, resp);
		}
		String hashpw = BCrypt.hashpw(password, BCrypt.gensalt(8));
		
		User u = new User(userName, email, hashpw, address, role);
		UserDAOImple udao = new UserDAOImple();
		udao.addUser(u);
		
		resp.sendRedirect("restaurantServlet");
		
		
	}
}
