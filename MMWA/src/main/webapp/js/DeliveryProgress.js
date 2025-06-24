document.addEventListener("DOMContentLoaded", () => {
  const modal = document.querySelector(".client-modal");
  const closeBtn = modal.querySelector(".close-button");

  // Modal field references
  const modalName = document.getElementById("modal-client-name");
  const modalEmail = document.getElementById("modal-client-email");
  const modalPhone = document.getElementById("modal-client-phonenumber");
  const modalAddress = document.getElementById("modal-client-address");
  const modalDiet = document.getElementById("modal-client-diet");
  const modalMeal = document.getElementById("modal-client-meal");
  const modalDelivery = document.getElementById("modal-client-delivery");

  // 1. Show modal with data on card click
  document.querySelectorAll(".delivery-card").forEach((card) => {
    card.addEventListener("click", () => {
      modalName.textContent = `Client Name: ${card.dataset.name}`;
      modalEmail.textContent = `Email: ${card.dataset.email}`;
      modalPhone.textContent = `Phone number: ${card.dataset.phone}`;
      modalAddress.textContent = `Address: ${card.dataset.address}`;
      modalDiet.textContent = `Dietary request: ${card.dataset.diet}`;
      modalMeal.textContent = `Meal: ${card.dataset.meal}`;
      modalDelivery.textContent = `Delivery date: ${card.dataset.delivery}`;

      modal.classList.add("active");
    });
  });

  // 2. Close modal
  closeBtn.addEventListener("click", () => {
    modal.classList.remove("active");
  });

  modal.addEventListener("click", (e) => {
    if (e.target === modal) {
      modal.classList.remove("active");
    }
  });

  // 3. Handle status dropdown styling and change
  const statusDropdowns = document.querySelectorAll(".status-select");

  statusDropdowns.forEach((dropdown) => {
    updateDropdownColor(dropdown, dropdown.value);

    dropdown.addEventListener("click", (e) => {
      e.stopPropagation(); // Prevent opening modal
    });

    dropdown.addEventListener("change", (e) => {
      const newStatus = e.target.value;
      const card = e.target.closest(".delivery-card");

      card.classList.remove("pending", "out-for-delivery", "delivered");
      dropdown.classList.remove("pending", "out-for-delivery", "delivered");

      card.classList.add(newStatus);
      dropdown.classList.add(newStatus);

      updateDropdownColor(dropdown, newStatus);
    });
  });
});

// ✅ Helper function to color dropdowns
function updateDropdownColor(dropdown, status) {
  switch (status) {
    case "pending":
      dropdown.style.backgroundColor = "#ef4444"; // Red
      dropdown.style.color = "white";
      break;
    case "out-for-delivery":
      dropdown.style.backgroundColor = "#facc15"; // Yellow
      dropdown.style.color = "black";
      break;
    case "delivered":
      dropdown.style.backgroundColor = "#10b981"; // Green
      dropdown.style.color = "white";
      break;
    default:
      dropdown.style.backgroundColor = "";
      dropdown.style.color = "";
  }
}
