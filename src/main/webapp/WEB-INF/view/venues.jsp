<%@ page import="model.Venue" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Venues - Eventify</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        body {
            background-color: #f8f5eb;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background-color: #f8f5eb;
            border-bottom: 1px solid #e0e0e0;
        }
        .logo {
            font-size: 28px;
            font-style: italic;
            color: #000;
            text-decoration: none;
        }
        .nav-links {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        .nav-links a {
            text-decoration: none;
            color: #00574b;
            font-weight: bold;
            display: flex;
            align-items: center;
        }
        .nav-links i {
            margin-right: 5px;
        }
        .search-bar {
            position: relative;
        }
        .search-bar input {
            padding: 8px 15px 8px 35px;
            border-radius: 20px;
            border: 1px solid #ccc;
            width: 250px;
        }
        .search-bar i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }
        .main-content {
            flex: 1;
            padding: 30px;
            max-width: 900px;
            margin: 0 auto;
            width: 100%;
        }
        .venues-container {
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .venues-header {
            background-color: #00574b;
            color: white;
            padding: 15px 20px;
            font-size: 20px;
        }
        .venues-list {
            background-color: #e9e9e9;
            padding: 20px;
        }
        .venue-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
        }
        .venue-name {
            display: flex;
            align-items: center;
            font-size: 16px;
            font-weight: 500;
        }
        .venue-name i {
            margin-right: 10px;
            color: #00574b;
        }
        .venue-actions {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 6px 12px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-weight: bold;
            display: flex;
            align-items: center;
            font-size: 14px;
        }
        .btn i {
            margin-right: 5px;
        }
        .btn-update {
            background-color: #00574b;
            color: white;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        footer {
            background-color: #00574b;
            color: white;
            padding: 30px;
            margin-top: auto;
        }
        .footer-content {
            display: flex;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
        }
        .footer-section {
            flex: 1;
        }
        .footer-section h3 {
            margin-bottom: 15px;
        }
        .footer-section p, .footer-section a {
            margin-bottom: 10px;
            display: block;
            color: white;
            text-decoration: none;
        }
        .footer-section a:hover {
            text-decoration: underline;
        }
        .contact-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .contact-item i {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <!-- Include navigation bar -->
    <%@ include file="navbar.jsp" %>
    
    <div class="main-container">
        <div class="main-content">
            <div class="venues-container">
                <div class="venues-header">
                    <i class="fas fa-map-marker-alt"></i> Venues
                </div>

                <div class="venues-list">
                    <%-- In a real application, you would fetch venues from a database --%>
                    <c:forEach var="venue" items="${venuesList}" varStatus="status">
                        <div class="venue-item">
                            <div class="venue-name">
                                <i class="fas fa-building"></i> ${venue.name}
                            </div>
                            <div class="venue-actions">
                                <a href="updateVenue.jsp?id=${venue.id}" class="btn btn-update"><i class="fas fa-edit"></i> Update</a>
                                <a href="deleteVenue.jsp?id=${venue.id}" class="btn btn-delete"><i class="fas fa-trash"></i> Delete</a>
                            </div>
                        </div>
                    </c:forEach>

                    <%-- Fallback static content if no venues are loaded --%>
                    <c:if test="${empty venuesList}">
                        <div class="venue-item">
                            <div class="venue-name">
                                <i class="fas fa-building"></i> Soaltee Resturant
                            </div>
                            <div class="venue-actions">
                                <a href="updateVenue.jsp?id=1" class="btn btn-update"><i class="fas fa-edit"></i> Update</a>
                                <a href="deleteVenue.jsp?id=1" class="btn btn-delete"><i class="fas fa-trash"></i> Delete</a>
                            </div>
                        </div>

                        <div class="venue-item">
                            <div class="venue-name">
                                <i class="fas fa-building"></i> Level Up
                            </div>
                            <div class="venue-actions">
                                <a href="updateVenue.jsp?id=2" class="btn btn-update"><i class="fas fa-edit"></i> Update</a>
                                <a href="deleteVenue.jsp?id=2" class="btn btn-delete"><i class="fas fa-trash"></i> Delete</a>
                            </div>
                        </div>

                        <div class="venue-item">
                            <div class="venue-name">
                                <i class="fas fa-building"></i> Hotel Gajur
                            </div>
                            <div class="venue-actions">
                                <a href="updateVenue.jsp?id=3" class="btn btn-update"><i class="fas fa-edit"></i> Update</a>
                                <a href="deleteVenue.jsp?id=3" class="btn btn-delete"><i class="fas fa-trash"></i> Delete</a>
                            </div>
                        </div>

                        <div class="venue-item">
                            <div class="venue-name">
                                <i class="fas fa-building"></i> Hankook
                            </div>
                            <div class="venue-actions">
                                <a href="updateVenue.jsp?id=4" class="btn btn-update"><i class="fas fa-edit"></i> Update</a>
                                <a href="deleteVenue.jsp?id=4" class="btn btn-delete"><i class="fas fa-trash"></i> Delete</a>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>Evently</h3>
                <p>Your easy event management solution</p>
            </div>

            <div class="footer-section">
                <h3>Quick Links</h3>
                <a href="index.jsp">Home</a>
                <a href="addEvent.jsp">Add Event</a>
                <a href="events.jsp">All Events</a>
            </div>

            <div class="footer-section">
                <h3>Contact</h3>
                <div class="contact-item">
                    <i class="far fa-envelope"></i>
                    <span>supportevently@gmail.com</span>
                </div>
                <div class="contact-item">
                    <i class="fas fa-phone"></i>
                    <span>9826321921</span>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>
