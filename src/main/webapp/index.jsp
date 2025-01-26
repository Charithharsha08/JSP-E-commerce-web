<%@ page import="lk.ijse.computerdoctorecom.DTO.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Computer Doctor</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
          integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="code.jquery.com_jquery-3.7.0.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery library -->
</head>
<body>
<%
    User user = null;
    try {
        user = (User) request.getServletContext().getAttribute("user");
    } catch (Exception e) {
%>
<div class="toast-container position-fixed top-0 end-0 p-3">
    <div class="toast show align-items-center text-bg-danger border-0" role="alert" aria-live="assertive"
         aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <strong>Alert!</strong> Please Login First.
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                    aria-label="Close"></button>
        </div>
    </div>
</div>
<%
    }
    boolean isLoggedIn = false;
    if (user != null) {
        String name = user.getName();
        String password = user.getPassword();
        String email = user.getEmail();
        String type = user.getType();
        isLoggedIn = email != null && type != null;

    }
    String login = request.getParameter("login");
    String error = request.getParameter("error");
    if (login != null) {
%>
<div class="toast-container position-fixed top-0 end-0 p-3">
    <div class="toast show align-items-center text-bg-success border-0" role="alert" aria-live="assertive"
         aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <strong>Success!</strong> You have logged in successfully.
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                    aria-label="Close"></button>
        </div>
    </div>
</div>
<%
    }
    if (error != null) {
%>
<div class="toast-container position-fixed top-0 end-0 p-3">
    <div class="toast show align-items-center text-bg-danger border-0" role="alert" aria-live="assertive"
         aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <strong>Error!</strong> Login failed.
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                    aria-label="Close"></button>
        </div>
    </div>
</div>
<%

    }
%>

<nav class="navbar navbar-expand-lg bg-black ">
    <div class="container ">
        <a class="navbar-brand text-white" href="#">Computer Doctor</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse " id="navbarNav">
            <ul class="navbar-nav ms-auto  " id="nav-category">
                <li class="nav-item text-white ">
                    <a class="nav-link active text-white" aria-current="page" href="get-product">Products</a>
                </li>
                <%
                    if (user != null) {
                        if (user.getType().equals("ADMIN")) {
                %>
                <button type="button" class="btn btn-none nav-link text-white" data-bs-toggle="modal"
                        data-bs-target="#staticBackdrop">
                    Add Category
                </button>
                <%
                        }
                    }
                %>
            </ul>
            <div class="ms-auto">
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-light border border-0" type="submit">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                    <button class="btn btn-outline-light border border-0" id="cart-button">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </button>
                    <%
                        if (isLoggedIn) {
                    %>
                    <button class="btn btn-outline-light border border-0" id="user-button">
                        <div class="d-flex align-items-center">
                            <i class="fa-solid fa-user"></i>
                            <p class="mb-0 ms-2"><%= user.getName() %>
                            </p>
                        </div>
                    </button>
                    <%
                    } else {
                    %>
                    <button class="btn btn-outline-light border border-0" id="show-login">
                        <i class="fa-solid fa-user"></i>
                    </button>
                    <%
                        }
                    %>
                </form>
            </div>
        </div>
    </div>
</nav>
<%--user details--%>
<div class="modal fade" id="userDetailsModal" tabindex="-1" aria-labelledby="userDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-end">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="userDetailsModalLabel">User Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <%
                    if (user != null) {
                %>
                <p><strong>Name:</strong> <span id="userName"><%= user.getName() %></span></p>
                <p><strong>Email:</strong> <span id="userEmail"><%= user.getEmail() %></span></p>
                <p><strong>Type:</strong> <span id="userPhone"><%= user.getType() %></span></p>
                <%
                    }
                %>
                <button class="btn btn-danger" id="logout-button">Logout</button>
            </div>
        </div>
    </div>
</div>


<!-- Hero Section -->
<section class="hero-section">
    <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="casing.jpg" class="d-block w-100" alt=" new arrival casing ">
            </div>
            <div class="carousel-item">
                <img src="roggamingcase.jpg" class="d-block w-100" alt="rog-gaming-case">
            </div>
            <div class="carousel-item">
                <img src="keyboard.jpg" class="d-block w-100" alt="new arrival keyboard">
            </div>
            <div class="carousel-item">
                <img src="liqwidcooler.jpg" class="d-block w-100" alt="new arrival liqwid cooler">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying"
                data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying"
                data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</section>
<section id="Laptop-video">
    <video muted src="2022%20Nitro%205%20%20Gaming%20Laptop%20%20Acer%20-%20Acer%20(720p,%20h264).mp4"
           class="object-fit-fill" autoplay></video>
</section>
<section class="Categories-link">
    <div class="motherboard">
        <a href="#"><img src="motherBoard%20new.png" class="img-fluid" alt="mother-boards-page"></a>
    </div>
    <div class="proccersor">
        <a href="#"><img src="ryzen%20processor.png" class="img-fluid" alt="proccersor"></a>
    </div>
</section>
<!-- Product Section -->
<%--

<!-- products-bar -->
<div class="container-fluid my-4 bg-black bg-opacity-75" id="product-bar">
    <div class="container">
        <div class="row g-4 ">
            <div class="col-6 col-sm-4 col-md-3">
                <div class="product-bar-item text-center">
                    <a href="product-page.jsp" class="text-decoration-none text-white">
                        <img src="assests/images/motherBoard.jpg" alt="motherBoard" class="img-fluid rounded">
                        <p class="mt-2 fw-bold">MOTHERBOARD</p>
                    </a>
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3">
                <div class="product-bar-item text-center">
                    <a href="#" class="text-decoration-none text-white">
                        <img src="assests/images/ram.jpg" alt="ram" class="img-fluid rounded">
                        <p class="mt-2 fw-bold">MEMORY</p>
                    </a>
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3">
                <div class="product-bar-item text-center">
                    <a href="#" class="text-decoration-none text-white">
                        <img src="assests/images/ssd.jpg" alt="SSD" class="img-fluid rounded">
                        <p class="mt-2 fw-bold">SSD</p>
                    </a>
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3">
                <div class="product-bar-item text-center">
                    <a href="#" class="text-decoration-none text-white">
                        <img src="assests/images/pws.jpg" alt="power-supply" class="img-fluid rounded">
                        <p class="mt-2 fw-bold">POWER SUPPLY</p>
                    </a>
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3">
                <div class="product-bar-item text-center">
                    <a href="#" class="text-decoration-none text-white">
                        <img src="assests/images/gpu.jpg" alt="graphics-card" class="img-fluid rounded">
                        <p class="mt-2 fw-bold">GRAPHICS CARD</p>
                    </a>
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3">
                <div class="product-bar-item text-center">
                    <a href="#" class="text-decoration-none text-white">
                        <img src="assests/images/casing%20copy.jpg" alt="pc-case" class="img-fluid rounded">
                        <p class="mt-2 fw-bold">PC CASE</p>
                    </a>
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3">
                <div class="product-bar-item text-center">
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-none" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                        <img src="assests/images/category/add%20product.png" alt="pc-case" class="img-fluid rounded">
                    </button>
                    <p class="mt-2 fw-bold text-decoration-none text-white">ADD CATEGORY</p>
                </div>
            </div>
        </div>
    </div>
</div>


--%>
<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">ADD CATEGORY</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="category" enctype="multipart/form-data" method="post">
                    <div class="input-field">
                        <input type="text" class="form-control " id="categoryName" name="categoryName"
                               placeholder="Category Name" required>
                    </div>
                    <div class="input-field">
                        <input type="file" class="form-control " id="categoryImage" name="categoryImage"
                               placeholder="Category Image" required>
                    </div>
                    <input type="submit" class="btn btn-dark " value="Save">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

                </form>
            </div>
        </div>
    </div>
</div>


<footer style="background-color: #111; color: #fff; padding: 40px 20px;">
    <div class="container">
        <div class="row">
            <!-- Company Section -->
            <div class="col-md-3">
                <h5>COMPANY</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="footer-link">About</a></li>
                    <li><a href="#" class="footer-link">Careers</a></li>
                    <li><a href="#" class="footer-link">Contact</a></li>
                    <li><a href="#" class="footer-link">Invest With Us</a></li>
                    <li><a href="#" class="footer-link">Hitawathkama</a></li>
                    <li><a href="#" class="footer-link">Mega Triple</a></li>
                    <li><a href="#" class="footer-link">Team</a></li>
                    <li><a href="#" class="footer-link">Wholesale</a></li>
                </ul>
            </div>
            <!-- Brands Section -->
            <div class="col-md-3">
                <h5>BRANDS</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="footer-link">Arctic</a></li>
                    <li><a href="#" class="footer-link">Thermaltake</a></li>
                    <li><a href="#" class="footer-link">Addlink</a></li>
                    <li><a href="#" class="footer-link">Keychron</a></li>
                    <li><a href="#" class="footer-link">Asus</a></li>
                    <li><a href="#" class="footer-link">MSI</a></li>
                    <li><a href="#" class="footer-link">Corsair</a></li>
                    <li><a href="#" class="footer-link">MarsRhino</a></li>
                </ul>
            </div>
            <!-- Support Section -->
            <div class="col-md-3">
                <h5>SUPPORT</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="footer-link">FAQ</a></li>
                    <li><a href="#" class="footer-link">Shipping</a></li>
                    <li><a href="#" class="footer-link">Returns & Refunds</a></li>
                    <li><a href="#" class="footer-link">Where to Buy</a></li>
                    <li><a href="#" class="footer-link">Build My PC</a></li>
                    <li><a href="#" class="footer-link">PC Customization</a></li>
                    <li><a href="#" class="footer-link">PC Services</a></li>
                    <li><a href="#" class="footer-link">Warranty</a></li>
                </ul>
            </div>
            <!-- Contact Section -->
            <div class="col-md-3">
                <h5>CONTACT</h5>
                <div class="social-icons">
                    <a href="#" class="footer-icon"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="footer-icon"><i class="fab fa-youtube"></i></a>
                    <a href="#" class="footer-icon"><i class="fab fa-twitch"></i></a>
                    <a href="#" class="footer-icon"><i class="fab fa-facebook"></i></a>
                    <a href="#" class="footer-icon"><i class="fab fa-discord"></i></a>
                    <a href="#" class="footer-icon"><i class="fab fa-tiktok"></i></a>
                </div>
            </div>
        </div>
        <hr style="border-top: 1px solid #444;">
        <div class="text-center">
            <p class="mb-0">© 2024 All rights reserved by Computer Doctor.</p>
            <p><a href="#" class="footer-link">Privacy Policy</a> | <a href="#" class="footer-link">Terms of Use</a></p>
        </div>
    </div>
</footer>

<script src="index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
</body>
</html>