package com.servlet;

import com.utils.DatabaseManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/update-delivery-status")
public class UpdateDeliveryStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String deliveryId = request.getParameter("deliveryId");
        String newStatus = request.getParameter("status");

        try (Connection conn = DatabaseManager.getConnection()) {
            String sql = "UPDATE delivery SET status = ? WHERE delivery_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newStatus);
            stmt.setInt(2, Integer.parseInt(deliveryId));

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Status updated successfully.");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Delivery not found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error updating status.");
        }
    }
}
