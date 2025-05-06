<%--
  Created by IntelliJ IDEA.
  User: koira
  Date: 4/1/2025
  Time: 3:27 PM
  To change this template use File | Settings | File Templates.
--%>
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
    if (user.getFullName() != null && !user.getFullName().isEmpty()) {
        String[] nameParts = user.getFullName().split(" ");
        if (nameParts.length > 1) {
            initials = (nameParts[0].substring(0, 1) + nameParts[nameParts.length - 1].substring(0, 1)).toUpperCase();
        } else {
            initials = user.getFullName().substring(0, Math.min(2, user.getFullName().length())).toUpperCase();
        }
    } else if (user.getUserName() != null && !user.getUserName().isEmpty()) {
        initials = user.getUserName().substring(0, Math.min(2, user.getUserName().length())).toUpperCase();
    }

    // Format creation date
    String createdAtString = "";
    if (user.getCreatedAt() != null) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMMM dd, yyyy");
        createdAtString = sdf.format(user.getCreatedAt());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Eventify</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body {
            background-color: #f5f7fa;
            font-family: 'Inter', sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        /* Navbar Styles */
        header {
            background-color: white;
            padding: 15px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .logo a {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            color: #006158;
            text-decoration: none;
            font-size: 24px;
            letter-spacing: -0.5px;
        }
        
        .nav-menu {
            display: flex;
            list-style-type: none;
            margin: 0;
            padding: 0;
            gap: 25px;
        }
        
        .nav-menu li a {
            color: #333;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            padding: 8px 12px;
            border-radius: 6px;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .nav-menu li a:hover {
            background-color: #f0f7f6;
            color: #006158;
        }
        
        .nav-menu li a i {
            font-size: 14px;
        }
        
        .search-bar {
            position: relative;
            width: 250px;
        }
        
        .search-bar input {
            width: 100%;
            padding: 10px 15px;
            padding-right: 40px;
            border: 1px solid #eaeaea;
            border-radius: 8px;
            font-size: 14px;
            background-color: #f8f9fa;
            transition: all 0.2s ease;
        }
        
        .search-bar input:focus {
            outline: none;
            border-color: #006158;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(0,97,88,0.1);
        }
        
        .search-bar i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #006158;
            cursor: pointer;
        }
        
        /* Make navbar responsive */
        @media (max-width: 768px) {
            header {
                flex-direction: column;
                padding: 15px;
            }
            
            .logo {
                margin-bottom: 15px;
            }
            
            .nav-menu {
                flex-wrap: wrap;
                justify-content: center;
                gap: 10px;
                margin-bottom: 15px;
            }
            
            .search-bar {
                width: 100%;
            }
        }
        
        /* Main Container */
        .main-container {
            padding: 40px 20px;
            flex: 1;
        }
        
        .profile-page {
            max-width: 1000px;
            margin: 0 auto;
        }
        
        .profile-grid {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 24px;
        }
        
        @media (max-width: 768px) {
            .profile-grid {
                grid-template-columns: 1fr;
            }
        }
        
        .page-title {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .back-link {
            font-size: 14px;
            color: #666;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s;
        }
        
        .back-link:hover {
            color: #006158;
        }
        
        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            overflow: hidden;
            height: fit-content;
        }
        
        .profile-sidebar {
            display: flex;
            flex-direction: column;
        }
        
        .profile-header {
            background: white;
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
        
        .avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #006158, #00887c);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            font-weight: 500;
            margin-bottom: 16px;
        }
        
        .profile-name {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            font-size: 20px;
            margin-bottom: 4px;
        }
        
        .profile-username {
            color: #666;
            font-size: 14px;
            margin-bottom: 16px;
        }
        
        .profile-role {
            display: inline-block;
            padding: 4px 12px;
            background-color: #e8f5f3;
            color: #006158;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
        }
        
        .profile-actions {
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        
        .btn {
            padding: 10px 16px;
            font-size: 14px;
            border-radius: 6px;
            font-weight: 500;
            text-align: center;
            transition: all 0.2s;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }
        
        .btn-primary {
            background: #006158;
            color: white;
            border: none;
        }
        
        .btn-primary:hover {
            background: #004d47;
        }
        
        .btn-secondary {
            background: white;
            color: #333;
            border: 1px solid #ddd;
        }
        
        .btn-secondary:hover {
            background: #f5f5f5;
            border-color: #ccc;
        }
        
        .btn-danger {
            background: white;
            color: #dc3545;
            border: 1px solid #dc3545;
        }
        
        .btn-danger:hover {
            background: #dc3545;
            color: white;
        }
        
        .profile-content {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }
        
        .info-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
        }
        
        .info-header {
            padding: 16px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .info-title {
            font-weight: 600;
            font-size: 16px;
            color: #333;
            margin: 0;
        }
        
        .info-icon {
            color: #006158;
            font-size: 14px;
        }
        
        .info-body {
            padding: 20px;
        }
        
        .info-group {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 16px;
            margin-bottom: 16px;
            align-items: center;
        }
        
        .info-group:last-child {
            margin-bottom: 0;
        }
        
        .info-label {
            font-size: 14px;
            color: #666;
            font-weight: 500;
        }
        
        .info-value {
            font-size: 14px;
            color: #333;
        }
        
        .alert {
            padding: 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .alert-success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border-left: 4px solid #4caf50;
        }
        
        .alert-error {
            background-color: #ffebee;
            color: #c62828;
            border-left: 4px solid #ef5350;
        }
        
        /* Footer Styles */
        footer {
            background-color: #006158;
            color: white;
            padding: 40px 20px;
            margin-top: 60px;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
        }
        
        .footer-section {
            display: flex;
            flex-direction: column;
        }
        
        .footer-section h3 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            font-size: 18px;
            margin-bottom: 20px;
            color: white;
        }
        
        .footer-section p {
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 16px;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .footer-section a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            margin-bottom: 12px;
            font-size: 14px;
            transition: all 0.2s ease;
            display: inline-block;
        }
        
        .footer-section a:hover {
            color: white;
            transform: translateX(3px);
        }
        
        .contact-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
            font-size: 14px;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .contact-item i {
            font-size: 16px;
            width: 18px;
            color: white;
        }
        
        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.4);
            backdrop-filter: blur(4px);
        }
        
        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 30px;
            border-radius: 12px;
            max-width: 450px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            position: relative;
        }
        
        .close {
            position: absolute;
            right: 20px;
            top: 20px;
            font-size: 20px;
            cursor: pointer;
            color: #999;
            transition: all 0.2s;
        }
        
        .close:hover {
            color: #333;
        }
        
        .modal-title {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            font-size: 20px;
            color: #333;
            margin-bottom: 16px;
        }
        
        .modal-message {
            font-size: 14px;
            color: #666;
            margin-bottom: 24px;
            line-height: 1.5;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 500;
            color: #333;
        }
        
        .form-group input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.2s;
        }
        
        .form-group input:focus {
            border-color: #006158;
            outline: none;
            box-shadow: 0 0 0 2px rgba(0,97,88,0.1);
        }
        
        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="main-container">
    <div class="profile-page">
        <h1 class="page-title">
            My Profile
            <a href="${pageContext.request.contextPath}/" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>
        </h1>

        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
        </div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <div class="profile-grid">
            <div class="profile-sidebar">
                <div class="card">
                    <div class="profile-header">
                        <div class="avatar">
                            <%= initials %>
                        </div>
                        <h2 class="profile-name"><%= user.getFullName() != null && !user.getFullName().isEmpty() ? user.getFullName() : user.getUserName() %></h2>
                        <p class="profile-username">@<%= user.getUserName() %></p>
                        <span class="profile-role"><%= user.getRole() %></span>
                    </div>
                    <div class="profile-actions">
                        <a href="${pageContext.request.contextPath}/profile/edit" class="btn btn-primary">
                            <i class="fas fa-edit"></i> Edit Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/reset-password" class="btn btn-secondary">
                            <i class="fas fa-key"></i> Change Password
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                        <button id="deleteAccountBtn" class="btn btn-danger">
                            <i class="fas fa-trash"></i> Delete Account
                        </button>
                    </div>
                </div>
            </div>

            <div class="profile-content">
                <div class="info-card">
                    <div class="info-header">
                        <i class="fas fa-user info-icon"></i>
                        <h3 class="info-title">Account Information</h3>
                    </div>
                    <div class="info-body">
                        <div class="info-group">
                            <div class="info-label">Username</div>
                            <div class="info-value"><%= user.getUserName() %></div>
                        </div>
                        <div class="info-group">
                            <div class="info-label">Email</div>
                            <div class="info-value"><%= user.getEmail() %></div>
                        </div>
                        <div class="info-group">
                            <div class="info-label">Member Since</div>
                            <div class="info-value"><%= !createdAtString.isEmpty() ? createdAtString : "Not available" %></div>
                        </div>
                    </div>
                </div>

                <div class="info-card">
                    <div class="info-header">
                        <i class="fas fa-id-card info-icon"></i>
                        <h3 class="info-title">Personal Information</h3>
                    </div>
                    <div class="info-body">
                        <div class="info-group">
                            <div class="info-label">Full Name</div>
                            <div class="info-value"><%= user.getFullName() != null && !user.getFullName().isEmpty() ? user.getFullName() : "Not provided" %></div>
                        </div>
                        <div class="info-group">
                            <div class="info-label">Phone Number</div>
                            <div class="info-value"><%= user.getPhone() != null && !user.getPhone().isEmpty() ? user.getPhone() : "Not provided" %></div>
                        </div>
                    </div>
                </div>

                <div class="info-card">
                    <div class="info-header">
                        <i class="fas fa-calendar-alt info-icon"></i>
                        <h3 class="info-title">Recent Activity</h3>
                    </div>
                    <div class="info-body">
                        <p>Your recent event activities will appear here.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Account Modal -->
<div id="deleteAccountModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2 class="modal-title">Delete Account</h2>
        <p class="modal-message">Are you sure you want to delete your account? This action cannot be undone. Please enter your password to confirm.</p>

        <form id="deleteForm" action="${pageContext.request.contextPath}/profile/delete" method="post">
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="modal-actions">
                <button type="button" class="btn btn-secondary" id="cancelDelete">Cancel</button>
                <button type="submit" class="btn btn-danger">Delete Account</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer_component.jsp" %>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('deleteAccountModal');
    const btn = document.getElementById('deleteAccountBtn');
    const span = document.getElementsByClassName('close')[0];
    const cancelBtn = document.getElementById('cancelDelete');

    btn.onclick = function() {
        modal.style.display = "block";
    }

    span.onclick = function() {
        modal.style.display = "none";
    }

    cancelBtn.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});
</script>
</body>
</html>
