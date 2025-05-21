<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get user from session
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // User not logged in, redirect to login
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    // Get the initials for the avatar
    String initials = "";
    if (user.getUserName() != null && !user.getUserName().isEmpty()) {
        initials = user.getUserName().substring(0, 1).toUpperCase();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - Eventify</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background-color: #f4f7fa;
            font-family: 'Inter', sans-serif;
            color: #333;
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        .main-content {
            flex: 1;
            padding: 40px 20px;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }
        
        /* Profile Layout */
        .profile-container {
            display: flex;
            gap: 30px;
            max-width: 1000px;
            margin: 0 auto;
        }
        
        .profile-sidebar {
            width: 300px;
            flex-shrink: 0;
        }
        
        .profile-main {
            flex: 1;
        }
        
        /* Profile Card */
        .profile-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
        }
        
        /* Profile Header */
        .profile-avatar-section {
            background: linear-gradient(135deg, #00574b 0%, #007c6c 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
            position: relative;
        }
        
        .avatar {
            width: 100px;
            height: 100px;
            background: #00574b;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin: 0 auto 15px;
            font-weight: 600;
            border: 3px solid white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            font-family: 'Montserrat', sans-serif;
        }
        
        .profile-name {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 5px;
            font-family: 'Montserrat', sans-serif;
        }
        
        .profile-username {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 10px;
            font-size: 15px;
        }
        
        .profile-role {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }
        
        /* For regular user role */
        .role-user {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
        
        /* For admin role */
        .role-admin {
            background-color: #e3f2fd;
            color: #1565c0;
        }
        
        /* Navigation Menu */
        .profile-nav {
            padding: 20px;
        }
        
        .nav-item {
            display: flex;
            align-items: center;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 8px;
            color: #333;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .nav-item:hover {
            background: #f5f7fa;
        }
        
        .nav-item.active {
            background: #f0f9f7;
            color: #00574b;
            font-weight: 500;
        }
        
        .nav-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
            font-size: 16px;
            color: #00574b;
        }
        
        /* Information Card */
        .info-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        }
        
        .info-header {
            padding: 20px 30px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }
        
        .info-title {
            font-size: 20px;
            font-weight: 600;
            display: flex;
            align-items: center;
            font-family: 'Montserrat', sans-serif;
            color: #00574b;
        }
        
        .info-title i {
            margin-right: 10px;
            font-size: 18px;
        }
        
        .info-content {
            padding: 30px;
        }
        
        /* Alert Messages */
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
        }
        
        .alert-error {
            background-color: #ffebee;
            color: #c62828;
            border-left: 4px solid #c62828;
        }
        
        .alert-success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border-left: 4px solid #2e7d32;
        }
        
        .alert i {
            margin-right: 10px;
            font-size: 18px;
        }
        
        /* Form Styles */
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #495057;
            font-size: 15px;
        }
        
        .form-field {
            position: relative;
        }
        
        .form-field i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 14px 12px 40px;
            font-size: 15px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            transition: all 0.3s;
            background-color: #f8f9fa;
            color: #495057;
            font-family: 'Inter', sans-serif;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #00574b;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(0, 87, 75, 0.1);
        }
        
        .form-control::placeholder {
            color: #adb5bd;
        }
        
        .form-help {
            margin-top: 5px;
            font-size: 13px;
            color: #6c757d;
        }
        
        /* Password strength indicator */
        .password-strength {
            height: 5px;
            border-radius: 3px;
            margin-top: 8px;
            overflow: hidden;
        }
        
        .password-strength-meter {
            height: 100%;
            width: 0%;
            background: #e9ecef;
            transition: width 0.3s, background 0.3s;
        }
        
        .weak {
            background: #f44336;
            width: 33%;
        }
        
        .medium {
            background: #ff9800;
            width: 66%;
        }
        
        .strong {
            background: #4caf50;
            width: 100%;
        }
        
        /* Button styles */
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 15px;
        }
        
        .btn i {
            margin-right: 10px;
        }
        
        .btn-primary {
            background: #00574b;
            color: white;
            box-shadow: 0 4px 10px rgba(0, 87, 75, 0.2);
        }
        
        .btn-primary:hover {
            background: #004a3f;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 87, 75, 0.3);
        }
        
        .btn-outline {
            border: 2px solid #00574b;
            color: #00574b;
            background: transparent;
        }
        
        .btn-outline:hover {
            background: rgba(0, 87, 75, 0.05);
            transform: translateY(-2px);
        }
        
        /* Toggle Password Visibility */
        .password-toggle {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            cursor: pointer;
            font-size: 14px;
        }
        
        /* Responsive Design */
        @media (max-width: 900px) {
            .profile-container {
                flex-direction: column;
            }
            
            .profile-sidebar {
                width: 100%;
            }
        }
        
        @media (max-width: 768px) {
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/view/navbar.jsp" />
    
    <div class="main-content">
        <div class="profile-container">
            <!-- Left Sidebar -->
            <div class="profile-sidebar">
                <div class="profile-card">
                    <div class="profile-avatar-section">
                        <div class="avatar">
                            <%= initials %>
                        </div>
                        <h2 class="profile-name"><%= user.getUserName() %></h2>
                        <p class="profile-username">@<%= user.getUserName() %></p>
                        <span class="profile-role <%= "ADMIN".equals(user.getRole()) ? "role-admin" : "role-user" %>"><%= user.getRole() %></span>
                    </div>
                    
                    <div class="profile-nav">
                        <a href="${pageContext.request.contextPath}/" class="nav-item">
                            <i class="fas fa-home"></i> Home
                        </a>
                        <a href="${pageContext.request.contextPath}/events" class="nav-item">
                            <i class="fas fa-calendar-alt"></i> My Events
                        </a>
                        <a href="${pageContext.request.contextPath}/profile" class="nav-item">
                            <i class="fas fa-user"></i> Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/resetpassword" class="nav-item active">
                            <i class="fas fa-key"></i> Change Password
                        </a>
                        <% if ("ADMIN".equals(user.getRole())) { %>
                            <a href="${pageContext.request.contextPath}/AdminDashboard" class="nav-item">
                                <i class="fas fa-th-large"></i> Dashboard
                            </a>
                            <a href="${pageContext.request.contextPath}/EventDashboard" class="nav-item">
                                <i class="fas fa-calendar-check"></i> Manage Events
                            </a>
                            <a href="${pageContext.request.contextPath}/VenueDashboard" class="nav-item">
                                <i class="fas fa-map-marker-alt"></i> Manage Venues
                            </a>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/logout" class="nav-item">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="profile-main">
                <div class="info-card">
                    <div class="info-header">
                        <h3 class="info-title">
                            <i class="fas fa-key"></i> Change Password
                        </h3>
                    </div>
                    
                    <div class="info-content">
                        <% 
                            // Display error message if available
                            String error = (String) request.getAttribute("error");
                            if (error != null) {
                        %>
                            <div class="alert alert-error">
                                <i class="fas fa-exclamation-circle"></i> <%= error %>
                            </div>
                        <% } %>
                        
                        <form action="${pageContext.request.contextPath}/resetpassword" method="post" id="passwordForm">
                            <div class="form-group">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <div class="form-field">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" id="currentPassword" name="currentPassword" class="form-control" required>
                                    <span class="password-toggle" onclick="togglePasswordVisibility('currentPassword')">
                                        <i class="fas fa-eye"></i>
                                    </span>
                                </div>
                                <p class="form-help">Enter your current password for verification</p>
                            </div>
                            
                            <div class="form-group">
                                <label for="newPassword" class="form-label">New Password</label>
                                <div class="form-field">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" id="newPassword" name="newPassword" class="form-control" required onkeyup="checkPasswordStrength()">
                                    <span class="password-toggle" onclick="togglePasswordVisibility('newPassword')">
                                        <i class="fas fa-eye"></i>
                                    </span>
                                </div>
                                <div class="password-strength">
                                    <div class="password-strength-meter" id="password-strength-meter"></div>
                                </div>
                                <p class="form-help">Use at least 6 characters including letters, numbers, and symbols</p>
                            </div>
                            
                            <div class="form-group">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <div class="form-field">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required onkeyup="checkPasswordMatch()">
                                    <span class="password-toggle" onclick="togglePasswordVisibility('confirmPassword')">
                                        <i class="fas fa-eye"></i>
                                    </span>
                                </div>
                                <p class="form-help" id="password-match-status">Re-enter your new password to confirm</p>
                            </div>
                            
                            <div class="action-buttons">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Update Password
                                </button>
                                <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/view/footer.jsp" />
    
    <script>
        // Toggle password visibility
        function togglePasswordVisibility(inputId) {
            const passwordInput = document.getElementById(inputId);
            const icon = passwordInput.nextElementSibling.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
        
        // Check password strength
        function checkPasswordStrength() {
            const password = document.getElementById('newPassword').value;
            const meter = document.getElementById('password-strength-meter');
            
            // Reset meter
            meter.className = '';
            
            // Check password strength
            if (password.length === 0) {
                meter.style.width = '0%';
                return;
            }
            
            // Simple strength check
            let strength = 0;
            
            // Length check
            if (password.length >= 6) strength += 1;
            
            // Character type checks
            if (/[A-Z]/.test(password)) strength += 1;
            if (/[a-z]/.test(password)) strength += 1;
            if (/[0-9]/.test(password)) strength += 1;
            if (/[^A-Za-z0-9]/.test(password)) strength += 1;
            
            // Set meter class based on strength
            if (strength <= 2) {
                meter.classList.add('weak');
            } else if (strength <= 4) {
                meter.classList.add('medium');
            } else {
                meter.classList.add('strong');
            }
        }
        
        // Check if passwords match
        function checkPasswordMatch() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const statusElement = document.getElementById('password-match-status');
            
            if (confirmPassword.length === 0) {
                statusElement.textContent = 'Re-enter your new password to confirm';
                statusElement.style.color = '#6c757d';
                return;
            }
            
            if (newPassword === confirmPassword) {
                statusElement.textContent = 'Passwords match';
                statusElement.style.color = '#2e7d32';
            } else {
                statusElement.textContent = 'Passwords do not match';
                statusElement.style.color = '#c62828';
            }
        }
    </script>
</body>
</html>
