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
    <title>Edit Profile - Eventify</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        body {
            background-color: #f4f7fa;
            font-family: 'Inter', sans-serif;
            color: #333;
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .main-content {
            flex: 1;
            padding: 40px 20px;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Profile Layout */
        .profile-container {
            display: flex;
            gap: 30px;
            max-width: 1000px;
            margin: 0 auto;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .profile-sidebar {
            width: 300px;
            flex-shrink: 0;
        }
<<<<<<< HEAD

        .profile-main {
            flex: 1;
        }

=======
        
        .profile-main {
            flex: 1;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Profile Card */
        .profile-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Profile Header */
        .profile-avatar-section {
            background: linear-gradient(135deg, #00574b 0%, #007c6c 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
            position: relative;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
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
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .profile-name {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 5px;
            font-family: 'Montserrat', sans-serif;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .profile-username {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 10px;
            font-size: 15px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .profile-role {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* For regular user role */
        .role-user {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* For admin role */
        .role-admin {
            background-color: #e3f2fd;
            color: #1565c0;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Navigation Menu */
        .profile-nav {
            padding: 20px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
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
<<<<<<< HEAD

        .nav-item:hover {
            background: #f5f7fa;
        }

=======
        
        .nav-item:hover {
            background: #f5f7fa;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .nav-item.active {
            background: #f0f9f7;
            color: #00574b;
            font-weight: 500;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .nav-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
            font-size: 16px;
            color: #00574b;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Information Card */
        .info-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .info-header {
            padding: 20px 30px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .info-title {
            font-size: 20px;
            font-weight: 600;
            display: flex;
            align-items: center;
            font-family: 'Montserrat', sans-serif;
            color: #00574b;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .info-title i {
            margin-right: 10px;
            font-size: 18px;
        }
<<<<<<< HEAD

        .info-content {
            padding: 30px;
        }

=======
        
        .info-content {
            padding: 30px;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Alert Messages */
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .alert-error {
            background-color: #ffebee;
            color: #c62828;
            border-left: 4px solid #c62828;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .alert-success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border-left: 4px solid #2e7d32;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .alert i {
            margin-right: 10px;
            font-size: 18px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Form Styles */
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #495057;
            font-size: 15px;
        }
<<<<<<< HEAD

        .form-field {
            position: relative;
        }

=======
        
        .form-field {
            position: relative;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .form-field i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
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
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .form-control:focus {
            outline: none;
            border-color: #00574b;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(0, 87, 75, 0.1);
        }
<<<<<<< HEAD

        .form-control::placeholder {
            color: #adb5bd;
        }

=======
        
        .form-control::placeholder {
            color: #adb5bd;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .form-help {
            margin-top: 5px;
            font-size: 13px;
            color: #6c757d;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Button styles */
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
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
<<<<<<< HEAD

        .btn i {
            margin-right: 10px;
        }

=======
        
        .btn i {
            margin-right: 10px;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .btn-primary {
            background: #00574b;
            color: white;
            box-shadow: 0 4px 10px rgba(0, 87, 75, 0.2);
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .btn-primary:hover {
            background: #004a3f;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 87, 75, 0.3);
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .btn-outline {
            border: 2px solid #00574b;
            color: #00574b;
            background: transparent;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .btn-outline:hover {
            background: rgba(0, 87, 75, 0.05);
            transform: translateY(-2px);
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Responsive Design */
        @media (max-width: 900px) {
            .profile-container {
                flex-direction: column;
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            .profile-sidebar {
                width: 100%;
            }
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        @media (max-width: 768px) {
            .action-buttons {
                flex-direction: column;
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<<<<<<< HEAD
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
                    <a href="${pageContext.request.contextPath}/editprofile" class="nav-item active">
                        <i class="fas fa-edit"></i> Edit Profile
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
                        <i class="fas fa-edit"></i> Edit Profile
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

                    <form action="${pageContext.request.contextPath}/editprofile" method="post">
                        <div class="form-group">
                            <label for="username" class="form-label">Username</label>
                            <div class="form-field">
                                <i class="fas fa-user"></i>
                                <input type="text" id="username" name="username" class="form-control" value="<%= user.getUserName() %>" required>
                            </div>
                            <p class="form-help">Your display name on the platform</p>
                        </div>

                        <div class="form-group">
                            <label for="email" class="form-label">Email Address</label>
                            <div class="form-field">
                                <i class="fas fa-envelope"></i>
                                <input type="email" id="email" name="email" class="form-control" value="<%= user.getEmail() %>" required>
                            </div>
                            <p class="form-help">We'll never share your email with anyone else</p>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="form-label">Phone Number</label>
                            <div class="form-field">
                                <i class="fas fa-phone"></i>
                                <input type="text" id="phone" name="phone" class="form-control" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" placeholder="Optional">
                            </div>
                            <p class="form-help">Your contact number for event communications</p>
                        </div>

                        <div class="action-buttons">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Changes
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
=======
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
                        <a href="${pageContext.request.contextPath}/editprofile" class="nav-item active">
                            <i class="fas fa-edit"></i> Edit Profile
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
                            <i class="fas fa-edit"></i> Edit Profile
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
                        
                        <form action="${pageContext.request.contextPath}/editprofile" method="post">
                            <div class="form-group">
                                <label for="username" class="form-label">Username</label>
                                <div class="form-field">
                                    <i class="fas fa-user"></i>
                                    <input type="text" id="username" name="username" class="form-control" value="<%= user.getUserName() %>" required>
                                </div>
                                <p class="form-help">Your display name on the platform</p>
                            </div>
                            
                            <div class="form-group">
                                <label for="email" class="form-label">Email Address</label>
                                <div class="form-field">
                                    <i class="fas fa-envelope"></i>
                                    <input type="email" id="email" name="email" class="form-control" value="<%= user.getEmail() %>" required>
                                </div>
                                <p class="form-help">We'll never share your email with anyone else</p>
                            </div>
                            
                            <div class="form-group">
                                <label for="phone" class="form-label">Phone Number</label>
                                <div class="form-field">
                                    <i class="fas fa-phone"></i>
                                    <input type="text" id="phone" name="phone" class="form-control" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" placeholder="Optional">
                                </div>
                                <p class="form-help">Your contact number for event communications</p>
                            </div>
                            
                            <div class="action-buttons">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Save Changes
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
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
</body>
</html>
