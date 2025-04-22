<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.Event" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats");
    List<Event> recentEvents = (List<Event>) request.getAttribute("recentEvents");
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Eventify</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background-color: #f4f6f9;
            color: #333;
        }
        
        .admin-container {
            display: flex;
            min-height: 100vh;
        }
        
        /* Sidebar styles */
        .sidebar {
            width: 250px;
            background-color: #006158;
            color: white;
            padding: 20px 0;
        }
        
        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 20px;
        }
        
        .sidebar-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
        }
        
        .sidebar-menu {
            list-style: none;
        }
        
        .sidebar-menu li {
            margin-bottom: 5px;
        }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 10px 20px;
            color: white;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background-color: rgba(255,255,255,0.1);
        }
        
        .sidebar-menu i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        /* Main content styles */
        .main-content {
            flex: 1;
            padding: 20px;
        }
        
        .page-header {
            margin-bottom: 30px;
        }
        
        .page-header h1 {
            font-size: 28px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        
        .breadcrumb {
            color: #666;
            font-size: 14px;
        }
        
        /* Dashboard cards */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 20px;
        }
        
        .stat-card {
            display: flex;
            align-items: center;
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 24px;
        }
        
        .icon-users { background-color: #e3f2fd; color: #1976d2; }
        .icon-events { background-color: #e8f5e9; color: #388e3c; }
        .icon-approved { background-color: #f3e5f5; color: #7b1fa2; }
        .icon-pending { background-color: #fff3e0; color: #ff9800; }
        
        .stat-info h3 {
            font-size: 14px;
            font-weight: 500;
            color: #666;
            margin-bottom: 5px;
        }
        
        .stat-info p {
            font-size: 24px;
            font-weight: 600;
            color: #333;
        }
        
        /* Recent events table */
        .recent-events {
            margin-top: 30px;
        }
        
        .recent-events h2 {
            font-size: 20px;
            margin-bottom: 15px;
        }
        
        .events-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .events-table th, .events-table td {
            padding: 12px 15px;
            text-align: left;
        }
        
        .events-table th {
            background-color: #f4f6f9;
            font-weight: 500;
        }
        
        .events-table tr {
            border-bottom: 1px solid #eee;
        }
        
        .events-table tr:last-child {
            border-bottom: none;
        }
        
        .status {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-approved {
            background-color: #e8f5e9;
            color: #388e3c;
        }
        
        .status-pending {
            background-color: #fff3e0;
            color: #ff9800;
        }
        
        .action-button {
            background-color: #006158;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }
        
        .view-all {
            display: inline-block;
            margin-top: 20px;
            color: #006158;
            text-decoration: none;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>Eventify Admin</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/events"><i class="fas fa-calendar-alt"></i> Events</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i> Users</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/venues"><i class="fas fa-map-marker-alt"></i> Venues</a></li>
                <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Back to Site</a></li>
                <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="page-header">
                <h1>Admin Dashboard</h1>
                <div class="breadcrumb">Home / Dashboard</div>
            </div>
            
            <!-- Stats Cards -->
            <div class="dashboard-cards">
                <div class="card stat-card">
                    <div class="stat-icon icon-users">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Total Users</h3>
                        <p><%= stats != null ? stats.get("userCount") : 0 %></p>
                    </div>
                </div>
                
                <div class="card stat-card">
                    <div class="stat-icon icon-events">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Total Events</h3>
                        <p><%= stats != null ? stats.get("eventCount") : 0 %></p>
                    </div>
                </div>
                
                <div class="card stat-card">
                    <div class="stat-icon icon-approved">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Approved Events</h3>
                        <p><%= stats != null ? stats.get("approvedEventCount") : 0 %></p>
                    </div>
                </div>
                
                <div class="card stat-card">
                    <div class="stat-icon icon-pending">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Pending Events</h3>
                        <p><%= stats != null ? stats.get("pendingEventCount") : 0 %></p>
                    </div>
                </div>
            </div>
            
            <!-- Recent Events Table -->
            <div class="card recent-events">
                <h2>Recent Events</h2>
                
                <% if (recentEvents != null && !recentEvents.isEmpty()) { %>
                <table class="events-table">
                    <thead>
                        <tr>
                            <th>Event Name</th>
                            <th>Date</th>
                            <th>Venue</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Event event : recentEvents) { %>
                        <tr>
                            <td><%= event.getName() %></td>
                            <td><%= event.getDateTime() != null ? dateFormat.format(event.getDateTime()) : "N/A" %></td>
                            <td><%= event.getVenue() %></td>
                            <td>
                                <% if (event.isApproved()) { %>
                                <span class="status status-approved">Approved</span>
                                <% } else { %>
                                <span class="status status-pending">Pending</span>
                                <% } %>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/events/edit?id=<%= event.getId() %>" class="action-button">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                
                <a href="${pageContext.request.contextPath}/admin/events" class="view-all">View All Events <i class="fas fa-arrow-right"></i></a>
                <% } else { %>
                <p>No events found.</p>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html> 