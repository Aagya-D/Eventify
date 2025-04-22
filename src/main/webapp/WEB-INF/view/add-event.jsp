<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Event - Eventify</title>
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
        
        /* Main content */
        .main-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        /* Form section */
        .form-section {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 60px;
        }
        
        .section-title {
            color: #006158;
            font-size: 28px;
            text-align: center;
            margin-bottom: 30px;
            font-family: 'Playfair Display', serif;
            position: relative;
        }
        
        .section-title::after {
            content: '';
            display: block;
            width: 50px;
            height: 3px;
            background-color: #006158;
            margin: 10px auto 0;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #006158;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #006158;
        }
        
        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }
        
        .btn-container {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        
        .btn {
            padding: 12px 25px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .btn-primary {
            background-color: #006158;
            color: white;
        }
        
        .btn-secondary {
            background-color: #e6e6e6;
            color: #333;
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .btn-primary:hover {
            background-color: #004a45;
        }
        
        .btn-secondary:hover {
            background-color: #d4d4d4;
        }
        
        /* Error message */
        .error-message {
            background-color: #f44336;
            color: white;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
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
        }
    </style>
</head>
<body>
    <!-- Header with navigation -->
    <header>
        <div class="logo">
            <a href="${pageContext.request.contextPath}/">Eventify</a>
        </div>
        
        <ul class="nav-menu">
            <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>
            <li><a href="${pageContext.request.contextPath}/events"><i class="fas fa-calendar-alt"></i> Events</a></li>
            <li><a href="${pageContext.request.contextPath}/venues"><i class="fas fa-map-marker-alt"></i> Venues</a></li>
            <li><a href="${pageContext.request.contextPath}/admin"><i class="fas fa-user-cog"></i> Admin</a></li>
            <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </header>
    
    <div class="main-container">
        <% 
            // Display error message if available
            String error = (String) request.getAttribute("error");
            if (error != null) {
                out.println("<div class='error-message'>" + error + "</div>");
            }
        %>
        
        <section class="form-section">
            <h1 class="section-title">Add New Event</h1>
            
            <form action="${pageContext.request.contextPath}/add-event" method="post">
                <div class="form-group">
                    <label for="name">Event Name</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
                
                <div class="form-group">
                    <label for="dateTime">Date and Time</label>
                    <input type="datetime-local" id="dateTime" name="dateTime" class="form-control" required>
                </div>
                
                <div class="form-group">
                    <label for="venue">Venue</label>
                    <input type="text" id="venue" name="venue" class="form-control" required>
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" class="form-control" required></textarea>
                </div>
                
                <div class="form-group">
                    <label for="manager">Manager</label>
                    <input type="text" id="manager" name="manager" class="form-control" required>
                </div>
                
                <div class="btn-container">
                    <a href="${pageContext.request.contextPath}/events" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Create Event</button>
                </div>
            </form>
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
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/add-event">Add Event</a></li>
                    <li><a href="${pageContext.request.contextPath}/events">All Events</a></li>
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
                    <span>9826323121</span>
                </div>
            </div>
        </div>
    </footer>
</body>
</html> 