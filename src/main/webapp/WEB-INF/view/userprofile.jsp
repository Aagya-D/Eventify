<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
=======
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
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<<<<<<< HEAD
    <title>Eventify Admin - Venue Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --success: #2ecc71;
            --warning: #f39c12;
            --danger: #e74c3c;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --gradient: linear-gradient(135deg, #3498db, #2c3e50);
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --border-radius: 8px;
        }

=======
    <title>My Profile - Eventify</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
<<<<<<< HEAD
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 240px;
            background: var(--gradient);
            color: white;
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
            transition: all 0.3s ease;
        }

        .brand {
            margin-bottom: 2rem;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .admin-text {
            font-size: 0.9rem;
            opacity: 0.8;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .nav-menu {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            margin-bottom: 2rem;
        }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 0.8rem 1rem;
            border-radius: var(--border-radius);
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .nav-item:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .nav-item.active {
            background: rgba(255, 255, 255, 0.2);
            font-weight: 600;
        }

        .nav-item i {
            margin-right: 0.8rem;
            width: 20px;
            text-align: center;
        }

        .user-menu {
            margin-top: auto;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 1rem;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 240px;
            padding: 2rem;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark);
        }

        .search-bar {
            position: relative;
            width: 300px;
        }

        .search-bar input {
            width: 100%;
            padding: 8px 14px 8px 35px;
            border: 1px solid #e0e0e0;
            border-radius: 25px;
            font-size: 14px;
            background: #f8f9fa;
            transition: border 0.2s, box-shadow 0.2s, background 0.2s;
        }

        .search-bar input:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            background: #fff;
        }

        .search-bar i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary);
            font-size: 14px;
        }

        /* Card Styles */
        .card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 1rem;
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
        }

        .card-title i {
            margin-right: 0.5rem;
            color: var(--secondary);
        }

        .filter-container {
            display: flex;
            align-items: center;
        }

        .filter-select {
            padding: 0.5rem 1rem;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            background-color: white;
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            border-color: var(--secondary);
            outline: none;
        }

        /* Table Styles */
        .table-container {
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th {
            background-color: #f8f9fa;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--dark);
            border-bottom: 2px solid #eee;
        }

        .data-table td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        .data-table tr:hover {
            background-color: #f8f9fa;
        }

        .venue-name {
            display: flex;
            align-items: center;
        }

        .venue-name i {
            margin-right: 0.5rem;
            color: var(--secondary);
        }

        .actions-cell {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            align-items: stretch;
        }

=======
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
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
<<<<<<< HEAD
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius);
            border: none;
            cursor: pointer;
            font-size: 0.8rem;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            width: 100%;
        }

        .btn-primary {
            background-color: var(--secondary);
            color: white;
        }

        .btn-secondary {
            background-color: #e9ecef;
            color: #495057;
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn i {
            margin-right: 0.4rem;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .btn-secondary:hover {
            background-color: #dee2e6;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        .add-venue-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background-color: var(--success);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            font-weight: 500;
            margin-top: 1.5rem;
        }

        .add-venue-btn i {
            margin-right: 0.5rem;
        }

        .add-venue-btn:hover {
            background-color: #27ae60;
        }

        /* Responsive Fixes */
        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
                padding: 1rem 0.5rem;
            }

            .logo, .admin-text {
                display: none;
            }

            .nav-item {
                justify-content: center;
                padding: 1rem;
            }

            .nav-item i {
                margin-right: 0;
                font-size: 1.2rem;
            }

            .nav-item span {
                display: none;
            }

            .main-content {
                margin-left: 80px;
            }
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .search-bar {
                width: 100%;
            }

            .actions-cell {
                flex-direction: column;
                align-items: flex-end;
            }
        }

        /* Alert Styles */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: var(--border-radius);
            display: flex;
            align-items: center;
            box-shadow: var(--shadow);
            animation: fadeIn 0.5s ease;
        }

=======
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
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .alert i {
            margin-right: 10px;
            font-size: 18px;
        }
<<<<<<< HEAD

        .alert-success {
            background-color: rgba(46, 204, 113, 0.15);
            border-left: 4px solid var(--success);
            color: #27ae60;
        }

        .alert-danger {
            background-color: rgba(231, 76, 60, 0.15);
            border-left: 4px solid var(--danger);
            color: #c0392b;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-hide alerts after 5 seconds
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    if (alert) {
                        alert.style.opacity = '0';
                        alert.style.transition = 'opacity 0.5s ease';
                        setTimeout(function() {
                            alert.style.display = 'none';
                        }, 500);
                    }
                });
            }, 5000);
        });
    </script>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="brand">
            <div class="logo">Eventify</div>
            <div class="admin-text">Admin Panel</div>
        </div>

        <div class="nav-menu">
            <a href="${pageContext.request.contextPath}/AdminDashboard" class="nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>

            <a href="${pageContext.request.contextPath}/EventDashboard" class="nav-item">
                <i class="fas fa-calendar-alt"></i>
                <span>Events</span>
            </a>

            <a href="${pageContext.request.contextPath}/VenueDashboard" class="nav-item active">
                <i class="fas fa-map-marker-alt"></i>
                <span>Venues</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/manage-users" class="nav-item">
                <i class="fas fa-users"></i>
                <span>Users</span>
            </a>
        </div>

        <div class="user-menu">
            <a href="${pageContext.request.contextPath}/admin/profile" class="nav-item">
                <i class="fas fa-user"></i>
                <span>My Profile</span>
            </a>

            <a href="${pageContext.request.contextPath}/logout" class="nav-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h1 class="page-title">Venue Management</h1>

            <form action="${pageContext.request.contextPath}/VenueDashboard" method="get" class="search-form">
                <div class="search-bar">
                    <i class="fas fa-search"></i>
                    <input type="text" name="q" placeholder="Search venues..." value="${searchQuery}">
                </div>
            </form>
        </div>

        <!-- Success message -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success" id="successAlert">
                <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
            </div>
            <% session.removeAttribute("successMessage"); %>
        </c:if>

        <!-- Error message -->
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert alert-danger" id="errorAlert">
                <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
            </div>
            <% session.removeAttribute("errorMessage"); %>
        </c:if>

        <div class="card">
            <div class="card-header">
                <h2 class="card-title">
                    <i class="fas fa-map-marker-alt"></i>
                    Venue List
                </h2>

                <div class="filter-container">
                    <select class="filter-select">
                        <option value="all">All Venues</option>
                        <option value="active">Active Venues</option>
                        <option value="inactive">Inactive Venues</option>
                    </select>
                </div>
            </div>

            <div class="table-container">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Venue Name</th>
                        <th>Address</th>
                        <th>City</th>
                        <th>Contact</th>
                        <th>Capacity</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="venue" items="${venues}">
                        <tr>
                            <td>
                                <div class="venue-name">
                                    <i class="fas fa-building"></i>
                                    <span>${venue.name}</span>
                                </div>
                            </td>
                            <td>${venue.address}</td>
                            <td>${venue.city}</td>
                            <td>${venue.contactNumber}</td>
                            <td>${venue.capacity}</td>
                            <td>
                                <div class="actions-cell">
                                    <a href="${pageContext.request.contextPath}/admin/edit-venue?id=${venue.id}" class="btn btn-primary">
                                        <i class="fas fa-edit"></i>
                                        Edit
                                    </a>
                                    <form action="${pageContext.request.contextPath}/admin/delete-venue" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this venue?');">
                                        <input type="hidden" name="id" value="${venue.id}">
                                        <button type="submit" class="btn btn-danger">
                                            <i class="fas fa-trash"></i>
                                            Delete
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div style="margin-top: 1.5rem; text-align: right;">
                <a href="${pageContext.request.contextPath}/admin/add-venue" class="btn btn-primary add-venue-btn">
                    <i class="fas fa-plus"></i>
                    Add New Venue
                </a>
            </div>
        </div>
    </div>
</div>
=======
        
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
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
</body>
</html>
