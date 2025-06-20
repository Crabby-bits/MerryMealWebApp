<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>MerryMeal</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Header.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Footer.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/DonationPage.css">
  <script src="https://www.paypal.com/sdk/js?client-id=Abo2xKMyjhGEjkxb-a1evrmiDjsyItqJeVStljHTLAte37mErt_ixDeIQ-jci01PP5JF4o4mdKv9y8d0&currency=USD"></script>
</head>
<body>

<header id="site-header" class="d-flex align-items-center justify-content-between p-3">
  <div class="hlogo">
    <a href="Home">
      <img src="<%= request.getContextPath() %>/assets/MMLogo1altc.png" class="hlogo-image hlogo-large" alt="MerryMeal Logo">
      <img src="<%= request.getContextPath() %>/assets/MMLogo3alt.png" class="hlogo-image hlogo-small" alt="MerryMeal Logo">
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
    <div class="text-center mb-4">
      <h1>Donation Form</h1>
    </div>
    <form class="row g-3" id="donationForm">
      <h2>Donor Information</h2>
      <div class="col-md-6"><label class="form-label">*Name</label><input type="text" class="form-control" name="name" required></div>
      <div class="col-md-6"><label class="form-label">*Email</label><input type="email" class="form-control" name="email" required></div>
      <div class="col-md-6"><label class="form-label">*Phone Number</label><input type="tel" class="form-control" name="number" required></div>
      <div class="col-md-6"><label class="form-label">*Address</label><input type="text" class="form-control" name="address" id="address" required></div>

      <h2>Donor Details</h2>
      <div class="col-md-6">
        <label class="form-label">*Donation Amount ($)</label>
        <input type="number" class="form-control" name="donateamount" id="donateamount" required>
      </div>
      <div class="col-md-6">
        <fieldset class="mb-3">
          <legend class="col-form-label pt-0">*Frequency</legend>
          <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="ONE-TIME" checked> <label class="form-check-label">One Time</label></div>
          <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="MONTHLY"> <label class="form-check-label">Monthly</label></div>
          <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="QUARTERLY"> <label class="form-check-label">Quarterly</label></div>
          <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="ANNUALLY"> <label class="form-check-label">Annually</label></div>
        </fieldset>
      </div>
      <div class="col-md-12"><label class="form-label">Purpose / Campaign</label><textarea class="form-control" name="purpose" rows="3"></textarea></div>

      <h2>Payment Information</h2>
      <div class="col-md-6"><label class="form-label">*Card Number</label><input type="number" class="form-control" name="cardnum" required></div>
      <div class="col-md-6"><label class="form-label">*Expiry Date</label><input type="date" class="form-control" name="expdate" required></div>
      <div class="col-md-6"><label class="form-label">*CVV</label><input type="num" class="form-control" name="cvv" required></div>

      <!-- ✅ PayPal Button -->
      <div class="col-md-12" id="paypal-container" style="display: none;">
        <p><strong>Or donate with PayPal:</strong></p>
        <div id="paypal-button-container"></div>
      </div>

      <div class="col-md-6">
        <label class="form-label">*Billing Address</label>
        <input type="text" class="form-control" name="billadd" id="billadd" required>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" id="sameasdonadd">
          <label class="form-check-label">Same as Donor Address</label>
        </div>
      </div>

      <h2>Other Options</h2>
      <div class="col-md-12">
        <div class="form-check"><input class="form-check-input" type="checkbox" name="subnews"> <label class="form-check-label">Subscribe To Newsletter</label></div>
        <div class="form-check"><input class="form-check-input" type="checkbox" name="anon"> <label class="form-check-label">Anonymous Donation</label></div>
      </div>
      <div class="col-md-6"><label class="form-label">Notes or Message</label><textarea class="form-control" name="notes" rows="3"></textarea></div>
      <div class="col-md-6"><label class="form-label">Dedicate Donation</label><textarea class="form-control" name="dedication" rows="3"></textarea></div>

      <div class="col-md-12">
        <button type="submit" class="btn btn-primary submit-btn">Donate</button>
        <p id="paypal-success-msg" class="text-success mt-2" style="display: none;">✅ Donation completed via PayPal. No need to click Donate.</p>
      </div>
    </form>
  </div>
</section>

<footer class="d-flex align-items-center justify-content-between p-5">
  <!-- Your existing footer code remains unchanged -->
</footer>

<script src="<%= request.getContextPath() %>/js/navigation.js"></script>

<script>
  // Manual form submission to Google Script
  document.querySelector(".submit-btn").addEventListener("click", function (e) {
    e.preventDefault();
    const form = document.querySelector("#donationForm");
    const formData = new FormData(form);
    const scriptURL = "https://script.google.com/macros/s/AKfycbxJ3czTlx6jK--OnSx-WUtQ7jgd2jroghlhEvoTrsPXOu307mRSF39DvW7zzWKLvXic/exec";

    fetch(scriptURL, {
      method: "POST",
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      if (data.result === "success") {
        alert("🎉 Donation submitted successfully! Thank you.");
        form.reset();
        document.getElementById("billadd").readOnly = false;
      } else {
        alert("❌ Error: " + data.message);
      }
    })
    .catch(error => {
      console.error("Error!", error);
      alert("❌ Something went wrong. Please try again.");
    });
  });

  // Copy address
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

  // Reveal PayPal button if donation amount > 0
  const amountField = document.getElementById("donateamount");
  const paypalContainer = document.getElementById("paypal-container");

  amountField.addEventListener("input", () => {
    const amount = parseFloat(amountField.value);
    paypalContainer.style.display = (!isNaN(amount) && amount > 0) ? "block" : "none";
  });

  // PayPal logic
  paypal.Buttons({
    createOrder: function (data, actions) {
      const amount = document.getElementById("donateamount").value;
      if (!amount || parseFloat(amount) <= 0) {
        alert("Please enter a valid donation amount.");
        throw new Error("Invalid amount");
      }

      return fetch('<%=request.getContextPath()%>/create-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ amount: amount })
      }).then(res => res.json()).then(data => data.id);
    },

    onApprove: function (data, actions) {
      return fetch('<%=request.getContextPath()%>/capture-order?orderID=' + data.orderID, {
        method: 'POST'
      })
      .then(res => res.json())
      .then(details => {
		const formName = document.querySelector('input[name="name"]').value;
		alert("✅ PayPal donation complete. Thank you, " + (formName || details.payer.name.given_name) + "!");


        const form = document.querySelector("#donationForm");
        const formData = new FormData(form);

        fetch("https://script.google.com/macros/s/AKfycbxJ3czTlx6jK--OnSx-WUtQ7jgd2jroghlhEvoTrsPXOu307mRSF39DvW7zzWKLvXic/exec", {
          method: "POST",
          body: formData
        });

        form.reset();
        document.getElementById("billadd").readOnly = false;
        document.querySelector(".submit-btn").disabled = true;
        document.getElementById("paypal-success-msg").style.display = "block";
      });
    },

    onError: function (err) {
      console.error(err);
      alert("❌ PayPal payment failed.");
    }
  }).render('#paypal-button-container');
</script>

</body>
</html>
