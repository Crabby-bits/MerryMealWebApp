package com.servlet;

import com.utils.DatabaseManager;
import com.utils.PasswordUtils;
import java.io.IOException; 
import java.sql.*;	
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import com.fasterxml.jackson.databind.ObjectMapper;


@WebServlet("/PartnerRegister")
public class PartnerRegisterServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/RegisterPartner.jsp");
	    dispatcher.forward(request, response);
	}
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String orgName = request.getParameter("orgname");
        String[] servType = request.getParameterValues("servtype");
        
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonServType = "[]"; // default empty array

        if (servType != null) {
        	jsonServType = objectMapper.writeValueAsString(servType);
        }
        
        String contName = request.getParameter("contname");
        String dayRange = request.getParameter("dayrange");
        String timeRange = request.getParameter("timerange");
        String email = request.getParameter("email");
        String orgDesc = request.getParameter("orgdesc");
        String address = request.getParameter("address");
        String phoneNum = request.getParameter("number");
        
        phoneNum = phoneNum.replaceAll("[^\\d]", "");
        long lngPhoneNum = 0;
        try {
        	lngPhoneNum = Long.parseLong(phoneNum);
        } catch (NumberFormatException e) {
            // Handle invalid number (e.g., show error message or log the issue)
            e.printStackTrace();
        }
        
        String password = request.getParameter("password");
        String rePassword = request.getParameter("confpassword");
        
        // Validate input (check if passwords match)
        if (!password.equals(rePassword)) {
            request.setAttribute("error", "Passwords do not match!");
            System.out.println("Wrong Password");
            request.getRequestDispatcher("/RegisterPartner.jsp").forward(request, response);
            return;
        }

        // Hash with salt
	    String salt = PasswordUtils.generateSalt();
	    String hashedPassword = PasswordUtils.hashPassword(password, salt);
        
        try (Connection conn = DatabaseManager.getConnection()) {
            
            // Check if the email is already in use
            String checkQuery = "SELECT COUNT(*) AS count FROM partneruser WHERE org_email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt("count") > 0) {
                        request.setAttribute("error", "Email is already in use!");
                        System.out.println("Email in use");
                        request.getRequestDispatcher("/RegisterPartner.jsp").forward(request, response);
                        return;
                    }
                }
            }
            
            // Proceed with insertion if email is not used
            String insertQuery = "INSERT INTO partneruser (org_name, org_rep, org_email, org_address, org_phonenum, org_password, org_salt, org_service, org_dayrange, org_timerange, org_desc) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
                stmt.setString(1, orgName);
                stmt.setString(2, contName);
                stmt.setString(3, email);
                stmt.setString(4, address);
                stmt.setLong(5, lngPhoneNum);
                stmt.setString(6, hashedPassword);
                stmt.setString(7, salt);
                stmt.setString(8, jsonServType);
                stmt.setString(9, dayRange);
                stmt.setString(10, timeRange);
                stmt.setString(11, orgDesc);

                int rowsInserted = stmt.executeUpdate();

                if (rowsInserted > 0) {
                    request.setAttribute("message", "Registration successful! Please login.");
                    response.sendRedirect("Login.jsp");
                } else {
                    request.setAttribute("error", "Registration failed. Please try again.");
                    request.getRequestDispatcher("/RegisterPartner.jsp").forward(request, response);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/RegisterPartner.jsp").forward(request, response);
        }
    }
}