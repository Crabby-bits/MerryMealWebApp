package com.servlet;

import com.utils.DatabaseManager;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.math.BigDecimal;

@WebServlet("/record-donation")
public class RecordDonationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String amountStr = request.getParameter("donateamount");

        if (amountStr == null || amountStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing donation amount");
            return;
        }

        try (Connection conn = DatabaseManager.getConnection()) {
            // Insert minimal required fields to avoid NOT NULL constraint errors
            String sql = "INSERT INTO donation (donor_name, donor_email, donor_phonenum, donor_address, " +
                         "donation_amount, donation_frequency, card_number, expiry_date, billing_address) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                // Dummy placeholder values
                stmt.setString(1, "Anonymous"); // donor_name
                stmt.setString(2, "placeholder@example.com"); // donor_email
                stmt.setLong(3, 1234567890L); // donor_phonenum
                stmt.setString(4, "Unknown Address"); // donor_address
                stmt.setBigDecimal(5, new BigDecimal(amountStr)); // donation_amount
                stmt.setString(6, "ONE-TIME"); // donation_frequency
                stmt.setString(7, "0000000000000000"); // card_number
                stmt.setDate(8, new java.sql.Date(System.currentTimeMillis())); // expiry_date
                stmt.setString(9, "Unknown Billing"); // billing_address

                stmt.executeUpdate();
            }

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Donation recorded.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database error");
        }
    }
}
