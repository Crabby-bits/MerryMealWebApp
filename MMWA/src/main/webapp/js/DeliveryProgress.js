document.addEventListener("DOMContentLoaded", () => {
  const statusDropdowns = document.querySelectorAll(".status-select");

  statusDropdowns.forEach((dropdown) => {
    dropdown.addEventListener("click", (e) => {
      e.stopPropagation();
    });
  });

  statusDropdowns.forEach((dropdown) => {
    updateDropdownColor(dropdown, dropdown.value);

    dropdown.addEventListener("change", (e) => {
      const newStatus = e.target.value;

      const card = e.target.closest(".delivery-card");

      card.classList.remove("pending", "out-for-delivery", "delivered");
      dropdown.classList.remove("pending", "out-for-delivery", "delivered");

      card.classList.add(newStatus);
      dropdown.classList.add(newStatus);

      updateDropdownColor(dropdown, newStatus);

      console.log("Updated status to:", newStatus);
    });
  });
  const modal = document.querySelector(".client-modal");
  const closeBtn = modal.querySelector(".close-button");

  // Get modal elements
  const modalName = document.getElementById("modal-client-name");
  const modalEmail = document.getElementById("modal-client-email");
  const modalPhone = document.getElementById("modal-client-phonenumber");
  const modalAddress = document.getElementById("modal-client-address");
  const modalDiet = document.getElementById("modal-client-diet");
  const modalMeal = document.getElementById("modal-client-meal");
  const modalDelivery = document.getElementById("modal-client-delivery");

  // Show modal on card click
  document.querySelectorAll(".delivery-card").forEach((card) => {
    card.addEventListener("click", () => {
      modalName.textContent = `Client Name: ${card.dataset.name}`;
      modalEmail.textContent = `Email: ${card.dataset.email}`;
      modalPhone.textContent = `Phone number: ${card.dataset.phone}`;
      modalAddress.textContent = `Address: ${card.dataset.address}`;
      modalDiet.textContent = `Dietary request: ${card.dataset.diet}`;
      modalMeal.textContent = `Meal: ${card.dataset.meal}`;
      modalDelivery.textContent = `Delivery time: ${card.dataset.delivery}`;

      modal.classList.add("active");
    });
  });

  // Close modal
  closeBtn.addEventListener("click", () => {
    modal.classList.remove("active");
  });

  // Optional: Close modal when clicking outside the modal content
  modal.addEventListener("click", (e) => {
    if (e.target === modal) {
      modal.classList.remove("active");
    }
  });
});

// ✅ Helper function outside the event listener
function updateDropdownColor(dropdown, status) {
  switch (status) {
    case "pending":
      dropdown.style.backgroundColor = "#ef4444";
      dropdown.style.color = "white";
      break;
    case "out-for-delivery":
      dropdown.style.backgroundColor = "#facc15";
      dropdown.style.color = "black";
      break;
    case "delivered":
      dropdown.style.backgroundColor = "#10b981";
      dropdown.style.color = "white";
      break;
  }
}
