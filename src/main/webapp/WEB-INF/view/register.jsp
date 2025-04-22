<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Eventify</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/register.css">
</head>
<body>
<div class="main-container">
    <!-- Left side - Event Image -->
    <div class="image-container">
        <img src="${pageContext.request.contextPath}/assets/images/image2.png" alt="Description" style="width: 100%; height: auto;" />
    </div>

    <!-- Right side - Registration Form -->
    <div class="form-container">
        <div class="register-box">
            <h1 class="logo">Eventify</h1>
            <h2 class="welcome-text">Join us in our community</h2>

            <!-- Display messages if present -->
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" class="register-form">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-user icon"></i>
                        <input type="text" id="username" name="username" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-envelope icon"></i>
                        <input type="email" id="email" name="email" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-lock icon"></i>
                        <input type="password" id="password" name="password" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password:</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-lock icon"></i>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-create">
                    <i class="fa-solid fa-user-plus"></i> Create Account
                </button>
            </form>

            <div class="login-link">
                <a href="${pageContext.request.contextPath}/LoginServlet" class="btn btn-login">
                    <i class="fa-solid fa-right-to-bracket"></i> Already have an account? login
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>