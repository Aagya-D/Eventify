<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evently Admin - Venue Management</title>
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
        .container {
            display: flex;
            flex: 1;
        }
        .sidebar {
            width: 200px;
            background-color: #00574b;
            color: white;
            padding: 20px;
        }
        .logo {
            font-size: 24px;
            font-style: italic;
            margin-bottom: 5px;
        }
        .admin-text {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 30px;
        }
        .nav-item {
            display: flex;
            align-items: center;
            padding: 12px 0;
            cursor: pointer;
            color: white;
            text-decoration: none;
        }
        .nav-item.active {
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            padding: 12px;
        }
        .nav-item i {
            margin-right: 10px;
        }
        .main-content {
            flex: 1;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            margin-bottom: 20px;
        }
        .nav-links {
            display: flex;
            gap: 20px;
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
        .venue-management {
            background-color: #00574b;
            color: white;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .venue-management h2 {
            display: flex;
            align-items: center;
        }
        .venue-management h2 i {
            margin-right: 10px;
        }
        .venue-list {
            background-color: white;
            border-radius: 5px;
            padding: 15px;
        }
        .filter-dropdown {
            margin-bottom: 15px;
        }
        .filter-dropdown select {
            padding: 5px 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .venue-table {
            width: 100%;
        }
        .venue-table th {
            text-align: left;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
            background-color: #f0f0f0;
        }
        .venue-table td {
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }
        .btn {
            padding: 5px 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #f5f5f5;
            cursor: pointer;
            display: flex;
            align-items: center;
            font-size: 12px;
        }
        .btn i {
            margin-right: 5px;
        }
        .btn-view {
            color: #00574b;
        }
        .btn-update {
            color: #666;
        }
        footer {
            background-color: #00574b;
            color: white;
            padding: 20px;
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="sidebar">
        <div class="logo">Evently</div>
        <div class="admin-text">Admin</div>

        <a href="dashboard.jsp" class="nav-item">
            <i class="fas fa-th-large"></i>
            Dashboard
        </a>

        <a href="events.jsp" class="nav-item">
            <i class="far fa-calendar-alt"></i>
            Events
        </a>

        <a href="venues.jsp" class="nav-item active">
            <i class="fas fa-map-marker-alt"></i>
            Venues
        </a>

        <div style="margin-top: auto;"></div>

        <a href="profile.jsp" class="nav-item" style="margin-top: 150px;">
            <i class="far fa-user"></i>
            My Profile
        </a>

        <a href="logout.jsp" class="nav-item">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>

    <div class="main-content">
        <div class="header">
            <div class="nav-links">
                <a href="index.jsp"><i class="fas fa-home"></i> Home</a>
                <a href="events.jsp"><i class="far fa-calendar-alt"></i> Events</a>
                <a href="venues.jsp"><i class="fas fa-map-marker-alt"></i> Venues</a>
            </div>

            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search here....">
            </div>
        </div>

        <div class="venue-management">
            <h2><i class="fas fa-map-marker-alt"></i> Venue Management</h2>
        </div>

        <div class="venue-list">
            <div class="filter-dropdown">
                <select>
                    <option>All Events</option>
                    <option>Active Venues</option>
                    <option>Inactive Venues</option>
                </select>
            </div>

            <table class="venue-table">
                <thead>
                <tr>
                    <th>Venue Name</th>
                    <th style="text-align: right;">Actions</th>
                </tr>
                </thead>
                <tbody>
                <%-- In a real application, you would fetch venues from a database --%>
                <c:forEach var="venue" items="${venuesList}" varStatus="status">
                    <tr>
                        <td><i class="fas fa-building"></i> ${venue.name}</td>
                        <td>
                            <div class="action-buttons">
                                <a href="viewEvents.jsp?venueId=${venue.id}" class="btn btn-view"><i class="far fa-eye"></i> View Events</a>
                                <a href="updateVenue.jsp?venueId=${venue.id}" class="btn btn-update"><i class="fas fa-edit"></i> Update Venue</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>

                <%-- Fallback static content if no venues are loaded --%>
                <c:if test="${empty venuesList}">
                    <tr>
                        <td><i class="fas fa-building"></i> Level Up</td>
                        <td>
                            <div class="action-buttons">
                                <a href="viewEvents.jsp?venueId=1" class="btn btn-view"><i class="far fa-eye"></i> View Events</a>
                                <a href="updateVenue.jsp?venueId=1" class="btn btn-update"><i class="fas fa-edit"></i> Update Venue</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-building"></i> Soothee Weekend</td>
                        <td>
                            <div class="action-buttons">
                                <a href="viewEvents.jsp?venueId=2" class="btn btn-view"><i class="far fa-eye"></i> View Events</a>
                                <a href="updateVenue.jsp?venueId=2" class="btn btn-update"><i class="fas fa-edit"></i> Update Venue</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-building"></i> Gojur Palace</td>
                        <td>
                            <div class="action-buttons">
                                <a href="viewEvents.jsp?venueId=3" class="btn btn-view"><i class="far fa-eye"></i> View Events</a>
                                <a href="updateVenue.jsp?venueId=3" class="btn btn-update"><i class="fas fa-edit"></i> Update Venue</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-building"></i> Hancock</td>
                        <td>
                            <div class="action-buttons">
                                <a href="viewEvents.jsp?venueId=4" class="btn btn-view"><i class="far fa-eye"></i> View Events</a>
                                <a href="updateVenue.jsp?venueId=4" class="btn btn-update"><i class="fas fa-edit"></i> Update Venue</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-building"></i> The Dwarka's Hotel</td>
                        <td>
                            <div class="action-buttons">
                                <a href="viewEvents.jsp?venueId=5" class="btn btn-view"><i class="far fa-eye"></i> View Events</a>
                                <a href="updateVenue.jsp?venueId=5" class="btn btn-update"><i class="fas fa-edit"></i> Update Venue</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-building"></i> Central Plaza</td>
                        <td>
                            <div class="action-buttons">
                                <a href="viewEvents.jsp?venueId=6" class="btn btn-view"><i class="far fa-eye"></i> View Events</a>
                                <a href="updateVenue.jsp?venueId=6" class="btn btn-update"><i class="fas fa-edit"></i> Update Venue</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-building"></i> Hotel Yak and Yeti</td>
                        <td>
                            <div class="action-buttons">
                                <a href="viewEvents.jsp?venueId=7" class="btn btn-view"><i class="far fa-eye"></i> View Events</a>
                                <a href="updateVenue.jsp?venueId=7" class="btn btn-update"><i class="fas fa-edit"></i> Update Venue</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-building"></i> Hyatt Regency</td>
                        <td>
                            <div class="action-buttons">
                                <a href="viewEvents.jsp?venueId=8" class="btn btn-view"><i class="far fa-eye"></i> View Events</a>
                                <a href="updateVenue.jsp?venueId=8" class="btn btn-update"><i class="fas fa-edit"></i> Update Venue</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-building"></i> Park Village Resort</td>
                        <td>
                            <div class="action-buttons">
                                <a href="viewEvents.jsp?venueId=9" class="btn btn-view"><i class="far fa-eye"></i> View Events</a>
                                <a href="updateVenue.jsp?venueId=9" class="btn btn-update"><i class="fas fa-edit"></i> Update Venue</a>
                            </div>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
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
                <span>support@evently@gmail.com</span>
            </div>
            <div class="contact-item">
                <i class="fas fa-phone"></i>
                <span>9826531921</span>
            </div>
        </div>
    </div>
</footer>
</body>
</html>
