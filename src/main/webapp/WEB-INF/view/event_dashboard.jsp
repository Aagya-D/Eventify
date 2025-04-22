<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evently Admin Dashboard</title>
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
        .event-approval {
            background-color: #00574b;
            color: white;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .event-approval h2 {
            display: flex;
            align-items: center;
        }
        .event-approval h2 i {
            margin-right: 10px;
        }
        .event-list {
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
        .event-table {
            width: 100%;
        }
        .event-table th {
            text-align: left;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .event-table td {
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .toggle {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }
        .toggle input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 16px;
            width: 16px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider {
            background-color: #00574b;
        }
        input:checked + .slider:before {
            transform: translateX(26px);
        }
        .update-btn {
            background-color: #00574b;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            float: right;
            margin-top: 10px;
            display: flex;
            align-items: center;
        }
        .update-btn i {
            margin-right: 5px;
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

        <a href="#" class="nav-item">
            <i class="fas fa-th-large"></i>
            Dashboard
        </a>

        <a href="#" class="nav-item active">
            <i class="far fa-calendar-alt"></i>
            Events
        </a>

        <a href="#" class="nav-item">
            <i class="fas fa-map-marker-alt"></i>
            Venues
        </a>

        <div style="margin-top: auto;"></div>

        <a href="#" class="nav-item" style="margin-top: 150px;">
            <i class="far fa-user"></i>
            My Profile
        </a>

        <a href="#" class="nav-item">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>

    <div class="main-content">
        <div class="header">
            <div class="nav-links">
                <a href="#"><i class="fas fa-home"></i> Home</a>
                <a href="#"><i class="far fa-calendar-alt"></i> Events</a>
                <a href="#"><i class="fas fa-map-marker-alt"></i> Venues</a>
            </div>

            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search here....">
            </div>
        </div>

        <div class="event-approval">
            <h2><i class="far fa-calendar-check"></i> Event Approval</h2>
        </div>

        <div class="event-list">
            <div class="filter-dropdown">
                <select>
                    <option>All Events</option>
                    <option>Pending Approval</option>
                    <option>Approved</option>
                    <option>Rejected</option>
                </select>
            </div>

            <table class="event-table">
                <thead>
                <tr>
                    <th>Events Name</th>
                    <th style="text-align: right;">Approved</th>
                </tr>
                </thead>
                <tbody>
                <%-- In a real application, you would fetch events from a database --%>
                <c:forEach var="event" items="${eventsList}" varStatus="status">
                    <tr>
                        <td><i class="far fa-calendar-alt"></i> ${event.name}</td>
                        <td style="text-align: right;">
                            <label class="toggle">
                                <input type="checkbox" name="approved" value="${event.id}" ${event.approved ? 'checked' : ''}>
                                <span class="slider"></span>
                            </label>
                        </td>
                    </tr>
                </c:forEach>

                <%-- Fallback static content if no events are loaded --%>
                <c:if test="${empty eventsList}">
                    <tr>
                        <td><i class="far fa-calendar-alt"></i> Alzena's Birthday</td>
                        <td style="text-align: right;">
                            <label class="toggle">
                                <input type="checkbox" checked>
                                <span class="slider"></span>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="far fa-calendar-alt"></i> Baby Shower</td>
                        <td style="text-align: right;">
                            <label class="toggle">
                                <input type="checkbox" checked>
                                <span class="slider"></span>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="far fa-calendar-alt"></i> Arjun's Wedding</td>
                        <td style="text-align: right;">
                            <label class="toggle">
                                <input type="checkbox" checked>
                                <span class="slider"></span>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="far fa-calendar-alt"></i> Arjun's Rice Pudding</td>
                        <td style="text-align: right;">
                            <label class="toggle">
                                <input type="checkbox">
                                <span class="slider"></span>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="far fa-calendar-alt"></i> Press Conference</td>
                        <td style="text-align: right;">
                            <label class="toggle">
                                <input type="checkbox" checked>
                                <span class="slider"></span>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="far fa-calendar-alt"></i> Ishya's Anniversary</td>
                        <td style="text-align: right;">
                            <label class="toggle">
                                <input type="checkbox" checked>
                                <span class="slider"></span>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="far fa-calendar-alt"></i> Christmas Party</td>
                        <td style="text-align: right;">
                            <label class="toggle">
                                <input type="checkbox" checked>
                                <span class="slider"></span>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="far fa-calendar-alt"></i> Parvati's Engagement</td>
                        <td style="text-align: right;">
                            <label class="toggle">
                                <input type="checkbox">
                                <span class="slider"></span>
                            </label>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>

            <form action="updateApprovals.jsp" method="post">
                <button type="submit" class="update-btn">
                    <i class="fas fa-check-circle"></i> Update Approvals
                </button>
            </form>
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
            <a href="#">Home</a>
            <a href="#">Add Event</a>
            <a href="#">All Events</a>
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
