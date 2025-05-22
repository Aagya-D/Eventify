<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
=======
<%@ page import="model.Event" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<<<<<<< HEAD
    <title>Eventify Admin - Add Event</title>
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
    <title>Event Details - Eventify</title>
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
=======
        }
        
        body {
            background-color: #f4f7fa;
            color: #333;
            line-height: 1.6;
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        .main-content {
            flex: 1;
            padding: 40px 20px;
            max-width: 1000px;
            margin: 0 auto;
            width: 100%;
        }
        
        /* Event card */
        .event-detail-card {
            background-color: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
        }
        
        .event-header {
            background: linear-gradient(135deg, #00574b 0%, #007c6c 100%);
            color: white;
            padding: 30px;
            position: relative;
        }
        
        .event-date-badge {
            position: absolute;
            top: 30px;
            right: 30px;
            background-color: rgba(255, 255, 255, 0.2);
            padding: 8px 16px;
            border-radius: 30px;
            font-size: 16px;
            display: flex;
            align-items: center;
        }
        
        .event-date-badge i {
            margin-right: 8px;
        }
        
        .event-title {
            font-size: 32px;
            font-weight: 700;
            margin: 0;
            line-height: 1.3;
            padding-right: 160px;
            font-family: 'Montserrat', sans-serif;
        }
        
        .event-status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 500;
            margin-top: 15px;
        }
        
        .status-approved {
            background-color: rgba(25, 135, 84, 0.2);
            color: #198754;
        }
        
        .status-pending {
            background-color: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }
        
        .event-content {
            padding: 40px 30px;
        }
        
        .event-description {
            margin-bottom: 30px;
            color: #495057;
            font-size: 16px;
            line-height: 1.7;
        }
        
        .section-title {
            font-size: 20px;
            font-weight: 600;
            color: #00574b;
            margin-bottom: 15px;
            font-family: 'Montserrat', sans-serif;
        }
        
        .event-meta {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
        }
        
        .meta-icon {
            background-color: rgba(0, 87, 75, 0.1);
            width: 45px;
            height: 45px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }
        
        .meta-icon i {
            color: #00574b;
            font-size: 20px;
        }
        
        .meta-content {
            flex: 1;
        }
        
        .meta-label {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 3px;
        }
        
        .meta-value {
            font-size: 16px;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .attendees-section {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #eee;
        }
        
        .attendee-count {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .attendee-count-icon {
            background-color: rgba(0, 87, 75, 0.1);
            width: 55px;
            height: 55px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
        }
        
        .attendee-count-icon i {
            color: #00574b;
            font-size: 24px;
        }
        
        .attendee-count-value {
            font-size: 32px;
            font-weight: 700;
            color: #2c3e50;
        }
        
        .attendee-count-label {
            font-size: 16px;
            color: #6c757d;
        }
        
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
        }
        
        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s;
        }
        
        .btn i {
            margin-right: 10px;
        }
        
        .btn-primary {
            background-color: #00574b;
            color: white;
            box-shadow: 0 4px 10px rgba(0, 87, 75, 0.2);
        }
        
        .btn-primary:hover {
            background-color: #004a3f;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 87, 75, 0.3);
        }
        
        .btn-outline {
            border: 2px solid #00574b;
            color: #00574b;
            background-color: transparent;
        }
        
        .btn-outline:hover {
            background-color: rgba(0, 87, 75, 0.05);
            transform: translateY(-2px);
        }
        
        .alert {
            padding: 16px;
            margin-bottom: 25px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        
        .alert-error {
            background-color: #fee2e2;
            color: #b91c1c;
            border-left: 4px solid #b91c1c;
        }
        
        .alert i {
            margin-right: 12px;
            font-size: 22px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .event-meta {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 15px;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
            
            .event-date-badge {
                position: static;
                display: inline-flex;
                margin-bottom: 15px;
            }
            
            .event-title {
                padding-right: 0;
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            }
        }
    </style>
</head>
<body>
<<<<<<< HEAD
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
            <h1 class="page-title">Add New Event</h1>
        </div>

        <div class="card">
            <div class="card-header">
                <h2 class="card-title">
                    <i class="fas fa-calendar-plus"></i>
                    Event Details
                </h2>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                        ${errorMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/add-event" method="post">
                <div class="form-group">
                    <label class="form-label" for="name">Event Name*</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="date">Date and Time*</label>
                    <input type="datetime-local" class="form-control" id="date" name="date" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="venue">Venue*</label>
                    <select class="form-control" id="venue" name="venue" required>
                        <option value="">-- Select Venue --</option>
                        <c:forEach var="venue" items="${venues}">
                            <option value="${venue.name}">${venue.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label" for="description">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="4"></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label" for="manager">Event Manager</label>
                    <input type="text" class="form-control" id="manager" name="manager">
                </div>

                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="approved" name="approved">
                    <label class="form-check-label" for="approved">Approve Event</label>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/EventDashboard" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Save Event
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
=======
    <jsp:include page="/WEB-INF/view/navbar.jsp" />
    
    <div class="main-content">
        <% 
            // Display error message if available
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
        <% 
            }
            
            // Get event from request
            Event event = (Event) request.getAttribute("event");
            if (event != null) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
                SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
                String formattedDate = dateFormat.format(event.getDateTime());
                String formattedTime = timeFormat.format(event.getDateTime());
        %>
            <div class="event-detail-card">
                <div class="event-header">
                    <div class="event-date-badge">
                        <i class="far fa-calendar-alt"></i> <%= formattedDate %>
                    </div>
                    <h1 class="event-title"><%= event.getName() %></h1>
                    <div class="event-status <%= event.isApproved() ? "status-approved" : "status-pending" %>">
                        <% if (event.isApproved()) { %>
                            <i class="fas fa-check-circle"></i> Approved
                        <% } else { %>
                            <i class="fas fa-clock"></i> Pending Approval
                        <% } %>
                    </div>
                </div>
                
                <div class="event-content">
                    <% if (event.getDescription() != null && !event.getDescription().trim().isEmpty()) { %>
                        <div class="event-description">
                            <%= event.getDescription() %>
                        </div>
                    <% } else { %>
                        <div class="event-description">
                            No description available for this event.
                        </div>
                    <% } %>
                    
                    <h2 class="section-title">Event Details</h2>
                    <div class="event-meta">
                        <div class="meta-item">
                            <div class="meta-icon">
                                <i class="fas fa-map-marker-alt"></i>
                            </div>
                            <div class="meta-content">
                                <div class="meta-label">Venue</div>
                                <div class="meta-value"><%= event.getVenue() != null ? event.getVenue() : "Not specified" %></div>
                            </div>
                        </div>
                        
                        <div class="meta-item">
                            <div class="meta-icon">
                                <i class="fas fa-calendar-day"></i>
                            </div>
                            <div class="meta-content">
                                <div class="meta-label">Days Until Event</div>
                                <div class="meta-value"><%= event.getDaysUntilEvent() %> days away</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="attendees-section">
                        <h2 class="section-title">Attendees</h2>
                        <div class="attendee-count">
                            <div class="attendee-count-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div>
                                <div class="attendee-count-value"><%= event.getAttendees() %></div>
                                <div class="attendee-count-label">registered attendees</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/events" class="btn btn-outline">
                            <i class="fas fa-arrow-left"></i> Back to Events
                        </a>
                        <% if (event.isApproved()) { %>
                            <form action="${pageContext.request.contextPath}/register-event" method="post">
                                <input type="hidden" name="eventId" value="<%= event.getId() %>">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-ticket-alt"></i> Register to Attend
                                </button>
                            </form>
                        <% } %>
                    </div>
                </div>
            </div>
        <% } else { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> Event not found or error retrieving event details.
            </div>
            <a href="${pageContext.request.contextPath}/events" class="btn btn-outline">
                <i class="fas fa-arrow-left"></i> Back to Events
            </a>
        <% } %>
    </div>
    
    <jsp:include page="/WEB-INF/view/footer.jsp" />
</body>
</html> 
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
