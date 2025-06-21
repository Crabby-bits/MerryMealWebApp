<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Delivery Progress</title>
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Header.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/DeliveryProgress.css">
  </head>
  <body>
    
     <header id = "site-header" class="d-flex align-items-center justify-content-between p-3">
        <div class="hlogo">
            <a href="Home">
            <img src="<%= request.getContextPath() %>/assets/MMLogo1altc.png" alt="MerryMeal Logo" class="hlogo-image hlogo-large">
            <img src="<%= request.getContextPath() %>/assets/MMLogo3alt.png" alt="MerryMeal Logo" class="hhogo-image hlogo-small"> <!-- Small Logo -->
            </a>
        </div>
    
        <nav class="nav-links">
            <a href="Home" class="header-buttons">Home</a>
            <a href="Aboutus" class="header-buttons">About us</a>
            <a href="Donate" class="header-buttons">Donate</a>
            <c:choose>
            	<c:when test="${not empty sessionScope.userFirstName}">
                	<a href="Account" class="register-btn">Account</a>
            	</c:when>
            	<c:otherwise>
                	<a href="Register" class="register-btn">Login/Register</a>
           		</c:otherwise>
        	</c:choose>
        </nav>
        
        <div class="hamburger d-lg-none" onclick="toggleMenu()">☰</div>
    </header>

      <section class="sidebar">
        <div class="sidebar-links">
          <a href="">Dashboard</a>
          <a href="">Deliveries</a>
          <a href="">Volunteers</a>
          <a href="">Reports</a>
        </div>
      </section>
   <div class="container">

      <main class="main-content">
        <header class="header">
          <h1>Delivery Progress</h1>
        </header>

        <section class="delivery-list">
          <div class="delivery-card"
                data-name="John Doe" 
                data-email="john@example.com" 
                data-phone="09123456789" 
                data-address="123 Elm Street" 
                data-diet="None" 
                data-meal="Chicken & Rice" 
                data-delivery="10:30 AM">

            <div class="details">
              <h3>Client: John Doe</h3>
              <p>Address: 123 Elm Street</p>
              <p>Meal: Chicken & Rice</p>
            </div>

            <div class="status-wrapper">
              <select class="status-select">
                <option value="pending">Pending</option>
                <option value="out-for-delivery">Out for Delivery</option>
                <option value="delivered">Delivered</option>
              </select>
            </div>
          </div>

          <div class="delivery-card">
            <div class="details">
              <h3>Client: Jane Smith</h3>
              <p>Address: 456 Oak Ave</p>
              <p>Meal: Vegan Salad</p>
            </div>

            <div class="status-wrapper">
              <select class="status-select">
                <option value="pending">Pending</option>
                <option value="out-for-delivery">Out for Delivery</option>
                <option value="delivered">Delivered</option>
              </select>
            </div>
          </div>

          <div class="delivery-card">
            <div class="details">
              <h3>Client: Mike Johnson</h3>
              <p>Address: 789 Pine Blvd</p>
              <p>Meal: Beef Stew</p>
            </div>

            <div class="status-wrapper">
              <select class="status-select">
                <option value="pending">Pending</option>
                <option value="out-for-delivery">Out for Delivery</option>
                <option value="delivered">Delivered</option>
              </select>
            </div>
        </section>

        <div class="client-modal">
          <div class="modal-content">
            <span class="close-button">&times;</span>
            <h2 id="modal-client-name">Client Name</h2>
            <p id="modal-client-email">Email:</p>
            <p id="modal-client-phonenumber">Phone number:</p>
            <p id="modal-client-address">Adress:</p>
            <p id="modal-client-diet">Dietary request:</p>
            <p id="modal-client-meal">Meal:</p>
            <p id="modal-client-delivery">Delivery time:</p>
          </div>
        </div>
      </main>
    </div>
    <script src="<%= request.getContextPath() %>/js/DeliveryProgress.js"></script>
    <script src="<%= request.getContextPath() %>/js/navigation.js"></script>
  </body>
</html>
