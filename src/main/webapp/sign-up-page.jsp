<%--
  Created by IntelliJ IDEA.
  User: charithharsha
  Date: 2025-01-19
  Time: 11:04 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="sign-up-page.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Create Account</title>
</head>
<body>
<div class="wrapper">
    <div class="container main">
        <div class="row">
            <div class="col-md-6 right">
                <div class="input-box">
                    <header>Create Account</header>
                    <form action="sign-up" method="post">
                        <div class="input-field">
                            <input type="text" name="name" id="name" class="input" required autocomplete="off">
                            <label for="name">Name</label>
                        </div>
                        <div class="input-field">
                            <input type="email" name="email" id="email" class="input" required autocomplete="off">
                            <label for="email">Email</label>
                        </div>
                        <div class="input-field">
                            <input type="password" name="password" class="input" id="pass" required>
                            <label for="pass">Password</label>
                        </div>
                        <div class="input-field">
                            <input type="submit" class="submit" value="Sign Up">
                        </div>
                    </form>
                    <%
                        String message = request.getParameter("message");
                        String error = request.getParameter("error");
                    %>

                    <%
                        if (message != null) {
                    %>
                    <p style="color: greenyellow" ><%= message %>
                    </p>
                    <%
                        }
                        if (error != null) {
                    %>
                    <h1 style="color: red"><%= error %>
                    </h1>
                    <%
                        }
                    %>
                    <div class="signin">
                        <span>Already have an account? <a href="sign-in-page.jsp">Sign in Now</a></span>
                    </div>
                </div>
            </div>
            <div class="col-md-6 side-image">
                <img src="computer%20Doctor%20Logo.png" alt="">
                <div class="text">
                    <p>We Have Solution For Your All Computer Problems</p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>