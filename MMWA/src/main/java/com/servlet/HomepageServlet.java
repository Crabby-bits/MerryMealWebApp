package com.servlet;

import java.io.IOException; 
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/Home")
public class HomepageServlet extends HttpServlet {
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Homepage.jsp");
        dispatcher.forward(request, response);
    }
}
