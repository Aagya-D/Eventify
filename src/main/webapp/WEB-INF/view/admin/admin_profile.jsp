<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get admin user from request
    User user = (User) request.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
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

    // Get user count
    int userCount = (Integer) request.getAttribute("userCount");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile - Eventify</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/layout.css">
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

        /* Main Container */
        .main-container {
            padding: 30px 20px;
            flex: 1;
        }

        .profile-page {
            max-width: 1000px;
            margin: 0 auto;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 20px;
        }

        @media (max-width: 768px) {
            .profile-grid {
                grid-template-columns: 1fr;
            }
        }

        .page-title {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            font-size: 22px;
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
            gap: 5px;
            padding: 6px 12px;
            border-radius: 4px;
            border: 1px solid #eaeaea;
            transition: all 0.2s;
        }

        .back-link:hover {
            background-color: #f5f5f5;
            color: #006158;
        }

        /* Profile Sidebar */
        .profile-sidebar {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .profile-header {
            text-align: center;
            padding: 20px;
            border-bottom: 1px solid #eaeaea;
        }

        .avatar {
            width: 80px;
            height: 80px;
            margin: 0 auto 15px;
            border-radius: 50%;
            background-color: #006158;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            font-weight: 600;
            font-family: 'Montserrat', sans-serif;
        }

        .profile-name {
            font-weight: 600;
            font-size: 16px;
            color: #333;
            margin-bottom: 4px;
        }

        .profile-username {
            color: #666;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .profile-role {
            display: inline-block;
            padding: 3px 10px;
            background-color: #e8f5f3;
            color: #006158;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
        }

        .profile-actions {
            display: flex;
            flex-direction: column;
            gap: 8px;
            padding: 15px;
        }

        .btn {
            padding: 8px 12px;
            font-size: 14px;
            border-radius: 4px;
            font-weight: 500;
            text-align: center;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-primary {
            background: #006158;
            color: white;
            border: none;
        }

        .btn-primary:hover {
            background: #004d46;
        }

        .btn-secondary {
            background: #f5f5f5;
            color: #333;
            border: 1px solid #ddd;
        }

        .btn-secondary:hover {
            background: #e9e9e9;
            border-color: #ccc;
        }

        /* Profile Content */
        .profile-content {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .info-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .info-header {
            padding: 12px 15px;
            border-bottom: 1px solid #eaeaea;
            display: flex;
            align-items: center;
            gap: 8px;
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
            padding: 15px;
        }

        .info-group {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 12px;
            margin-bottom: 12px;
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
            padding: 12px 15px;
            border-radius: 4px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border-left: 3px solid #4caf50;
        }

        .alert-error {
            background-color: #ffebee;
            color: #c62828;
            border-left: 3px solid #ef5350;
        }

        /* Admin Stats */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 15px;
        }

        .stat-card {
            background: white;
            border-radius: 8px;
            padding: 15px;
            border: 1px solid #eaeaea;
            text-align: center;
        }

        .stat-icon {
            font-size: 20px;
            color: #006158;
            margin-bottom: 8px;
        }

        .stat-value {
            font-size: 22px;
            font-weight: 600;
            color: #333;
            margin-bottom: 2px;
        }

        .stat-label {
            font-size: 13px;
            color: #666;
        }

        @media (max-width: 768px) {
            .main-container {
                padding: 20px 15px;
            }

            .profile-header {
                padding: 15px;
            }

            .avatar {
                width: 70px;
                height: 70px;
                font-size: 24px;
            }

            .info-group {
                grid-template-columns: 1fr;
                gap: 5px;
            }

            .info-label {
                font-weight: 600;
            }

            .stats-container {
                grid-template-columns: 1fr 1fr;
            }
        }
    </style>
</head>
<body>
<%@ include file="../navbar.jsp" %>

<div class="main-container">
    <div class="profile-page">
        <h1 class="page-title">
            Admin Profile
            <a href="${pageContext.request.contextPath}/AdminDashboard" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
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
                <div class="profile-header">
                    <div class="avatar">
                        <%= initials %>
                    </div>
                    <h2 class="profile-name"><%= user.getFullName() != null && !user.getFullName().isEmpty() ? user.getFullName() : user.getUserName() %></h2>
                    <p class="profile-username">@<%= user.getUserName() %></p>
                    <span class="profile-role"><%= user.getRole() %></span>
                </div>
                <div class="profile-actions">
                    <a href="${pageContext.request.contextPath}/AdminDashboard" class="btn btn-primary">
                        <i class="fas fa-th-large"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/manage-users" class="btn btn-primary">
                        <i class="fas fa-users"></i> Manage Users
                    </a>
                    <a href="${pageContext.request.contextPath}/EventDashboard" class="btn btn-secondary">
                        <i class="fas fa-calendar-alt"></i> Manage Events
                    </a>
                    <a href="${pageContext.request.contextPath}/VenueDashboard" class="btn btn-secondary">
                        <i class="fas fa-map-marker-alt"></i> Manage Venues
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>

            <div class="profile-content">
                <div class="info-card">
                    <div class="info-header">
                        <i class="fas fa-chart-bar info-icon"></i>
                        <h3 class="info-title">Admin Statistics</h3>
                    </div>
                    <div class="info-body">
                        <div class="stats-container">
                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div class="stat-value"><%= userCount %></div>
                                <div class="stat-label">Total Users</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                                <div class="stat-value"><%= request.getAttribute("eventCount") %></div>
                                <div class="stat-label">Events</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="stat-value"><%= request.getAttribute("venueCount") %></div>
                                <div class="stat-label">Venues</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="info-card">
                    <div class="info-header">
                        <i class="fas fa-user-shield info-icon"></i>
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
                            <div class="info-label">Role</div>
                            <div class="info-value"><%= user.getRole() %></div>
                        </div>
                        <div class="info-group">
                            <div class="info-label">Admin Since</div>
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
                        <i class="fas fa-shield-alt info-icon"></i>
                        <h3 class="info-title">Security Settings</h3>
                    </div>
                    <div class="info-body">
                        <a href="${pageContext.request.contextPath}/resetpassword" class="btn btn-secondary">
                            <i class="fas fa-key"></i> Change Password
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="admin_footer.jsp" %>
</body>
</html> 