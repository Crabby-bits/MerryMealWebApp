package com.servlet;

import java.io.IOException; 
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/Register")
public class RegisterChoiceServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Optionally, retrieve the session to check if a user is logged in
        HttpSession session = request.getSession(false);
        if (session != null) {
            // For example, log the current user's name if available
            Object userName = session.getAttribute("userFirstName");
            System.out.println("User is logged in: " + userName);
        }
        
        // Forward the request to Homepage.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/RegisterSel.jsp");
        dispatcher.forward(request, response);
    }
}