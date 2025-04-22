<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventify - Search Events</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        body {
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }
        /* Header Styles */
        header {
            padding: 20px 0;
            background-color: #fff;
            border-bottom: 1px solid #eee;
        }
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo {
            font-size: 28px;
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
        .search-section {
            margin: 30px 0;
            background-color: #fff;
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
            margin-bottom: 10px;
            font-size: 24px;
        }
        .search-header p {
            font-size: 16px;
        }
        .search-content {
            padding: 30px;
            background-color: #e6e7e9;
            text-align: center;
        }
        .search-content h2 {
            color: #005744;
            margin-bottom: 20px;
            font-size: 22px;
        }
        .search-content p {
            margin-bottom: 30px;
            color: #333;
        }
        .search-form {
            display: flex;
            max-width: 600px;
            margin: 0 auto;
        }
        .search-btn {
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px 0 0 5px;
            padding: 10px 15px;
            display: flex;
            align-items: center;
            color: #333;
        }
        .search-input {
            flex: 1;
            padding: 10px 15px;
            border: 1px solid #ccc;
            border-left: none;
            border-radius: 0 5px 5px 0;
            font-size: 16px;
        }
        /* Footer Styles */
        footer {
            background-color: #005744;
            color: white;
            padding: 40px 0;
            margin-top: 50px;
        }
        .footer-content {
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
    <div class="container">
        <div class="header-content">
            <a href="#" class="logo">Eventify</a>
            <ul class="nav-menu">
                <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
                <li><a href="#"><i class="fa fa-calendar"></i> Events</a></li>
                <li><a href="#"><i class="fa fa-map-marker"></i> Venues</a></li>
                <li><a href="#"><i class="fa fa-user"></i> Admin</a></li>
                <li><a href="#"><i class="fa fa-sign-out"></i> Logout</a></li>
            </ul>
        </div>
    </div>
</header>

<main>
    <div class="container">
        <section class="search-section">
            <div class="search-header">
                <h1>Search Events</h1>
                <p>Find the perfect event destination for you.</p>
            </div>
            <div class="search-content">
                <h2>Start Your Search</h2>
                <p>Enter an event name to find what you're looking for.</p>
                <div class="search-form">
                    <button class="search-btn">
                        <i class="fa fa-search"></i> Search
                    </button>
                    <input type="text" class="search-input" placeholder="Search Events..." name="searchQuery">
                </div>
            </div>
        </section>
    </div>
</main>

<footer>
    <div class="container">
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
                    <span>support@eventify@gmail.com</span>
                </div>
                <div class="contact-info">
                    <i class="fa fa-phone"></i>
                    <span>9826321821</span>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Font Awesome for icons -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
