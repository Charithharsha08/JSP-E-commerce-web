$(document).ready(function () {
    console.log("ready");
    fetchCategories();
})
/*$(document).ready(function () {
    const productBar = $("#product-bar");

    // Toggle product bar visibility
    $("#show-products").on("click", function (e) {
        e.preventDefault();
        if (productBar.css("top") === "35px") {
            productBar.css("top", "-100%");// Move up
        } else {
            productBar.css("top", "35px"); // Move down
        }
    });

    // Hide product bar when clicking outside
    $(document).on("click", function (e) {
        if (
            !$(e.target).closest("#product-bar").length &&
            !$(e.target).is("#show-products")
        ) {
            productBar.css("top", "-100%"); // Move up
        }
    });

    // Hide product bar when clicking on a product inside it
    $("#product-bar .product-bar-item a").on("click", function () {
        productBar.css("top", "-100%"); // Move up
    });
});*/

function fetchCategories() {
    console.log("fetching categories")
$.ajax({
    url: "GetCategory",
    method: "GET",
    success: (data) => {
       console.log(data)
    }
})
}


document.addEventListener("DOMContentLoaded", function () {
    const userButton = document.getElementById("user-button");
    const showLoginButton = document.getElementById("show-login");
    const logoutButton = document.getElementById("logout-button");

    // If user is logged in, show the modal on user button click
    if (userButton) {
        userButton.addEventListener("click", function (e) {
            e.preventDefault();
            const userDetailsModal = new bootstrap.Modal(
                document.getElementById("userDetailsModal")
            );
            userDetailsModal.show();
        });
    }

    // Handle logout
    if (logoutButton) {
        logoutButton.addEventListener("click", function (e) {
            console.log("Logout button clicked");
            fetch("logout", {method: "GET"}) // Ensure the method is GET
                .then(() => {
                    console.log("Successfully logged out");
                    window.location.href = "index.jsp"; // Redirect to login page or home after logout
                })
                .catch((error) => console.error("Logout failed:", error));
        });
    }

    // Redirect to sign-in page on login button click
    if (showLoginButton) {
        showLoginButton.addEventListener("click", function (e) {
            e.preventDefault();
            window.location.href = "sign-in-page.jsp"; // Adjust your login page URL
        });
    }
});

document.addEventListener('DOMContentLoaded', function () {
    const toastElement = document.querySelector('.toast');
    const toast = new bootstrap.Toast(toastElement);
    toast.show();
});

/*
cart JS
*/

// Get references to elements
const cartPanel = document.getElementById('cartPanel');
const openCartBtn = document.getElementById('openCart');
const closeCartBtn = document.getElementById('closeCart');

// Show the cart panel
openCartBtn.addEventListener('click', (e) => {
    e.preventDefault();
    cartPanel.classList.add('active');
});

// Hide the cart panel
closeCartBtn.addEventListener('click', () => {
    cartPanel.classList.remove('active');
});


function addToCart(button) {
    // Retrieve product information from data-* attributes
    const productId = button.getAttribute("data-product-id");
    const categoryId = button.getAttribute("data-category-id");
    const productName = button.getAttribute("data-product-name");
    const productImage = button.getAttribute("data-product-image");
    const productDescription = button.getAttribute("data-product-description");
    const productPrice = parseFloat(button.getAttribute("data-product-price")); // Ensure it's a number

    // Calculate total for 1 quantity (default)
    const itemTotal = productPrice;

    // Create a cart item object (optional for reference)
    const item = {
        id: productId,
        name: productName,
        image: productImage,
        description: productDescription,
        quantity: 1,
        price: productPrice,
        total: itemTotal,
    };

    // Update the cart item div
    const cartItemContainer = document.getElementById("cartItemContainer"); // Replace with your cart container's ID
    const cartItemDiv = document.createElement("div");
    cartItemDiv.className = "d-flex align-items-center border-bottom pb-3 mb-3";
    cartItemDiv.setAttribute("data-item-total", itemTotal); // Store total for easy access on removal

    cartItemDiv.innerHTML = `
        <img src="${productImage}" class="img-fluid me-3" style="width: 60px;" alt="${productName}">
        <div>
            <h6 class="mb-1">${productName}</h6>
            <p class="mb-0">Quantity: 1 x Rs${productPrice} = Rs${itemTotal}</p>
        </div>
        <button class="btn btn-danger ms-auto" onclick="removeItem(this, ${itemTotal})">Remove</button>
    `;
    cartItemContainer.appendChild(cartItemDiv);

    // Update the order summary
    updateOrderSummary(itemTotal);
}

// Function to update the order summary
function updateOrderSummary(change) {
    const subtotalElement = document.getElementById("subtotal"); // Replace with your subtotal span's ID
    const totalElement = document.getElementById("total"); // Replace with your total span's ID

    // Parse current values
    const currentSubtotal = parseFloat(subtotalElement.textContent.replace("Rs", "")) || 0;

    // Update subtotal and total
    const updatedSubtotal = currentSubtotal + change;
    const shippingCost = 20; // Fixed shipping cost
    const updatedTotal = updatedSubtotal + shippingCost;

    subtotalElement.textContent = `Rs${updatedSubtotal.toFixed(2)}`;
    totalElement.textContent = `Rs${updatedTotal.toFixed(2)}`;
}

// Function to remove an item from the cart
function removeItem(button, itemTotal) {
    const cartItem = button.parentElement;
    const cartContainer = document.getElementById("cartItemContainer");

    // Remove the cart item from the DOM
    cartContainer.removeChild(cartItem);

    // Update the order summary
    updateOrderSummary(-itemTotal);
}

function deleteProduct(button) {
    const productId = button.getAttribute("data-product-id");
    const csrfToken = button.getAttribute("data-csrf-token");
    const csrfHeader = button.getAttribute("data-csrf-header");

    $.ajax({
        url: "delete-Product",
        method: "POST",
        data: {
            productId: productId,
            _csrf: csrfToken
        },
        headers: {
            "X-CSRF-TOKEN": csrfHeader
        },
        success: function (response) {
            if (response.status === "success") {
                button.closest(".product").remove();
            } else {
                console.error("Failed to delete product:", response.message);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error deleting product:", error);
        }
    });
}