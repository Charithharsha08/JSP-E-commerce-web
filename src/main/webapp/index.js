$(document).ready(function () {
    console.log("ready");
    getCaegories();
})
/*
$(document).ready(function () {
    const productBar = $("#product-bar");

    // Toggle product bar visibility
    $("#show-products").on("click", function (e) {
        e.preventDefault();
        if (productBar.css("top") === "35px") {
            productBar.css("top", "-100%"); // Move up
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
});
*/

/*
const getCaegories= () => {
        $.ajax(
            {
                url: "getCategories",
                method: "GET",
                success: (data) => {
                   data.forEach((category) => {
                       $("#nav-category").append(`
                       <li class="nav-item">
                    <a class="nav-link text-white" href="product-page.jsp">$.{category.name}</a>
                </li>
                       `)
                   })
                }
            }
        )
}
*/

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
            fetch("logout", { method: "GET" }) // Ensure the method is GET
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

