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
    if (user.getUserName() != null && !user.getUserName().isEmpty()) {
        initials = user.getUserName().substring(0, 1).toUpperCase();
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
        
        /* Info Items */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .info-label {
            font-size: 14px;
            color: #6c757d;
            display: flex;
            align-items: center;
        }
        
        .info-label i {
            color: #00574b;
            margin-right: 10px;
            width: 16px;
            text-align: center;
            font-size: 14px;
        }
        
        .info-value {
            font-weight: 500;
            color: #333;
            font-size: 16px;
            padding-left: 26px;
        }
        
        /* Buttons */
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
            .info-grid {
                grid-template-columns: 1fr;
            }
            
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
                        <a href="${pageContext.request.contextPath}/profile" class="nav-item active">
                            <i class="fas fa-user"></i> Profile
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
                            <i class="fas fa-user-circle"></i> Profile Information
                        </h3>
                    </div>
                    
                    <div class="info-content">
                        <% 
                            // Display success message if available
                            String successMessage = (String) session.getAttribute("successMessage");
                            if (successMessage != null) {
                                // Display the message
                        %>
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle"></i> <%= successMessage %>
                            </div>
                        <%
                                // Remove the message from session to prevent displaying it multiple times
                                session.removeAttribute("successMessage");
                            }
                        %>
                        
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label"><i class="fas fa-user"></i> Username</span>
                                <span class="info-value"><%= user.getUserName() %></span>
                            </div>
                            
                            <div class="info-item">
                                <span class="info-label"><i class="fas fa-envelope"></i> Email</span>
                                <span class="info-value"><%= user.getEmail() %></span>
                            </div>
                            
                            <div class="info-item">
                                <span class="info-label"><i class="fas fa-user-tag"></i> Role</span>
                                <span class="info-value"><%= user.getRole() %></span>
                            </div>
                            
                            <div class="info-item">
                                <span class="info-label"><i class="fas fa-phone"></i> Phone</span>
                                <span class="info-value"><%= user.getPhone() != null ? user.getPhone() : "Not provided" %></span>
                            </div>
                            
                            <div class="info-item">
                                <span class="info-label"><i class="fas fa-calendar-check"></i> Member Since</span>
                                <span class="info-value"><%= !createdAtString.isEmpty() ? createdAtString : "Not available" %></span>
                            </div>
                        </div>
                        
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/editprofile" class="btn btn-primary">
                                <i class="fas fa-edit"></i> Edit Profile
                            </a>
                            <a href="${pageContext.request.contextPath}/resetpassword" class="btn btn-outline">
                                <i class="fas fa-key"></i> Change Password
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/view/footer.jsp" />
</body>
</html>
