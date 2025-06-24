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
		  <c:choose>
		    <c:when test="${empty deliveryList}">
		      <p style="text-align: center; font-size: 18px; margin-top: 20px;">No deliveries found.</p>
		    </c:when>
		    <c:otherwise>
		      <c:forEach var="delivery" items="${deliveryList}">
		        <div class="delivery-card"
		        	 data-id="${delivery.deliveryId}"
		             data-name="${delivery.clientName}"
		             data-email="${delivery.email}"
		             data-phone="${delivery.phoneNumber}"
		             data-address="${delivery.address}"
		             data-diet="${delivery.dietaryRequest}"
		             data-meal="${delivery.meal}"
		             data-delivery="${delivery.deliveryDate}">
		
		          <div class="details">
		            <h3>Client: ${delivery.clientName}</h3>
		            <p>Address: ${delivery.address}</p>
		            <p>Meal: ${delivery.meal}</p>
		            <p>Delivery Date: ${delivery.deliveryDate}</p>
		          </div>
		
		          <div class="status-wrapper">
		            <select class="status-select">
		              <option value="pending" ${delivery.status == 'pending' ? 'selected' : ''}>Pending</option>
		              <option value="out-for-delivery" ${delivery.status == 'out-for-delivery' ? 'selected' : ''}>Out for Delivery</option>
		              <option value="delivered" ${delivery.status == 'delivered' ? 'selected' : ''}>Delivered</option>
		            </select>
		          </div>
		        </div>
		      </c:forEach>
		    </c:otherwise>
		  </c:choose>
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
