package com.servlet;

import com.utils.DatabaseManager;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        ArrayList<HashMap<String, String>> registrations = new ArrayList<>();

        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT org_name, org_rep, org_email, org_phonenum FROM partneruser ORDER BY org_userid DESC LIMIT 5");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                HashMap<String, String> entry = new HashMap<>();
                entry.put("org_name", rs.getString("org_name"));
                entry.put("org_rep", rs.getString("org_rep"));
                entry.put("org_email", rs.getString("org_email"));
                entry.put("org_phonenum", rs.getString("org_phonenum"));
                registrations.add(entry);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.setAttribute("registrations", registrations);
        RequestDispatcher rd = req.getRequestDispatcher("/admindashboard.jsp");
        rd.forward(req, resp);
    }
}
