<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get admin user from session
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"ADMIN".equals(admin.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
<<<<<<< HEAD

    // Get users from request
    List<User> users = (List<User>) request.getAttribute("users");

=======
    
    // Get users from request
    List<User> users = (List<User>) request.getAttribute("users");
    
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
    // Get counts
    int totalUsers = (Integer) request.getAttribute("totalUsers");
    int pendingUsers = (Integer) request.getAttribute("pendingUsers");
    int activeUsers = (Integer) request.getAttribute("activeUsers");
<<<<<<< HEAD

    // Get filters
    String roleFilter = (String) request.getAttribute("roleFilter");
    String searchQuery = (String) request.getAttribute("searchQuery");

    if (roleFilter == null) roleFilter = "ALL";
    if (searchQuery == null) searchQuery = "";

=======
    
    // Get filters
    String roleFilter = (String) request.getAttribute("roleFilter");
    String searchQuery = (String) request.getAttribute("searchQuery");
    
    if (roleFilter == null) roleFilter = "ALL";
    if (searchQuery == null) searchQuery = "";
    
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
    // Get any messages
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");
    String infoMessage = (String) request.getAttribute("infoMessage");
    session.removeAttribute("successMessage");
    session.removeAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Eventify</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/manage-users.css">
    <style>
        /* Additional styles for filter and search */
        .filter-bar {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
            align-items: center;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .filter-section {
            display: flex;
            align-items: center;
            gap: 10px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .filter-label {
            font-size: 14px;
            font-weight: 500;
            color: #555;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .filter-select, .search-input {
            padding: 8px 12px;
            border: 1px solid #eaeaea;
            border-radius: 4px;
            font-size: 14px;
            background-color: #fff;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .filter-select:focus, .search-input:focus {
            outline: none;
            border-color: #006158;
        }
<<<<<<< HEAD

        .search-input {
            width: 230px;
        }

=======
        
        .search-input {
            width: 230px;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .filter-button {
            padding: 8px 15px;
            background-color: #006158;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
<<<<<<< HEAD

        .filter-button:hover {
            background-color: #00514a;
        }

=======
        
        .filter-button:hover {
            background-color: #00514a;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .filter-button.clear {
            background-color: #f1f1f1;
            color: #555;
            border: 1px solid #ddd;
        }
<<<<<<< HEAD

        .filter-button.clear:hover {
            background-color: #e5e5e5;
        }

=======
        
        .filter-button.clear:hover {
            background-color: #e5e5e5;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .user-stats {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .stat-badge {
            background-color: #f8f9fa;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .stat-badge .count {
            font-weight: 600;
            color: #006158;
        }
<<<<<<< HEAD

        .stat-badge.pending {
            background-color: #fff8e6;
        }

        .stat-badge.pending .count {
            color: #e6a23c;
        }

=======
        
        .stat-badge.pending {
            background-color: #fff8e6;
        }
        
        .stat-badge.pending .count {
            color: #e6a23c;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .role-select {
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #ddd;
            font-size: 13px;
            margin-right: 5px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .modal {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            width: 400px;
            max-width: 90%;
            padding: 20px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eaeaea;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .modal-title {
            font-weight: 600;
            font-size: 18px;
            color: #333;
            margin: 0;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .modal-close {
            font-size: 18px;
            color: #999;
            cursor: pointer;
            background: none;
            border: none;
        }
<<<<<<< HEAD

        .modal-body {
            margin-bottom: 20px;
        }

=======
        
        .modal-body {
            margin-bottom: 20px;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
<<<<<<< HEAD

        .batch-actions {
            margin-bottom: 15px;
        }

=======
        
        .batch-actions {
            margin-bottom: 15px;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        @media (max-width: 768px) {
            .filter-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
<<<<<<< HEAD

            .search-input {
                width: 100%;
            }

            .filter-section {
                width: 100%;
            }

            .filter-select {
                flex-grow: 1;
            }

=======
            
            .search-input {
                width: 100%;
            }
            
            .filter-section {
                width: 100%;
            }
            
            .filter-select {
                flex-grow: 1;
            }
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            .user-stats {
                flex-wrap: wrap;
            }
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .notification.error {
            background-color: #ffebee;
            color: #c62828;
            border-left: 3px solid #ef5350;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .notification.info {
            background-color: #e3f2fd;
            color: #1565c0;
            border-left: 3px solid #42a5f5;
        }
    </style>
</head>
<body>
<<<<<<< HEAD
<!-- Include the navbar -->
<jsp:include page="../navbar.jsp" />

<div class="main-container">
    <div class="manage-users-page">
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-users"></i> Manage Users
            </h1>
            <a href="${pageContext.request.contextPath}/admin/profile" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Profile
            </a>
        </div>

        <!-- Notification messages -->
        <% if (successMessage != null && !successMessage.isEmpty()) { %>
        <div class="notification success">
            <i class="fas fa-check-circle"></i>
            <%= successMessage %>
            <span class="close-notification"><i class="fas fa-times"></i></span>
        </div>
        <% } %>

        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
        <div class="notification error">
            <i class="fas fa-exclamation-circle"></i>
            <%= errorMessage %>
            <span class="close-notification"><i class="fas fa-times"></i></span>
        </div>
        <% } %>

        <% if (infoMessage != null && !infoMessage.isEmpty()) { %>
        <div class="notification info">
            <i class="fas fa-info-circle"></i>
            <%= infoMessage %>
            <span class="close-notification"><i class="fas fa-times"></i></span>
        </div>
        <% } %>

        <!-- User Stats -->
        <div class="user-stats">
            <div class="stat-badge">
                <i class="fas fa-users"></i>
                Total Users: <span class="count"><%= totalUsers %></span>
            </div>
            <div class="stat-badge pending">
                <i class="fas fa-clock"></i>
                Pending Approval: <span class="count"><%= pendingUsers %></span>
            </div>
            <div class="stat-badge">
                <i class="fas fa-user-check"></i>
                Active Users: <span class="count"><%= activeUsers %></span>
            </div>
        </div>

        <!-- Filter and Search -->
        <form action="${pageContext.request.contextPath}/admin/manage-users" method="get" class="filter-bar">
            <div class="filter-section">
                <label class="filter-label" for="roleFilter">Filter by Role:</label>
                <select name="roleFilter" id="roleFilter" class="filter-select">
                    <option value="ALL" <%= roleFilter.equals("ALL") ? "selected" : "" %>>All Roles</option>
                    <option value="PENDING" <%= roleFilter.equals("PENDING") ? "selected" : "" %>>Pending</option>
                    <option value="USER" <%= roleFilter.equals("USER") ? "selected" : "" %>>User</option>
                    <option value="MANAGER" <%= roleFilter.equals("MANAGER") ? "selected" : "" %>>Manager</option>
                    <option value="ADMIN" <%= roleFilter.equals("ADMIN") ? "selected" : "" %>>Admin</option>
                </select>
            </div>

            <div class="filter-section">
                <input type="text" name="searchQuery" placeholder="Search by username or email"
                       class="search-input" value="<%= searchQuery %>">
            </div>

            <div class="filter-section">
                <button type="submit" class="filter-button">
                    <i class="fas fa-filter"></i> Apply Filter
                </button>
                <a href="${pageContext.request.contextPath}/admin/manage-users" class="filter-button clear">
                    <i class="fas fa-times"></i> Clear
                </a>
            </div>
        </form>

        <!-- Users table -->
        <div class="users-container">
            <% if (pendingUsers > 0) { %>
            <div class="batch-actions">
                <button type="button" class="filter-button" onclick="showBatchApproveDialog()">
                    <i class="fas fa-check-double"></i> Approve All Pending Users (<%= pendingUsers %>)
                </button>
            </div>
            <% } %>
            <div class="table-container">
                <table class="users-table">
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
                    <% if (users != null && !users.isEmpty()) {
                        for(User user : users) {
                            // Skip the current admin user (own account)
                            if (user.getUserId() != admin.getUserId()) {
                    %>
                    <tr data-user-id="<%= user.getUserId() %>">
                        <td><%= user.getUserId() %></td>
                        <td>
                            <div class="user-info">
                                <div class="user-avatar">
                                    <%= user.getUserName().substring(0, Math.min(2, user.getUserName().length())).toUpperCase() %>
                                </div>
                                <%= user.getUserName() %>
                            </div>
                        </td>
                        <td><%= user.getEmail() %></td>
                        <td>
                            <span class="role-badge <%= user.getRole().toLowerCase() %>"><%= user.getRole() %></span>

                            <!-- Role change form -->
                            <form action="${pageContext.request.contextPath}/admin/manage-users" method="post" style="display:inline; margin-left: 8px;">
                                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                                <input type="hidden" name="action" value="changeRole">
                                <input type="hidden" name="roleFilter" value="<%= roleFilter %>">
                                <input type="hidden" name="searchQuery" value="<%= searchQuery %>">

                                <select name="newRole" class="role-select" onchange="this.form.submit()">
                                    <option value="">Change role</option>
                                    <option value="USER">User</option>
                                    <option value="MANAGER">Manager</option>
                                    <option value="ADMIN">Admin</option>
                                </select>
                            </form>
                        </td>
                        <td>
                            <% if (user.getCreatedAt() != null) { %>
                            <%= new java.text.SimpleDateFormat("MM/dd/yyyy").format(user.getCreatedAt()) %>
                            <% } else { %>
                            N/A
                            <% } %>
                        </td>
                        <td class="actions">
                            <button type="button" class="btn btn-approve"
                                    onclick="confirmApprove(<%= user.getUserId() %>, '<%= user.getUserName() %>')" title="<%= "PENDING".equals(user.getRole()) ? "Approve User" : "Approve User" %>">
                                <i class="fas fa-check-circle"></i> Approve
                            </button>

                            <button class="btn btn-delete" title="Delete User"
                                    onclick="confirmDelete(<%= user.getUserId() %>, '<%= user.getUserName() %>')">
                                <i class="fas fa-trash-alt"></i> Delete
                            </button>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    } else { %>
                    <tr>
                        <td colspan="6" class="no-users">No users found</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="confirmDeleteModal" class="modal-overlay">
    <div class="modal">
        <div class="modal-header">
            <h3 class="modal-title">Confirm Deletion</h3>
            <button class="modal-close" onclick="closeModal('confirmDeleteModal')">&times;</button>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to delete user <strong id="userToDelete"></strong>?</p>
            <p>This action cannot be undone.</p>
        </div>
        <div class="modal-footer">
            <button class="filter-button clear" onclick="closeModal('confirmDeleteModal')">Cancel</button>
            <form id="deleteUserForm" action="${pageContext.request.contextPath}/admin/manage-users" method="post">
                <input type="hidden" name="userId" id="deleteUserId">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="roleFilter" value="<%= roleFilter %>">
                <input type="hidden" name="searchQuery" value="<%= searchQuery %>">
                <button type="submit" class="btn btn-delete">Confirm Delete</button>
            </form>
        </div>
    </div>
</div>

<!-- Approval Confirmation Modal -->
<div id="confirmApproveModal" class="modal-overlay">
    <div class="modal">
        <div class="modal-header">
            <h3 class="modal-title" id="approvalModalTitle">Confirm Approval</h3>
            <button class="modal-close" onclick="closeModal('confirmApproveModal')">&times;</button>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to approve user <strong id="userToApprove"></strong>?</p>
            <p id="approvalDescription">This will change their role to USER and grant them access to the system.</p>
        </div>
        <div class="modal-footer">
            <button class="filter-button clear" onclick="closeModal('confirmApproveModal')">Cancel</button>
            <form id="approveUserForm" action="${pageContext.request.contextPath}/admin/manage-users" method="post">
                <input type="hidden" name="userId" id="approveUserId">
                <input type="hidden" name="action" value="approve">
                <input type="hidden" name="roleFilter" value="<%= roleFilter %>">
                <input type="hidden" name="searchQuery" value="<%= searchQuery %>">
                <button type="submit" class="btn btn-approve" id="approvalButton">Approve User</button>
            </form>
        </div>
    </div>
</div>

<!-- Batch Approval Confirmation Modal -->
<div id="batchApproveModal" class="modal-overlay">
    <div class="modal">
        <div class="modal-header">
            <h3 class="modal-title">Batch Approve All Pending Users</h3>
            <button class="modal-close" onclick="closeModal('batchApproveModal')">&times;</button>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to approve <strong><%= pendingUsers %></strong> pending users?</p>
            <p>This will change their role from PENDING to USER and grant them access to the system.</p>
        </div>
        <div class="modal-footer">
            <button class="filter-button clear" onclick="closeModal('batchApproveModal')">Cancel</button>
            <form id="batchApproveForm" action="${pageContext.request.contextPath}/admin/batch-approve" method="post">
                <input type="hidden" name="roleFilter" value="<%= roleFilter %>">
                <input type="hidden" name="searchQuery" value="<%= searchQuery %>">
                <button type="submit" class="btn btn-approve">Approve All Pending Users</button>
            </form>
        </div>
    </div>
</div>

<!-- Include footer -->
<jsp:include page="admin_footer.jsp" />

<script>
    // JavaScript for notification dismissal
    document.addEventListener('DOMContentLoaded', function() {
        const closeButtons = document.querySelectorAll('.close-notification');
        closeButtons.forEach(button => {
            button.addEventListener('click', function() {
                this.parentElement.style.display = 'none';
            });
        });

        // Auto-dismiss notifications after 5 seconds
        setTimeout(function() {
            const notifications = document.querySelectorAll('.notification');
            notifications.forEach(notification => {
                notification.style.display = 'none';
            });
        }, 5000);
    });

    // User deletion confirmation
    function confirmDelete(userId, userName) {
        document.getElementById('userToDelete').textContent = userName;
        document.getElementById('deleteUserId').value = userId;
        document.getElementById('confirmDeleteModal').style.display = 'flex';
    }

    // User approval confirmation
    function confirmApprove(userId, userName) {
        const isUserPending = document.querySelector(`tr[data-user-id="${userId}"] .role-badge`).textContent.trim() === "PENDING";

        document.getElementById('userToApprove').textContent = userName;
        document.getElementById('approveUserId').value = userId;

        // Update modal title and content based on user status
        document.getElementById('approvalModalTitle').textContent = "Confirm Approval";
        document.getElementById('actionType').textContent = "approve";

        if (isUserPending) {
            document.getElementById('approvalDescription').textContent = "This will change their role from PENDING to USER and grant them access to the system.";
        } else {
            document.getElementById('approvalDescription').textContent = "This will set their role to USER, allowing them to access user features.";
        }

        document.getElementById('approvalButton').textContent = "Approve User";
        document.getElementById('confirmApproveModal').style.display = 'flex';
    }

    // Show batch approve dialog
    function showBatchApproveDialog() {
        document.getElementById('batchApproveModal').style.display = 'flex';
    }

    // Close modal by ID
    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    // Close modals when clicking outside
    window.addEventListener('click', function(event) {
        const deleteModal = document.getElementById('confirmDeleteModal');
        const approveModal = document.getElementById('confirmApproveModal');
        const batchApproveModal = document.getElementById('batchApproveModal');

        if (event.target === deleteModal) {
            closeModal('confirmDeleteModal');
        } else if (event.target === approveModal) {
            closeModal('confirmApproveModal');
        } else if (event.target === batchApproveModal) {
            closeModal('batchApproveModal');
        }
    });
</script>
=======
    <!-- Include the navbar -->
    <jsp:include page="../navbar.jsp" />
    
    <div class="main-container">
        <div class="manage-users-page">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-users"></i> Manage Users
                </h1>
                <a href="${pageContext.request.contextPath}/admin/profile" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Profile
                </a>
            </div>
            
            <!-- Notification messages -->
            <% if (successMessage != null && !successMessage.isEmpty()) { %>
                <div class="notification success">
                    <i class="fas fa-check-circle"></i>
                    <%= successMessage %>
                    <span class="close-notification"><i class="fas fa-times"></i></span>
                </div>
            <% } %>
            
            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                <div class="notification error">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= errorMessage %>
                    <span class="close-notification"><i class="fas fa-times"></i></span>
                </div>
            <% } %>
            
            <% if (infoMessage != null && !infoMessage.isEmpty()) { %>
                <div class="notification info">
                    <i class="fas fa-info-circle"></i>
                    <%= infoMessage %>
                    <span class="close-notification"><i class="fas fa-times"></i></span>
                </div>
            <% } %>
            
            <!-- User Stats -->
            <div class="user-stats">
                <div class="stat-badge">
                    <i class="fas fa-users"></i> 
                    Total Users: <span class="count"><%= totalUsers %></span>
                </div>
                <div class="stat-badge pending">
                    <i class="fas fa-clock"></i> 
                    Pending Approval: <span class="count"><%= pendingUsers %></span>
                </div>
                <div class="stat-badge">
                    <i class="fas fa-user-check"></i> 
                    Active Users: <span class="count"><%= activeUsers %></span>
                </div>
            </div>
            
            <!-- Filter and Search -->
            <form action="${pageContext.request.contextPath}/admin/manage-users" method="get" class="filter-bar">
                <div class="filter-section">
                    <label class="filter-label" for="roleFilter">Filter by Role:</label>
                    <select name="roleFilter" id="roleFilter" class="filter-select">
                        <option value="ALL" <%= roleFilter.equals("ALL") ? "selected" : "" %>>All Roles</option>
                        <option value="PENDING" <%= roleFilter.equals("PENDING") ? "selected" : "" %>>Pending</option>
                        <option value="USER" <%= roleFilter.equals("USER") ? "selected" : "" %>>User</option>
                        <option value="MANAGER" <%= roleFilter.equals("MANAGER") ? "selected" : "" %>>Manager</option>
                        <option value="ADMIN" <%= roleFilter.equals("ADMIN") ? "selected" : "" %>>Admin</option>
                    </select>
                </div>
                
                <div class="filter-section">
                    <input type="text" name="searchQuery" placeholder="Search by username or email" 
                           class="search-input" value="<%= searchQuery %>">
                </div>
                
                <div class="filter-section">
                    <button type="submit" class="filter-button">
                        <i class="fas fa-filter"></i> Apply Filter
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/manage-users" class="filter-button clear">
                        <i class="fas fa-times"></i> Clear
                    </a>
                </div>
            </form>
            
            <!-- Users table -->
            <div class="users-container">
                <% if (pendingUsers > 0) { %>
                <div class="batch-actions">
                    <button type="button" class="filter-button" onclick="showBatchApproveDialog()">
                        <i class="fas fa-check-double"></i> Approve All Pending Users (<%= pendingUsers %>)
                    </button>
                </div>
                <% } %>
                <div class="table-container">
                    <table class="users-table">
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
                            <% if (users != null && !users.isEmpty()) { 
                                for(User user : users) {
                                    // Skip the current admin user (own account)
                                    if (user.getUserId() != admin.getUserId()) {
                            %>
                                <tr data-user-id="<%= user.getUserId() %>">
                                    <td><%= user.getUserId() %></td>
                                    <td>
                                        <div class="user-info">
                                            <div class="user-avatar">
                                                <%= user.getUserName().substring(0, Math.min(2, user.getUserName().length())).toUpperCase() %>
                                            </div>
                                            <%= user.getUserName() %>
                                        </div>
                                    </td>
                                    <td><%= user.getEmail() %></td>
                                    <td>
                                        <span class="role-badge <%= user.getRole().toLowerCase() %>"><%= user.getRole() %></span>
                                        
                                        <!-- Role change form -->
                                        <form action="${pageContext.request.contextPath}/admin/manage-users" method="post" style="display:inline; margin-left: 8px;">
                                            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                                            <input type="hidden" name="action" value="changeRole">
                                            <input type="hidden" name="roleFilter" value="<%= roleFilter %>">
                                            <input type="hidden" name="searchQuery" value="<%= searchQuery %>">
                                            
                                            <select name="newRole" class="role-select" onchange="this.form.submit()">
                                                <option value="">Change role</option>
                                                <option value="USER">User</option>
                                                <option value="MANAGER">Manager</option>
                                                <option value="ADMIN">Admin</option>
                                            </select>
                                        </form>
                                    </td>
                                    <td>
                                        <% if (user.getCreatedAt() != null) { %>
                                            <%= new java.text.SimpleDateFormat("MM/dd/yyyy").format(user.getCreatedAt()) %>
                                        <% } else { %>
                                            N/A
                                        <% } %>
                                    </td>
                                    <td class="actions">
                                        <button type="button" class="btn btn-approve" 
                                                onclick="confirmApprove(<%= user.getUserId() %>, '<%= user.getUserName() %>')" title="<%= "PENDING".equals(user.getRole()) ? "Approve User" : "Approve User" %>">
                                            <i class="fas fa-check-circle"></i> Approve
                                        </button>
                                        
                                        <button class="btn btn-delete" title="Delete User" 
                                                onclick="confirmDelete(<%= user.getUserId() %>, '<%= user.getUserName() %>')">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </button>
                                    </td>
                                </tr>
                            <% 
                                    }
                                }
                            } else { %>
                                <tr>
                                    <td colspan="6" class="no-users">No users found</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div id="confirmDeleteModal" class="modal-overlay">
        <div class="modal">
            <div class="modal-header">
                <h3 class="modal-title">Confirm Deletion</h3>
                <button class="modal-close" onclick="closeModal('confirmDeleteModal')">&times;</button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete user <strong id="userToDelete"></strong>?</p>
                <p>This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button class="filter-button clear" onclick="closeModal('confirmDeleteModal')">Cancel</button>
                <form id="deleteUserForm" action="${pageContext.request.contextPath}/admin/manage-users" method="post">
                    <input type="hidden" name="userId" id="deleteUserId">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="roleFilter" value="<%= roleFilter %>">
                    <input type="hidden" name="searchQuery" value="<%= searchQuery %>">
                    <button type="submit" class="btn btn-delete">Confirm Delete</button>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Approval Confirmation Modal -->
    <div id="confirmApproveModal" class="modal-overlay">
        <div class="modal">
            <div class="modal-header">
                <h3 class="modal-title" id="approvalModalTitle">Confirm Approval</h3>
                <button class="modal-close" onclick="closeModal('confirmApproveModal')">&times;</button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to approve user <strong id="userToApprove"></strong>?</p>
                <p id="approvalDescription">This will change their role to USER and grant them access to the system.</p>
            </div>
            <div class="modal-footer">
                <button class="filter-button clear" onclick="closeModal('confirmApproveModal')">Cancel</button>
                <form id="approveUserForm" action="${pageContext.request.contextPath}/admin/manage-users" method="post">
                    <input type="hidden" name="userId" id="approveUserId">
                    <input type="hidden" name="action" value="approve">
                    <input type="hidden" name="roleFilter" value="<%= roleFilter %>">
                    <input type="hidden" name="searchQuery" value="<%= searchQuery %>">
                    <button type="submit" class="btn btn-approve" id="approvalButton">Approve User</button>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Batch Approval Confirmation Modal -->
    <div id="batchApproveModal" class="modal-overlay">
        <div class="modal">
            <div class="modal-header">
                <h3 class="modal-title">Batch Approve All Pending Users</h3>
                <button class="modal-close" onclick="closeModal('batchApproveModal')">&times;</button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to approve <strong><%= pendingUsers %></strong> pending users?</p>
                <p>This will change their role from PENDING to USER and grant them access to the system.</p>
            </div>
            <div class="modal-footer">
                <button class="filter-button clear" onclick="closeModal('batchApproveModal')">Cancel</button>
                <form id="batchApproveForm" action="${pageContext.request.contextPath}/admin/batch-approve" method="post">
                    <input type="hidden" name="roleFilter" value="<%= roleFilter %>">
                    <input type="hidden" name="searchQuery" value="<%= searchQuery %>">
                    <button type="submit" class="btn btn-approve">Approve All Pending Users</button>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Include footer -->
    <jsp:include page="admin_footer.jsp" />
    
    <script>
        // JavaScript for notification dismissal
        document.addEventListener('DOMContentLoaded', function() {
            const closeButtons = document.querySelectorAll('.close-notification');
            closeButtons.forEach(button => {
                button.addEventListener('click', function() {
                    this.parentElement.style.display = 'none';
                });
            });
            
            // Auto-dismiss notifications after 5 seconds
            setTimeout(function() {
                const notifications = document.querySelectorAll('.notification');
                notifications.forEach(notification => {
                    notification.style.display = 'none';
                });
            }, 5000);
        });
        
        // User deletion confirmation
        function confirmDelete(userId, userName) {
            document.getElementById('userToDelete').textContent = userName;
            document.getElementById('deleteUserId').value = userId;
            document.getElementById('confirmDeleteModal').style.display = 'flex';
        }
        
        // User approval confirmation
        function confirmApprove(userId, userName) {
            const isUserPending = document.querySelector(`tr[data-user-id="${userId}"] .role-badge`).textContent.trim() === "PENDING";
            
            document.getElementById('userToApprove').textContent = userName;
            document.getElementById('approveUserId').value = userId;
            
            // Update modal title and content based on user status
            document.getElementById('approvalModalTitle').textContent = "Confirm Approval";
            document.getElementById('actionType').textContent = "approve";
            
            if (isUserPending) {
                document.getElementById('approvalDescription').textContent = "This will change their role from PENDING to USER and grant them access to the system.";
            } else {
                document.getElementById('approvalDescription').textContent = "This will set their role to USER, allowing them to access user features.";
            }
            
            document.getElementById('approvalButton').textContent = "Approve User";
            document.getElementById('confirmApproveModal').style.display = 'flex';
        }
        
        // Show batch approve dialog
        function showBatchApproveDialog() {
            document.getElementById('batchApproveModal').style.display = 'flex';
        }
        
        // Close modal by ID
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }
        
        // Close modals when clicking outside
        window.addEventListener('click', function(event) {
            const deleteModal = document.getElementById('confirmDeleteModal');
            const approveModal = document.getElementById('confirmApproveModal');
            const batchApproveModal = document.getElementById('batchApproveModal');
            
            if (event.target === deleteModal) {
                closeModal('confirmDeleteModal');
            } else if (event.target === approveModal) {
                closeModal('confirmApproveModal');
            } else if (event.target === batchApproveModal) {
                closeModal('batchApproveModal');
            }
        });
    </script>
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
</body>
</html> 