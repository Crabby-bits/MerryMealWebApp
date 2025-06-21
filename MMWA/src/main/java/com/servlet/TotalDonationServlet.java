package com.servlet;

import com.utils.DatabaseManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/get-total-donation")
public class TotalDonationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        try (Connection conn = DatabaseManager.getConnection()) {
            String sql = "SELECT SUM(donation_amount) AS total FROM donation";
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                PrintWriter out = response.getWriter();
                if (rs.next()) {
                    double total = rs.getDouble("total");
                    if (rs.wasNull()) {
                        total = 0.0; // explicitly handle NULL
                    }
                    out.print("{\"total\":" + total + "}");
                } else {
                    out.print("{\"total\":0.0}");
                }
                out.flush();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"total\":0.0}");
        }
    }
}

