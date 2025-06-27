<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>MerryMeal</title>

  <!-- CSS -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/Header.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/Footer.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/DonationPage.css">

  <!-- PayPal SDK  + SweetAlert2 -->
  <script src="https://www.paypal.com/sdk/js?client-id=Abo2xKMyjhGEjkxb-a1evrmiDjsyItqJeVStljHTLAte37mErt_ixDeIQ-jci01PP5JF4o4mdKv9y8d0&currency=USD"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
  <!-- ========== HEADER (simplified placeholder) ======================== -->
  <header id="site-header" class="d-flex align-items-center justify-content-between p-3">
    <!-- your real header here -->
  </header>

  <!-- ========== DONATION FORM ========================================= -->
  <section class="Memform-section d-flex justify-content-center">
    <div class="Memform-container">
      <div class="text-center mb-4"><h1>Donation Form</h1></div>

      <form class="row g-3" id="donationForm">
        <!-- Donor Info -->
        <h2>Donor Information</h2>
        <div class="col-md-6"><label>*Name</label><input  type="text" class="form-control" name="name"    required></div>
        <div class="col-md-6"><label>*Email</label><input type="email" class="form-control" name="email"   required></div>
        <div class="col-md-6"><label>*Phone Number</label><input type="tel"  class="form-control" name="number"  required></div>
        <div class="col-md-6"><label>*Address</label><input type="text" class="form-control" name="address" id="address" required></div>

        <!-- Donor Details -->
        <h2>Donor Details</h2>
        <div class="col-md-6">
          <label>*Donation Amount ($)</label>
          <input type="number" class="form-control" id="donateamount" name="donateamount" required>
        </div>
        <div class="col-md-6">
          <fieldset class="mb-3">
            <legend>*Frequency</legend>
            <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="ONE-TIME" checked><label class="form-check-label">One Time</label></div>
            <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="MONTHLY"><label class="form-check-label">Monthly</label></div>
            <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="QUARTERLY"><label class="form-check-label">Quarterly</label></div>
            <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="ANNUALLY"><label class="form-check-label">Annually</label></div>
          </fieldset>
        </div>
        <div class="col-md-12"><label>Purpose / Campaign</label><textarea class="form-control" name="purpose" rows="3"></textarea></div>

        <!-- Payment (card placeholders) -->
        <h2>Payment Information</h2>
        <div class="col-md-6"><label>*Card Number</label><input type="number" class="form-control" name="cardnum" required></div>
        <div class="col-md-6"><label>*Expiry Date</label><input type="date"   class="form-control" name="expdate" required></div>
        <div class="col-md-6"><label>*CVV</label><input type="num"    class="form-control" name="cvv"    required></div>

        <!-- PayPal button container -->
        <div class="col-md-12" id="paypal-container" style="display:none">
          <p><strong>Or donate with PayPal:</strong></p>
          <div id="paypal-button-container"></div>
        </div>

        <!-- Billing -->
        <div class="col-md-6">
          <label>*Billing Address</label>
          <input type="text" class="form-control" name="billadd" id="billadd" required>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="checkbox" id="sameasdonadd">
            <label class="form-check-label">Same as Donor Address</label>
          </div>
        </div>

        <!-- Options -->
        <h2>Other Options</h2>
        <div class="col-md-12">
          <div class="form-check"><input class="form-check-input" type="checkbox" name="subnews"><label class="form-check-label">Subscribe To Newsletter</label></div>
          <div class="form-check"><input class="form-check-input" type="checkbox" name="anon"><label class="form-check-label">Anonymous Donation</label></div>
        </div>
        <div class="col-md-6"><label>Notes or Message</label><textarea class="form-control" name="notes" rows="3"></textarea></div>
        <div class="col-md-6"><label>Dedicate Donation</label><textarea class="form-control" name="dedication" rows="3"></textarea></div>

        <div class="col-md-12">
          <button type="submit" class="btn btn-primary submit-btn">Donate</button>
          <p id="paypal-success-msg" class="text-success mt-2" style="display:none">✅ Donation completed via PayPal. No need to click Donate.</p>
        </div>
      </form>
    </div>
  </section>

  <!-- FOOTER placeholder -->
  <footer class="d-flex align-items-center justify-content-between p-5">
    <!-- … -->
  </footer>

  <!-- ========== JS ===================================================== -->
  <script src="<%=request.getContextPath()%>/js/navigation.js"></script>

  <script>
    /* Manual / non-PayPal submission ----------------------------------- */
    document.querySelector(".submit-btn").addEventListener("click", e => {
      e.preventDefault();
      const formData = new FormData(document.querySelector("#donationForm"));
      fetch("https://script.google.com/macros/s/AKfycbxJ3czTlx6jK--OnSx-WUtQ7jgd2jroghlhEvoTrsPXOu307mRSF39DvW7zzWKLvXic/exec",
            { method:"POST", body:formData })
      .then(r => r.json())
      .then(d => {
        if (d.result === "success") {
          Swal.fire({ icon:"success",
                      title:"Thank You!",
                      html:'🎉 Your donation was submitted successfully.<br><br><a href="Homepage.jsp" class="btn btn-success">Return to Homepage</a>',
                      showConfirmButton:false });
          document.querySelector("#donationForm").reset();
          document.getElementById("billadd").readOnly = false;
        } else {
          Swal.fire({ icon:"error", title:"Oops!", text:d.message });
        }
      })
      .catch(err => {
        console.error(err);
        Swal.fire({ icon:"error", title:"Oops!", text:"Something went wrong." });
      });
    });

    /* Copy donor → billing */
    const donorAddr = document.getElementById("address");
    const billAddr  = document.getElementById("billadd");
    const sameBox   = document.getElementById("sameasdonadd");
    sameBox.addEventListener("change", () => {
      billAddr.value   = sameBox.checked ? donorAddr.value : "";
      billAddr.readOnly = sameBox.checked;
    });
    donorAddr.addEventListener("input", () => {
      if (sameBox.checked) billAddr.value = donorAddr.value;
    });

    /* Show PayPal button only when amount > 0 */
    const amountField = document.getElementById("donateamount");
    const ppContainer = document.getElementById("paypal-container");
    amountField.addEventListener("input", () => {
      const a = parseFloat(amountField.value);
      ppContainer.style.display = (!isNaN(a) && a > 0) ? "block" : "none";
    });

    /* ========== PayPal Buttons ======================================= */
    paypal.Buttons({
      createOrder: () => {
        const amt = amountField.value;
        if (!amt || parseFloat(amt) <= 0) {
          Swal.fire("Please enter a valid donation amount.");
          throw new Error("Invalid amount");
        }
        return fetch('<%=request.getContextPath()%>/create-order', {
                 method:"POST",
                 headers:{ "Content-Type":"application/json" },
                 body:JSON.stringify({ amount:amt }) })
               .then(r => r.json())
               .then(d => d.id);
      },

      onApprove: (data, actions) => {
        /* 1️⃣  Get order details then capture */
        return actions.order.get()
          .then(orderData =>
            fetch('<%=request.getContextPath()%>/capture-order?orderID=' + data.orderID,
                  { method:"POST" })
            .then(() => orderData)
          )
          .then(details => {
            /* 2️⃣  Extract PayPal name & address */
            let payName = "";
            if (details.payer?.name?.given_name) {
              payName = `${details.payer.name.given_name} ${details.payer.name.surname}`.trim();
            } else if (details.purchase_units?.[0]?.shipping?.name?.full_name) {
              payName = details.purchase_units[0].shipping.name.full_name.trim();
            }

            const addrObj = details.purchase_units?.[0]?.shipping?.address || {};
            const payAddr = [addrObj.address_line_1,
                             addrObj.admin_area_2,
                             addrObj.postal_code,
                             addrObj.country_code]
                            .filter(Boolean).join(", ");

            /* 3️⃣  Fill hidden form inputs if blank */
            const form   = document.querySelector("#donationForm");
            const nameIn = form.querySelector('input[name="name"]');
            const addrIn = document.getElementById("address");
            if (!nameIn.value.trim() && payName) nameIn.value = payName;
            if (!addrIn.value.trim() && payAddr) addrIn.value = payAddr;

            /* 4️⃣  Build FormData for Apps Script & DB */
            const fd = new FormData(form);
            fd.set("name",    nameIn.value.trim());
            fd.set("address", addrIn.value.trim());
            fd.delete("sameasdonadd");
            fd.delete("anon");
            fd.delete("subnews");

            /* 5️⃣  Send in parallel */
            return Promise.all([
              fetch("https://script.google.com/macros/s/AKfycbxJ3czTlx6jK--OnSx-WUtQ7jgd2jroghlhEvoTrsPXOu307mRSF39DvW7zzWKLvXic/exec",
                    { method:"POST", body:fd }),
              fetch("<%=request.getContextPath()%>/record-donation",
                    { method:"POST", body:fd })
            ]).then(() => fd);   // pass fd down
          })
          .then(fd => {
            /* 6️⃣  Success UI */
            Swal.fire({
              icon:"success",
              title:`Thank You, ${fd.get("name")}!`,
              html:'🎉 Your PayPal donation was successful.<br><br><a href="Homepage.jsp" class="btn btn-success">Return to Homepage</a>',
              showConfirmButton:false
            });

            const form = document.querySelector("#donationForm");
            form.reset();
            document.getElementById("billadd").readOnly = false;
            document.querySelector(".submit-btn").disabled = true;
            document.getElementById("paypal-success-msg").style.display = "block";
          })
          .catch(err => {
            console.error(err);
            Swal.fire({ icon:"error", title:"PayPal Payment Failed", text:"Please try again." });
          });
      },

      onError: err => {
        console.error(err);
        Swal.fire({ icon:"error", title:"PayPal Payment Failed", text:"Please try again." });
      }
    }).render("#paypal-button-container");
  </script>
</body>
</html>
