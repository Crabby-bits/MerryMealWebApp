package com.servlet;

import com.utils.DatabaseManager;
import com.utils.PasswordUtils;
import java.io.IOException; 
import java.sql.*;	
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import com.fasterxml.jackson.databind.ObjectMapper;


@WebServlet("/MemberRegister")
public class MemberRegisterServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/RegisterMember.jsp");
	    System.out.println("Why fucky wucky?");
	    dispatcher.forward(request, response);
	}
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
		System.out.println("Getting Form Data");
        String name = request.getParameter("name");
        String role = request.getParameter("userrole");
        String email = request.getParameter("email");
        System.out.println("Mapping into JSON");
        String[] dietaryreq = request.getParameterValues ("dietaryreq");
        
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonDietary = "[]"; // default empty array

        if (dietaryreq != null) {
        	jsonDietary = objectMapper.writeValueAsString(dietaryreq);
        	System.out.println("Succesfully mapped into JSON");
        }
        
        String phoneNum = request.getParameter("phoneNum");
        
        System.out.println("Converting Phone Num into long");
        phoneNum = phoneNum.replaceAll("[^\\d]", "");
        long lngphoneNum = 0;
        try {
        	lngphoneNum = Long.parseLong(phoneNum);
        } catch (NumberFormatException e) {
            // Handle invalid number (e.g., show error message or log the issue)
            e.printStackTrace();
        }

        String disDesc = request.getParameter("disDesc");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String delTime = request.getParameter("deltime");
        String rePassword = request.getParameter("confpassword");
        String emerName = request.getParameter("emername");
        String emerPhoneNum = request.getParameter("emernum");
        
        System.out.println("Converting Phone Num into long");
        emerPhoneNum = emerPhoneNum.replaceAll("[^\\d]", "");
        long lngEmerPhoneNum = 0;
        try {
        	lngEmerPhoneNum = Long.parseLong(emerPhoneNum);
        } catch (NumberFormatException e) {
            // Handle invalid number (e.g., show error message or log the issue)
            e.printStackTrace();
        }
        
        System.out.println("Checking Password");
        // Validate input (check if passwords match)
        if (!password.equals(rePassword)) {
            request.setAttribute("error", "Passwords do not match!");
            System.out.println("Password wrong bozo");
            request.getRequestDispatcher("/RegisterMember.jsp").forward(request, response);
            return;
        }

        // Hash with salt
        System.out.println("hashing Password");
	    String salt = PasswordUtils.generateSalt();
	    String hashedPassword = PasswordUtils.hashPassword(password, salt);
        
	    System.out.println("Connecting to DB");
        try (Connection conn = DatabaseManager.getConnection()) {
            
        	System.out.println("Email Dupe Checking");
            // Check if the email is already in use
            String checkQuery = "SELECT COUNT(*) AS count FROM memberuser WHERE mem_email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt("count") > 0) {
                        request.setAttribute("error", "Email is already in use!");
                        request.getRequestDispatcher("/RegisterMember.jsp").forward(request, response);
                        return;
                    }
                }
            }
            
            System.out.println("Inserting");
            // Proceed with insertion if email is not used
            String insertQuery = "INSERT INTO memberuser (mem_name, mem_email, mem_phonenum, mem_address, mem_password, mem_salt, mem_role, mem_dietreq, mem_disdesc, mem_deltime, mem_emername, mem_emerphonenum) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setLong(3, lngphoneNum);
                stmt.setString(4, address);
                stmt.setString(5, hashedPassword);
                stmt.setString(6, salt);
                stmt.setString(7, role);
                stmt.setString(8, jsonDietary);
                stmt.setString(9, disDesc);
                stmt.setString(10, delTime);
                stmt.setString(11, emerName);
                stmt.setLong(12, lngEmerPhoneNum);

                int rowsInserted = stmt.executeUpdate();

                if (rowsInserted > 0) {
                    request.setAttribute("message", "Registration successful! Please login.");
                    response.sendRedirect("Login");
                } else {
                    request.setAttribute("error", "Registration failed. Please try again.");
                    request.getRequestDispatcher("/RegisterMember.jsp").forward(request, response);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/RegisterMember.jsp").forward(request, response);
        }
    }
}