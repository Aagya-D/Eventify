<%@ page import="model.Event" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Events - Eventify</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
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
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        /* Page header */
        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .page-title {
            font-size: 36px;
            color: #00574b;
            font-weight: 700;
            margin-bottom: 12px;
            font-family: 'Montserrat', sans-serif;
        }

        .page-subtitle {
            color: #6c757d;
            font-size: 18px;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Events grid */
        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        /* Event card */
        .event-card {
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        .event-header {
            background: linear-gradient(135deg, #00574b 0%, #007c6c 100%);
            color: white;
            padding: 20px;
            position: relative;
        }

        .event-date-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: rgba(255, 255, 255, 0.2);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
        }

        .event-date-badge i {
            margin-right: 6px;
        }

        .event-title {
            font-size: 22px;
            font-weight: 600;
            margin: 0;
            line-height: 1.3;
            padding-right: 100px;
        }

        .event-status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 500;
            margin-top: 10px;
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
            padding: 25px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .event-description {
            margin-bottom: 25px;
            color: #495057;
            flex: 1;
        }

        .event-meta {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 20px;
        }

        .meta-item {
            display: flex;
            align-items: center;
        }

        .meta-item i {
            color: #00574b;
            width: 20px;
            margin-right: 10px;
            text-align: center;
        }

        .event-footer {
            padding: 15px 25px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f9f9f9;
        }

        .attendees {
            display: flex;
            align-items: center;
            color: #6c757d;
            font-size: 14px;
        }

        .attendees i {
            margin-right: 6px;
            color: #00574b;
        }

        .event-actions .btn {
            background-color: #00574b;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }

        .event-actions .btn:hover {
            background-color: #004a3f;
            transform: translateY(-2px);
        }

        /* Add button */
        .action-buttons {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .add-button {
            background-color: #00574b;
            color: white;
            padding: 14px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(0, 87, 75, 0.2);
        }

        .add-button i {
            margin-right: 10px;
            font-size: 18px;
        }

        .add-button:hover {
            background-color: #004a3f;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 87, 75, 0.3);
            text-decoration: none;
        }

        /* Alert messages */
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

        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border-left: 4px solid #856404;
        }

        .alert i {
            margin-right: 12px;
            font-size: 22px;
        }

        /* Empty state */
        .empty-events {
            text-align: center;
            padding: 60px 20px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
        }

        .empty-events i {
            font-size: 60px;
            color: #6c757d;
            margin-bottom: 20px;
        }

        .empty-events h3 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #343a40;
        }

        .empty-events p {
            color: #6c757d;
            margin-bottom: 30px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .events-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .page-title {
                font-size: 28px;
            }

            .main-content {
                padding: 20px 15px;
            }

            .event-meta {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/view/navbar.jsp" />

<div class="main-content">
    <div class="page-header">
        <h1 class="page-title">Discover Amazing Events</h1>
        <p class="page-subtitle">Find and join exciting events happening near you</p>
    </div>

    <%
        // Check for error messages
        String errorMessage = (String) request.getAttribute("error");
        if (errorMessage != null && !errorMessage.isEmpty()) {
    %>
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i> Error: <%= errorMessage %>
    </div>
    <% } %>

    <%
        List<Event> eventList = (List<Event>) request.getAttribute("eventList");
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");

        if (eventList != null && !eventList.isEmpty()) {
    %>
    <div class="events-grid">
        <% for (Event event : eventList) { %>
        <!-- Event Card -->
        <div class="event-card">
            <div class="event-header">
                <div class="event-date-badge">
                    <i class="fas fa-calendar-alt"></i> <%= dateFormat.format(event.getDateTime()) %>
                </div>
                <h3 class="event-title"><%= event.getName() %></h3>
                <% if(event.isApproved()) { %>
                <span class="event-status status-approved">
                            <i class="fas fa-check-circle"></i> Approved
                        </span>
                <% } else { %>
                <span class="event-status status-pending">
                            <i class="fas fa-clock"></i> Pending Approval
                        </span>
                <% } %>
            </div>

            <div class="event-content">
                <p class="event-description"><%= event.getDescription() %></p>

                <div class="event-meta">
                    <div class="meta-item">
                        <i class="fas fa-clock"></i>
                        <span><%= timeFormat.format(event.getDateTime()) %></span>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-hourglass-half"></i>
                        <span><%= event.getDaysUntilEvent() %> days away</span>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span><%= event.getVenue() %></span>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-user"></i>
                        <span><%= event.getManager() %></span>
                    </div>
                </div>
            </div>

            <div class="event-footer">
                <div class="attendees">
                    <i class="fas fa-users"></i>
                    <span><%= event.getAttendees() %> attendees</span>
                </div>
                <div class="event-actions">
                    <a href="${pageContext.request.contextPath}/event-details?id=<%= event.getId() %>" class="btn">View Details</a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="empty-events">
        <i class="fas fa-calendar-times"></i>
        <h3>No Events Available</h3>
        <p>There are no events available at the moment. Be the first to create an exciting event for everyone to join!</p>
        <a href="add-event" class="add-button">
            <i class="fas fa-plus-circle"></i> Create New Event
        </a>
    </div>
    <% } %>

    <div class="action-buttons">
        <a href="add-event" class="add-button">
            <i class="fas fa-plus-circle"></i> Create New Event
        </a>
    </div>
</div>
<jsp:include page="/WEB-INF/view/footer.jsp" />
</body>
</html> 