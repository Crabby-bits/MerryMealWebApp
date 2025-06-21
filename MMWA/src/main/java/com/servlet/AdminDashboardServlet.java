package com.servlet;

import com.utils.DatabaseManager;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/admindashboard")  // Match your lowercase JSP
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        double totalDonations = 0;

        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT SUM(amount) AS total FROM donation_amount");
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                totalDonations = rs.getDouble("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("totalDonations", totalDonations);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admindashboard.jsp");
        dispatcher.forward(request, response);
    }
}
