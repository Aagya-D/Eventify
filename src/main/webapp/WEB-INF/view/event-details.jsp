<%@ page import="model.Event" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Details - Eventify</title>
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
            }
        }
    </style>
</head>
<body>
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