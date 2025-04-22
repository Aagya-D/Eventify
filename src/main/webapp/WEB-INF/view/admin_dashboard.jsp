<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventify - Admin Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            background-color: #faf8f0;
            display: flex;
        }
        /* Sidebar Styles */
        .sidebar {
            width: 220px;
            background-color: #005744;
            color: white;
            height: 100vh;
            position: fixed;
            padding: 20px;
            display: flex;
            flex-direction: column;
            border-right: 2px solid #0077b6;
        }
        .sidebar-logo {
            font-size: 28px;
            font-weight: bold;
            font-style: italic;
            margin-bottom: 5px;
        }
        .sidebar-title {
            font-size: 20px;
            margin-bottom: 30px;
        }
        .sidebar-menu {
            list-style: none;
            margin-bottom: auto;
        }
        .sidebar-menu li {
            margin-bottom: 15px;
        }
        .sidebar-menu a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background-color: rgba(255, 255, 255, 0.1);
        }
        .sidebar-menu a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        .sidebar-footer {
            margin-top: 20px;
        }
        .sidebar-footer a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .sidebar-footer a:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        .sidebar-footer a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: 220px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        /* Header Styles */
        .header {
            background-color: #faf8f0;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e0e0e0;
        }
        .nav-menu {
            display: flex;
            list-style: none;
        }
        .nav-menu li {
            margin-right: 20px;
        }
        .nav-menu a {
            text-decoration: none;
            color: #005744;
            font-weight: bold;
            display: flex;
            align-items: center;
        }
        .nav-menu a i {
            margin-right: 5px;
        }
        .search-bar {
            display: flex;
            align-items: center;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 20px;
            padding: 5px 15px;
            width: 300px;
        }
        .search-bar input {
            border: none;
            outline: none;
            background: transparent;
            padding: 5px;
            width: 100%;
        }
        .search-bar i {
            color: #666;
        }
        /* Dashboard Content Styles */
        .dashboard {
            padding: 30px;
            flex: 1;
        }
        .dashboard-header {
            background-color: #005744;
            color: white;
            padding: 20px;
            border-radius: 5px 5px 0 0;
        }
        .dashboard-header h1 {
            margin-bottom: 5px;
            font-size: 24px;
        }
        .dashboard-header p {
            font-size: 14px;
        }
        .dashboard-stats {
            display: flex;
            justify-content: space-around;
            padding: 40px;
            background-color: #e0e2e5;
            border-radius: 0 0 5px 5px;
            margin-bottom: 30px;
        }
        .stat-card {
            text-align: center;
        }
        .stat-icon {
            font-size: 32px;
            margin-bottom: 10px;
            color: #005744;
        }
        .stat-title {
            font-size: 16px;
            margin-bottom: 5px;
            color: #333;
        }
        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #005744;
        }
        /* Activity and Users Section */
        .dashboard-sections {
            display: flex;
            gap: 30px;
        }
        .dashboard-section {
            flex: 1;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 20px;
        }
        .dashboard-section h2 {
            font-size: 18px;
            margin-bottom: 20px;
            color: #333;
        }
        .activity-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .activity-icon {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background-color: #005744;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 12px;
        }
        .activity-text {
            font-size: 14px;
            color: #333;
        }
        .user-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #005744;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 18px;
        }
        .user-info {
            flex: 1;
        }
        .user-name {
            font-weight: bold;
            font-size: 14px;
            color: #333;
        }
        .user-role {
            font-size: 12px;
            color: #666;
        }
        /* Footer Styles */
        footer {
            background-color: #005744;
            color: white;
            padding: 30px;
            margin-top: auto;
        }
        .footer-content {
            display: flex;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
        }
        .footer-column {
            flex: 1;
            padding: 0 15px;
        }
        .footer-column h3 {
            margin-bottom: 15px;
            font-size: 18px;
        }
        .footer-column p {
            margin-bottom: 10px;
            font-size: 14px;
        }
        .footer-links {
            list-style: none;
        }
        .footer-links li {
            margin-bottom: 8px;
        }
        .footer-links a {
            color: white;
            text-decoration: none;
            font-size: 14px;
        }
        .contact-info {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .contact-info i {
            margin-right: 10px;
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<aside class="sidebar">
    <div class="sidebar-logo">Eventify</div>
    <div class="sidebar-title">Admin</div>
    <ul class="sidebar-menu">
        <li><a href="#" class="active"><i class="fas fa-th-large"></i> Dashboard</a></li>
        <li><a href="#"><i class="far fa-calendar-alt"></i> Events</a></li>
        <li><a href="#"><i class="fas fa-map-marker-alt"></i> Venues</a></li>
    </ul>
    <div class="sidebar-footer">
        <a href="#"><i class="fas fa-user"></i> My Profile</a>
        <a href="#"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>

<!-- Main Content -->
<div class="main-content">
    <!-- Header -->
    <header class="header">
        <ul class="nav-menu">
            <li><a href="#"><i class="fas fa-home"></i> Home</a></li>
            <li><a href="#"><i class="far fa-calendar-alt"></i> Events</a></li>
            <li><a href="#"><i class="fas fa-map-marker-alt"></i> Venues</a></li>
        </ul>
        <div class="search-bar">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Search here.....">
        </div>
    </header>

    <!-- Dashboard Content -->
    <main class="dashboard">
        <div class="dashboard-header">
            <h1>Admin Dashboard</h1>
            <p>Manage events, venues and users</p>
        </div>
        <div class="dashboard-stats">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="far fa-calendar-alt"></i>
                </div>
                <div class="stat-title">Events</div>
                <div class="stat-value">
                    <%= request.getAttribute("eventCount") != null ? request.getAttribute("eventCount") : "9" %>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <div class="stat-title">Venues</div>
                <div class="stat-value">
                    <%= request.getAttribute("venueCount") != null ? request.getAttribute("venueCount") : "11" %>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-title">Users</div>
                <div class="stat-value">
                    <%= request.getAttribute("userCount") != null ? request.getAttribute("userCount") : "6" %>
                </div>
            </div>
        </div>

        <div class="dashboard-sections">
            <div class="dashboard-section">
                <h2>Recent Activity</h2>
                <%
                    // This would typically come from a database or service
                    String[] activities = {
                            "Alzeena added \"Sumi66\"",
                            "Admin added venue \"Gajur Palace\"",
                            "New user registered \"Anjali_78\"",
                            "Aagya added \"Shovan02\"",
                            "Darshan added venue \"Soaltee westend\""
                    };

                    for(String activity : activities) {
                %>
                <div class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-circle"></i>
                    </div>
                    <div class="activity-text">
                        <%= activity %>
                    </div>
                </div>
                <% } %>
            </div>

            <div class="dashboard-section">
                <h2>Recent Users</h2>
                <%
                    // This would typically come from a database or service
                    String[][] users = {
                            {"Alzeena Khewa", "Organizer"},
                            {"Anjali_78", "User"},
                            {"Sumi66", "Organizer"}
                    };

                    for(String[] user : users) {
                %>
                <div class="user-item">
                    <div class="user-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="user-info">
                        <div class="user-name"><%= user[0] %></div>
                        <div class="user-role"><%= user[1] %></div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-column">
                <h3>Eventify</h3>
                <p>Your easy event management solution</p>
            </div>
            <div class="footer-column">
                <h3>Quick Links</h3>
                <ul class="footer-links">
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Add Event</a></li>
                    <li><a href="#">All Events</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Contact</h3>
                <div class="contact-info">
                    <i class="fas fa-envelope"></i>
                    <span>supporteventify@gmail.com</span>
                </div>
                <div class="contact-info">
                    <i class="fas fa-phone"></i>
                    <span>9826321921</span>
                </div>
            </div>
        </div>
    </footer>
</div>

<!-- Font Awesome for icons -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
