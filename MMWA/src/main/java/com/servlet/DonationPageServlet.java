package com.servlet;

import com.utils.DatabaseManager;
import java.io.IOException; 
import java.sql.*;	
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/Donate")
public class DonationPageServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/DonationPage.jsp");
	    dispatcher.forward(request, response);
	}
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name");
        String role = request.getParameter("userrole");
        String email = request.getParameter("email");
        String[] dietaryreq = request.getParameterValues ("dietaryreq");
        
        if (dietaryreq != null) {
            for (String item : dietaryreq) {
                System.out.println("Selected: " + item);
                // You can also store in DB, or join into a comma-separated string
            }
        } else {
            System.out.println("No dietary preferences selected.");
        }
        
        String phoneNum = request.getParameter("phoneNum");
        String disDesc = request.getParameter("disDesc");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String delTime = request.getParameter("delTime");
        String rePassword = request.getParameter("confpassword");
        String emerName = request.getParameter("emername");
        String emerPhoneNum = request.getParameter("emernum");

        // Validate input (check if passwords match)
        if (!password.equals(rePassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
            return;
        }

        // Hash the password before storing it in the database
        String hashedPassword = hashPassword(password);
        
try (Connection conn = DatabaseManager.getConnection()) {
            
            // Check if the email is already in use
            String checkQuery = "SELECT COUNT(*) AS count FROM memberuser WHERE email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt("count") > 0) {
                        request.setAttribute("error", "Email is already in use!");
                        request.getRequestDispatcher("/Register.jsp").forward(request, response);
                        return;
                    }
                }
            }
            
            // Proceed with insertion if email is not used
            String insertQuery = "INSERT INTO memberuser (name, email, phonenum, address, password, role, disdesc, deltime, emername, emerphonenum) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phoneNum);
                stmt.setString(4, address);
                stmt.setString(5, hashedPassword);
                stmt.setString(6, role);
                stmt.setString(7, disDesc);
                stmt.setString(8, delTime);
                stmt.setString(9, emerName);
                stmt.setString(10, emerPhoneNum);

                int rowsInserted = stmt.executeUpdate();

                if (rowsInserted > 0) {
                    request.setAttribute("message", "Registration successful! Please login.");
                    response.sendRedirect("Login.jsp");
                } else {
                    request.setAttribute("error", "Registration failed. Please try again.");
                    request.getRequestDispatcher("/Register.jsp").forward(request, response);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
        }
    }

    // Hashing the password using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}