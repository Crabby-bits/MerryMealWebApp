package com.servlet;

import com.utils.DatabaseManager;
import com.utils.EncryptionUtils;
import java.io.IOException; 
import java.sql.*;	
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/Admin")
public class AdminDashboardServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/admindashboard.jsp");
	    dispatcher.forward(request, response);
	}
}