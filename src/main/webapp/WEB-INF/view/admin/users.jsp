<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    List<User> users = (List<User>) request.getAttribute("users");
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");
    
    // Clear session messages
    if (successMessage != null) {
        session.removeAttribute("successMessage");
    }
    if (errorMessage != null) {
        session.removeAttribute("errorMessage");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management | Eventify Admin</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .page-header h1 {
            font-size: 28px;
            font-weight: 600;
            color: #333;
        }
        
        .breadcrumb {
            color: #666;
            font-size: 14px;
            margin-top: 5px;
        }
        
        /* Alert messages */
        .alert {
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* User table */
        .user-table-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 20px;
            overflow-x: auto;
        }
        
        .user-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .user-table th, .user-table td {
            padding: 12px 15px;
            text-align: left;
        }
        
        .user-table th {
            background-color: #f4f6f9;
            font-weight: 500;
        }
        
        .user-table tr {
            border-bottom: 1px solid #eee;
        }
        
        .user-table tr:last-child {
            border-bottom: none;
        }
        
        .user-role {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .role-admin {
            background-color: #e8f5e9;
            color: #388e3c;
        }
        
        .role-user {
            background-color: #e3f2fd;
            color: #1976d2;
        }
        
        .role-moderator {
            background-color: #f3e5f5;
            color: #7b1fa2;
        }
        
        .action-buttons {
            display: flex;
            gap: 5px;
        }
        
        .btn {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            border: none;
        }
        
        .btn-edit {
            background-color: #006158;
            color: white;
        }
        
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-add {
            background-color: #006158;
            color: white;
            display: inline-flex;
            align-items: center;
            padding: 8px 16px;
            font-size: 14px;
        }
        
        .btn-add i {
            margin-right: 6px;
        }
        
        /* Delete confirmation modal */
        #deleteModal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        
        .modal-content {
            background-color: white;
            border-radius: 8px;
            width: 400px;
            max-width: 90%;
            padding: 20px;
        }
        
        .modal-header {
            margin-bottom: 15px;
        }
        
        .modal-body {
            margin-bottom: 20px;
        }
        
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
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
                <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/events"><i class="fas fa-calendar-alt"></i> Events</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users" class="active"><i class="fas fa-users"></i> Users</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/venues"><i class="fas fa-map-marker-alt"></i> Venues</a></li>
                <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Back to Site</a></li>
                <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="page-header">
                <div>
                    <h1>User Management</h1>
                    <div class="breadcrumb">Home / Users</div>
                </div>
                <a href="${pageContext.request.contextPath}/admin/users?action=add" class="btn btn-add">
                    <i class="fas fa-plus"></i> Add New User
                </a>
            </div>
            
            <!-- Alert Messages -->
            <% if (successMessage != null) { %>
            <div class="alert alert-success">
                <%= successMessage %>
            </div>
            <% } %>
            
            <% if (errorMessage != null) { %>
            <div class="alert alert-danger">
                <%= errorMessage %>
            </div>
            <% } %>
            
            <!-- Users Table -->
            <div class="user-table-container">
                <% if (users != null && !users.isEmpty()) { %>
                <table class="user-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Created At</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (User user : users) { %>
                        <tr>
                            <td><%= user.getUserId() %></td>
                            <td><%= user.getUserName() %></td>
                            <td><%= user.getEmail() %></td>
                            <td>
                                <% if ("ADMIN".equals(user.getRole())) { %>
                                <span class="user-role role-admin">Admin</span>
                                <% } else if ("MODERATOR".equals(user.getRole())) { %>
                                <span class="user-role role-moderator">Moderator</span>
                                <% } else { %>
                                <span class="user-role role-user">User</span>
                                <% } %>
                            </td>
                            <td><%= user.getCreatedAt() != null ? dateFormat.format(user.getCreatedAt()) : "N/A" %></td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=<%= user.getUserId() %>" class="btn btn-edit">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <button class="btn btn-delete" onclick="confirmDelete(<%= user.getUserId() %>, '<%= user.getUserName() %>')">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <p>No users found.</p>
                <% } %>
            </div>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div id="deleteModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Confirm Deletion</h3>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the user <span id="userName"></span>?</p>
                <p>This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-delete">Delete</a>
            </div>
        </div>
    </div>
    
    <script>
        // Delete confirmation
        function confirmDelete(userId, userName) {
            document.getElementById('userName').textContent = userName;
            document.getElementById('confirmDeleteBtn').href = "${pageContext.request.contextPath}/admin/users?action=delete&id=" + userId;
            document.getElementById('deleteModal').style.display = 'flex';
        }
        
        function closeModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('deleteModal');
            if (event.target === modal) {
                closeModal();
            }
        }
    </script>
</body>
</html> 