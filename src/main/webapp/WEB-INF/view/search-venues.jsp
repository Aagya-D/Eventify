<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventify - Search Venues</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            background-color: #faf8f0;
        }
        /* Header Styles */
        header {
            padding: 15px 20px;
            background-color: #fff;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo {
            font-size: 32px;
            font-weight: bold;
            font-style: italic;
            color: #333;
            text-decoration: none;
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
            color: #005744;
            font-weight: bold;
            display: flex;
            align-items: center;
        }
        .nav-menu a i {
            margin-right: 5px;
        }
        /* Main Content Styles */
        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .search-section {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .search-header {
            background-color: #005744;
            color: white;
            padding: 20px;
        }
        .search-header h1 {
            margin-bottom: 5px;
            font-size: 28px;
        }
        .search-header p {
            font-size: 16px;
        }
        .search-content {
            padding: 30px;
            background-color: #e0e2e5;
            text-align: center;
        }
        .search-content h2 {
            color: #005744;
            margin-bottom: 15px;
            font-size: 22px;
        }
        .search-content p {
            margin-bottom: 25px;
            color: #333;
        }
        .search-form {
            display: flex;
            max-width: 600px;
            margin: 0 auto;
            border: 2px solid #005744;
            border-radius: 5px;
            overflow: hidden;
        }
        .search-btn {
            background-color: #fff;
            border: none;
            padding: 10px 15px;
            display: flex;
            align-items: center;
            color: #333;
        }
        .search-input {
            flex: 1;
            padding: 12px 15px;
            border: none;
            font-size: 16px;
            outline: none;
        }
        /* Footer Styles */
        footer {
            background-color: #005744;
            color: white;
            padding: 40px 20px;
        }
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
        }
        .footer-column {
            flex: 1;
            padding: 0 15px;
        }
        .footer-column h3 {
            margin-bottom: 20px;
            font-size: 18px;
        }
        .footer-column p {
            margin-bottom: 15px;
            font-size: 14px;
        }
        .footer-links {
            list-style: none;
        }
        .footer-links li {
            margin-bottom: 10px;
        }
        .footer-links a {
            color: white;
            text-decoration: none;
            font-size: 14px;
        }
        .contact-info {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .contact-info i {
            margin-right: 10px;
        }
    </style>
</head>
<body>
<header>
    <a href="#" class="logo">Eventify</a>
    <ul class="nav-menu">
        <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
        <li><a href="#"><i class="fa fa-calendar"></i> Events</a></li>
        <li><a href="#"><i class="fa fa-map-marker"></i> Venues</a></li>
        <li><a href="#"><i class="fa fa-user"></i> Admin</a></li>
        <li><a href="#"><i class="fa fa-sign-out"></i> Logout</a></li>
    </ul>
</header>

<main>
    <div class="container">
        <section class="search-section">
            <div class="search-header">
                <h1>Search Venues</h1>
                <p>Find the perfect venue for your event</p>
            </div>
            <div class="search-content">
                <h2>Start Your Search</h2>
                <p>Enter an event name to find what you're looking for.</p>
                <form action="searchVenues.jsp" method="get">
                    <div class="search-form">
                        <button type="submit" class="search-btn">
                            <i class="fa fa-search"></i> Search
                        </button>
                        <input type="text" class="search-input" placeholder="Search Venues..." name="searchQuery">
                    </div>
                </form>
            </div>
        </section>
    </div>
</main>

<footer>
    <div class="footer-content">
        <div class="footer-column">
            <h3>Eventify</h3>
            <p>Your easy event management solution</p>
        </div>
        <div class="footer-column">
            <h3>Quick Links</h3>
            <ul class="footer-links">
                <li><a href="#">Home</a></li>
                <li><a href="#">Add Event</a></li>
                <li><a href="#">All Events</a></li>
            </ul>
        </div>
        <div class="footer-column">
            <h3>Contact</h3>
            <div class="contact-info">
                <i class="fa fa-envelope"></i>
                <span>supporteventify@gmail.com</span>
            </div>
            <div class="contact-info">
                <i class="fa fa-phone"></i>
                <span>9826321921</span>
            </div>
        </div>
    </div>
</footer>

<!-- Font Awesome for icons -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
