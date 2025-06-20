<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>MerryMeal</title>
    <link rel="stylesheet" type="text/css" href="">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/Header.css">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/Footer.css">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/DonationPage.css">
</head>
<body>
	<header id="site-header" class="d-flex align-items-center justify-content-between p-3">
        <div class="hlogo">
            <a href="Home">
                <img src="<%= request.getContextPath() %>/assets/MMLogo1altc.png" alt="MerryMeal Logo" class="hlogo-image hlogo-large">
                <img src="<%= request.getContextPath() %>/assets/MMLogo3alt.png" alt="MerryMeal Logo" class="hhogo-image hlogo-small">
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

	<section class="Memform-section d-flex justify-content-center">
		<div class="Memform-container">
			<div class="d-flex align-items-center justify-content-center text-center">
				<h1>Donation Form</h1>
			</div>
			<form class="row g-3" id="donationForm">
				<h2>Donor Information</h2>
				<div class="col-md-6">
					<label for="name" class="form-label">*Name</label>
					<input type="text" class="form-control" id="name" name="name" required>
				</div>
				<div class="col-md-6">
					<label for="email" class="form-label">*Email</label>
					<input type="email" class="form-control" id="email" name="email" required>
				</div>
				<div class="col-md-6">
					<label for="number" class="form-label">*Phone Number</label>
					<input type="tel" class="form-control" id="number" name="number" required>
				</div>
				<div class="col-md-6">
					<label for="address" class="form-label">*Address</label>
					<input type="text" class="form-control" id="address" name="address" required>
				</div>

				<h2>Donor Details</h2>
				<div class="col-md-6">
					<label for="donateamount" class="form-label">*Donation Amount ($)</label>
					<input type="number" class="form-control" id="donateamount" name="donateamount" required>
				</div>
				<div class="col-md-6">
					<fieldset class="mb-3">
						<legend class="col-form-label pt-0">*Frequency</legend>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="frequency" id="onetime" value="ONE-TIME" checked>
							<label class="form-check-label" for="onetime">One Time</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="frequency" id="monthly" value="MONTHLY">
							<label class="form-check-label" for="monthly">Monthly</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="frequency" id="quarterly" value="QUARTERLY">
							<label class="form-check-label" for="quarterly">Quarterly</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="frequency" id="annually" value="ANNUALLY">
							<label class="form-check-label" for="annually">Annually</label>
						</div>
					</fieldset>
				</div>
				<div class="col-md-12">
					<label for="purpose" class="form-label">Purpose / Campaign</label>
					<textarea class="form-control" id="purpose" name="purpose" rows="3"></textarea>
				</div>

				<h2>Payment Information</h2>
				<div class="col-md-6">
					<label for="cardnum" class="form-label">*Card Number</label>
					<input type="number" class="form-control" id="cardnum" name="cardnum" required>
				</div>
				<div class="col-md-6">
					<label for="expdate" class="form-label">*Expiry Date</label>
					<input type="date" class="form-control" id="expdate" name="expdate" required>
				</div>
				<div class="col-md-6">
					<label for="cvv" class="form-label">*CVV</label>
					<input type="num" class="form-control" id="cvv" name="cvv" required>
				</div>
				<div class="col-md-6">
					<label for="billadd" class="form-label">*Billing Address</label>
					<input type="text" class="form-control" id="billadd" name="billadd" required>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="checkbox" name="sameasdonadd" id="sameasdonadd" value="TRUE">
						<label class="form-check-label" for="sameasdonadd">Same as Donor Address</label>
					</div>
				</div>

				<h2>Other Options</h2>
				<div class="col-md-12">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" name="subnews" id="subnews" value="TRUE">
						<label class="form-check-label" for="subnews">Subscribe To Newsletter</label>
					</div>
					<div class="form-check">
						<input class="form-check-input" type="checkbox" name="anon" id="anon" value="TRUE">
						<label class="form-check-label" for="anon">Anonymous Donation</label>
					</div>
				</div>
				<div class="col-md-6">
					<label for="notes" class="form-label">Notes or Message</label>
					<textarea class="form-control" id="notes" name="notes" rows="3"></textarea>
				</div>
				<div class="col-md-6">
					<label for="dedication" class="form-label">Dedicate Donation</label>
					<textarea class="form-control" id="dedication" name="dedication" rows="3"></textarea>
				</div>

				<button type="submit" class="btn btn-primary submit-btn">Donate</button>
			</form>
		</div>
	</section>

	<footer class="d-flex align-items-center justify-content-between p-5">
		<div class="flogo">
			<a href="Home">
				<img src="<%= request.getContextPath() %>/assets/MMLogo4w.png" alt="MerryMeal Logo" class="flogo-image flogo-large">
				<img src="<%= request.getContextPath() %>/assets/MMLogo2w.png" alt="MerryMeal Logo" class="flogo-image flogo-small">
			</a>
		</div>
		<nav class="footer-nav">
			<a href="Privacypolicy" class="footer-btn">Privacy Policy</a>
			<a href="TOS" class="footer-btn">Terms of Service</a>
			<a href="Careers" class="footer-btn">Careers</a>
			<a href="FAQ" class="footer-btn">FAQ</a>
		</nav>
		<div class="footer-nav">
			<p> Phone #: +65 6123 4567</p>
			<p> Email: contact@merrymeal.org </p>
			<p> Address: MerryMeal Headquarters<br>
				123 Community Care Lane<br>
				#05-01 Kindness Hub<br>
				Singapore 567890</p>
		</div>
		<div class="footer-social">
			<p>Follow us</p>
			<div class="social-icons">
				<a href="#"><img src="<%= request.getContextPath() %>/assets/instagram-icon.png" class="icon"></a>
				<a href="#"><img src="<%= request.getContextPath() %>/assets/facebook-icon.png" class="icon"></a>
				<a href="#"><img src="<%= request.getContextPath() %>/assets/tiktok-icon.png" class="icon"></a>
				<a href="#"><img src="<%= request.getContextPath() %>/assets/x-icon.png" class="icon"></a>
			</div>
			<p>© 2025 MerryMeal. <br>All Rights Reserved.</p>
		</div>
	</footer>

	
	<script src="<%= request.getContextPath() %>/js/navigation.js"></script> 

	<script>
	document.querySelector(".submit-btn").addEventListener("click", function (e) {
	    e.preventDefault();
	    const form = document.querySelector("#donationForm");
	    const formData = new FormData(form);

		// this part is the whole email reciept script portion
	    const scriptURL = "https://script.google.com/macros/s/AKfycbxJ3czTlx6jK--OnSx-WUtQ7jgd2jroghlhEvoTrsPXOu307mRSF39DvW7zzWKLvXic/exec";
		// above is the script link where it uses the google api to send out emails and stuff / also handles google sheet history logs.
	    fetch(scriptURL, {
	        method: "POST",
	        body: formData
	    })
	    .then(response => response.json())
	    .then(data => {
	        if (data.result === "success") {
	            alert("🎉 Donation submitted successfully! Thank you.");
	            form.reset();
	            document.getElementById("billadd").readOnly = false; // Reset read-only after submission
	        } else {
	            alert("❌ Error: " + data.message);
	        }
	    })
	    .catch(error => {
	        console.error("Error!", error);
	        alert("❌ Something went wrong. Please try again.");
	    });
	});

	// Automatically copy donor address to billing address and make it readonly
	const donorAddressInput = document.getElementById("address");
	const billingAddressInput = document.getElementById("billadd");
	const billingCheckbox = document.getElementById("sameasdonadd");

	billingCheckbox.addEventListener("change", function () {
	    if (this.checked) {
	        billingAddressInput.value = donorAddressInput.value;
	        billingAddressInput.readOnly = true;
	    } else {
	        billingAddressInput.value = "";
	        billingAddressInput.readOnly = false;
	    }
	});

	donorAddressInput.addEventListener("input", function () {
	    if (billingCheckbox.checked) {
	        billingAddressInput.value = donorAddressInput.value;
	    }
	});
	</script>


</body>
</html>
