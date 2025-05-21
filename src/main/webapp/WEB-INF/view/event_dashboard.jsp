<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventify Admin - Event Management</title>
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
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
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
        
        .event-name {
            display: flex;
            align-items: center;
        }
        
        .event-name i {
            margin-right: 0.5rem;
            color: var(--secondary);
        }
        
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 48px;
            height: 24px;
        }
        
        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        
        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            border-radius: 24px;
            transition: .4s;
        }
        
        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            border-radius: 50%;
            transition: .4s;
        }
        
        input:checked + .toggle-slider {
            background-color: var(--success);
        }
        
        input:checked + .toggle-slider:before {
            transform: translateX(24px);
        }
        
        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background-color: var(--secondary);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            font-weight: 500;
        }
        
        .action-btn i {
            margin-right: 0.5rem;
        }
        
        .action-btn:hover {
            background-color: #2980b9;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .status-approved {
            background-color: rgba(46, 204, 113, 0.15);
            color: #27ae60;
        }
        
        .status-pending {
            background-color: rgba(243, 156, 18, 0.15);
            color: #f39c12;
        }
        
        /* Button and action styles */
        .actions-cell {
            display: flex;
            gap: 0.5rem;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius);
            border: none;
            cursor: pointer;
            font-size: 0.8rem;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .btn-primary {
            background-color: var(--secondary);
            color: white;
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
        
        .btn-danger:hover {
            background-color: #c0392b;
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
        }
    </style>
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
                
                <a href="${pageContext.request.contextPath}/EventDashboard" class="nav-item active">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Events</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/VenueDashboard" class="nav-item">
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
                <h1 class="page-title">Event Management</h1>
                
                <form action="${pageContext.request.contextPath}/EventDashboard" method="get" class="search-form">
                    <div class="search-bar">
                        <i class="fas fa-search"></i>
                        <input type="text" name="q" placeholder="Search events..." value="${searchQuery}">
                    </div>
                </form>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">
                        <i class="fas fa-calendar-check"></i>
                        Event List
                    </h2>
                    
                    <div class="filter-container">
                        <select class="filter-select">
                            <option value="all">All Events</option>
                            <option value="approved">Approved</option>
                            <option value="pending">Pending</option>
                        </select>
                    </div>
                </div>
                
                <div class="table-container">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Event Name</th>
                                <th>Date</th>
                                <th>Venue</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="event" items="${events}">
                                <tr>
                                    <td>
                                        <div class="event-name">
                                            <i class="fas fa-calendar-day"></i>
                                            <span>${event.name}</span>
                                        </div>
                                    </td>
                                    <td><fmt:formatDate value="${event.dateTime}" pattern="MMM dd, yyyy" /></td>
                                    <td>${event.venue}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${event.approved}">
                                                <span class="status-badge status-approved">Approved</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-pending">Pending</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="actions-cell">
                                            <a href="${pageContext.request.contextPath}/admin/edit-event?id=${event.id}" class="btn btn-primary">
                                                <i class="fas fa-edit"></i>
                                                Edit
                                            </a>
                                            <form action="${pageContext.request.contextPath}/admin/delete-event" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this event?');">
                                                <input type="hidden" name="id" value="${event.id}">
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
                    <a href="${pageContext.request.contextPath}/admin/add-event" class="action-btn">
                        <i class="fas fa-plus"></i>
                        Add New Event
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
