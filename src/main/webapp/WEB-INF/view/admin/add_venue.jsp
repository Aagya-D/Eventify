<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventify Admin - Add Venue</title>
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
        
        /* Form Styles */
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--dark);
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            background-color: white;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--secondary);
            outline: none;
            box-shadow: var(--shadow);
        }
        
        .form-check {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .form-check-input {
            margin-right: 0.5rem;
        }
        
        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .btn-primary {
            background-color: var(--secondary);
            color: white;
        }
        
        .btn-secondary {
            background-color: #e9ecef;
            color: #495057;
        }
        
        .btn i {
            margin-right: 0.5rem;
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
        }
        
        .btn-secondary:hover {
            background-color: #dee2e6;
        }
        
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .error-message {
            color: var(--danger);
            margin-bottom: 1rem;
            padding: 0.5rem 1rem;
            background-color: rgba(231, 76, 60, 0.1);
            border-radius: var(--border-radius);
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
                <h1 class="page-title">Add New Venue</h1>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">
                        <i class="fas fa-building"></i>
                        Venue Details
                    </h2>
                </div>
                
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">
                        ${errorMessage}
                    </div>
                </c:if>
                
                <!-- Debug info to show context path -->
                <div style="color: green; margin-bottom: 10px;">
                    Context Path: ${pageContext.request.contextPath}
                </div>
                
                <form action="${pageContext.request.contextPath}/admin/add-venue" method="post">
                    <div class="form-group">
                        <label class="form-label" for="name">Venue Name*</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="address">Address*</label>
                        <input type="text" class="form-control" id="address" name="address" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="city">City*</label>
                        <input type="text" class="form-control" id="city" name="city" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="contactNumber">Contact Number*</label>
                        <input type="tel" class="form-control" id="contactNumber" name="contactNumber" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="capacity">Capacity*</label>
                        <input type="number" class="form-control" id="capacity" name="capacity" required min="1">
                    </div>
                    
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/VenueDashboard" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            Save Venue
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html> 