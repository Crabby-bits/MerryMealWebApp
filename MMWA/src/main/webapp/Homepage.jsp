<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Enomy-Finances</title>
    <link rel = "stylesheet" type = "text/css" href = "">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Header.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Footer.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Homepage.css">
</head>
<body>
	<header id = "site-header" class="d-flex align-items-center justify-content-between p-3">
        <div class="hlogo">
            <a href="/Enomy-Finances-webapp">
            <img src="<%= request.getContextPath() %>/assets/ENLogoi.png" alt="Enomy-Finances Logo" class="hlogo-image hlogo-large">
            <img src="<%= request.getContextPath() %>/assets/ENLogo2i.png" alt="Enomy-Finances Logo" class="hhogo-image hlogo-small"> <!-- Small Logo -->
            </a>
        </div>
    
        <nav class="nav-links">
            <a href="Dashboard" class="header-buttons">Dashboard</a>
            <a href="Dashboard?tab=investment" class="header-buttons">Investment</a>
            <a href="Convert" class="header-buttons">Convert Money</a>
            <c:choose>
            	<c:when test="${not empty sessionScope.userFirstName}">
                	<a href="Account" class="findus-btn">Account</a>
            	</c:when>
            	<c:otherwise>
                	<a href="Register" class="findus-btn">Login/Register</a>
           		</c:otherwise>
        	</c:choose>
        </nav>
        
        <div class="hamburger d-lg-none" onclick="toggleMenu()">☰</div>
    </header>

	<script src="<%= request.getContextPath() %>/js/navigation.js"></script>
</body>
</html>