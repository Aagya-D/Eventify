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
            background-color: #fffdf5;
            color: #333;
            line-height: 1.6;
        }
        
        /* Header styles */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background-color: rgba(255, 253, 245, 0.95);
            border-bottom: 1px solid #eee;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 600;
            color: #006158;
        }
        
        .logo a {
            text-decoration: none;
            color: inherit;
        }
        
        .nav-menu {
            display: flex;
            list-style: none;
        }
        
        .nav-menu li {
            margin-left: 20px;
        }
        
        .nav-menu a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            display: flex;
            align-items: center;
        }
        
        .nav-menu i {
            margin-right: 6px;
        }
        
        .nav-menu a:hover {
            color: #006158;
        }
        
        /* Search bar */
        .search-bar {
            position: relative;
            margin-left: 20px;
        }
        
        .search-bar input {
            padding: 8px 15px;
            padding-right: 40px;
            border: 1px solid #006158;
            border-radius: 30px;
            width: 250px;
            font-size: 14px;
            outline: none;
        }
        
        .search-bar i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #006158;
        }
        
        /* Main content */
        .main-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        /* Events section */
        .events-section {
            background-color: #006158;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 60px;
        }
        
        .section-title {
            color: white;
            font-size: 32px;
            text-align: center;
            margin-bottom: 30px;
            font-family: 'Playfair Display', serif;
        }
        
        .event-card {
            background-color: #f0f0f0;
            border-radius: 8px;
            margin-bottom: 20px;
            overflow: hidden;
        }
        
        .event-title {
            color: white;
            background-color: #006158;
            padding: 15px;
            font-size: 20px;
            font-weight: 500;
            margin: 0;
        }
        
        .event-content {
            display: flex;
        }
        
        .event-details {
            flex: 1;
            padding: 20px;
        }
        
        .event-info {
            margin-bottom: 10px;
            display: flex;
            align-items: flex-start;
        }
        
        .event-info i {
            min-width: 20px;
            margin-right: 10px;
            color: #006158;
        }
        
        .additional-info {
            flex: 1;
            padding: 20px;
            background-color: #e6e6e6;
        }
        
        .info-title {
            font-weight: 600;
            color: #006158;
            margin-bottom: 15px;
        }
        
        /* Add button */
        .add-button {
            display: inline-block;
            background-color: white;
            color: #006158;
            padding: 10px 20px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 500;
            margin-top: 20px;
            float: right;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }
        
        .add-button i {
            margin-right: 8px;
        }
        
        .add-button:hover {
            background-color: #e0e0e0;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        
        /* Footer */
        footer {
            background-color: #006158;
            color: white;
            padding: 60px 5% 30px;
        }
        
        .footer-columns {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-bottom: 40px;
        }
        
        .footer-column {
            flex: 1;
            min-width: 200px;
            margin-bottom: 30px;
        }
        
        .footer-column h3 {
            font-size: 18px;
            margin-bottom: 20px;
            font-family: 'Playfair Display', serif;
        }
        
        .footer-column p {
            margin-bottom: 10px;
            font-size: 14px;
        }
        
        .footer-column ul {
            list-style: none;
        }
        
        .footer-column ul li {
            margin-bottom: 10px;
        }
        
        .footer-column ul li a {
            text-decoration: none;
            color: white;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .footer-column ul li a:hover {
            color: #e1e9e8;
            padding-left: 5px;
        }
        
        .contact-info {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .contact-info i {
            margin-right: 10px;
            width: 20px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="logo">
            <a href="index.jsp">Eventify</a>
        </div>
        <nav>
            <ul class="nav-menu">
                <li><a href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="events"><i class="fas fa-calendar-alt"></i> Events</a></li>
                <li><a href="venues"><i class="fas fa-map-marker-alt"></i> Venues</a></li>
                <li><a href="admin"><i class="fas fa-user-shield"></i> Admin</a></li>
                <li><a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
        <div class="search-bar">
            <input type="text" placeholder="Search here....">
            <i class="fas fa-search"></i>
        </div>
    </header>

    <!-- Main Content -->
    <div class="main-container">
        <section class="events-section">
            <h1 class="section-title">All Events</h1>
            
            <%
                List<Event> eventList = (List<Event>) request.getAttribute("eventList");
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                
                if (eventList != null && !eventList.isEmpty()) {
                    for (Event event : eventList) {
            %>
            
            <!-- Event Card -->
            <div class="event-card">
                <h3 class="event-title"><%= event.getName() %></h3>
                <div class="event-content">
                    <div class="event-details">
                        <h4 class="info-title">Events Details:</h4>
                        <div class="event-info">
                            <i class="fas fa-calendar"></i>
                            <span>Date And Time: <%= dateFormat.format(event.getDateTime()) %></span>
                        </div>
                        <div class="event-info">
                            <i class="fas fa-hourglass-half"></i>
                            <span>Days Till Event: <%= event.getDaysUntilEvent() %></span>
                        </div>
                        <div class="event-info">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Venue: <%= event.getVenue() %></span>
                        </div>
                        <div class="event-info">
                            <i class="fas fa-align-left"></i>
                            <span>Description: <%= event.getDescription() %></span>
                        </div>
                    </div>
                    <div class="additional-info">
                        <h4 class="info-title">Additional Information:</h4>
                        <div class="event-info">
                            <i class="fas fa-user"></i>
                            <span>Manager: <%= event.getManager() %></span>
                        </div>
                        <div class="event-info">
                            <i class="fas fa-check-circle"></i>
                            <span>Approved: <%= event.isApproved() ? "Yes" : "No" %></span>
                        </div>
                        <div class="event-info">
                            <i class="fas fa-users"></i>
                            <span>Attendees: <%= event.getAttendees() %></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <% 
                    }
                } else {
            %>
            <p style="color: white; text-align: center;">No events found.</p>
            <% } %>
            
            <a href="add-event" class="add-button">
                <i class="fas fa-plus-circle"></i> Add New Event
            </a>
        </section>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-columns">
            <div class="footer-column">
                <h3>Eventify</h3>
                <p>Your easy event management solution</p>
            </div>
            <div class="footer-column">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="add-event">Add Event</a></li>
                    <li><a href="events">All Events</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Contact</h3>
                <div class="contact-info">
                    <i class="fas fa-envelope"></i>
                    <span>support@eventify@gmail.com</span>
                </div>
                <div class="contact-info">
                    <i class="fas fa-phone"></i>
                    <span>9826321921</span>
                </div>
            </div>
        </div>
    </footer>
</body>
</html> 