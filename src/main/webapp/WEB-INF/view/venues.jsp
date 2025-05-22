<%@ page import="model.Venue" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Venues - Eventify</title>
    <!-- Google Fonts and FontAwesome for consistency -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Shared style.css for navbar and global styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body {
            background-color: #f4f7fa;
            font-family: 'Inter', sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-content {
            flex: 1;
            padding: 40px 20px;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }
        .page-header {
            margin-bottom: 30px;
            text-align: center;
        }
        .page-title {
            font-size: 32px;
            color: #00574b;
            margin-bottom: 10px;
            font-weight: 700;
        }
        .page-description {
            color: #6c757d;
            font-size: 18px;
            max-width: 600px;
            margin: 0 auto;
        }
        .venues-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        .venue-card {
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .venue-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        .venue-header {
            background: linear-gradient(135deg, #00574b 0%, #007c6c 100%);
            color: white;
            padding: 20px;
            position: relative;
        }
        .venue-name {
            font-size: 20px;
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
        }
        .venue-name i {
            margin-right: 10px;
            font-size: 18px;
            background-color: rgba(255, 255, 255, 0.2);
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        .venue-content {
            padding: 20px;
        }
        .venue-detail {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        .venue-detail i {
            color: #00574b;
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        .venue-actions {
            border-top: 1px solid #eee;
            padding: 15px 20px;
            display: flex;
            justify-content: flex-end;
        }
        .btn {
            padding: 10px 20px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            font-size: 14px;
            transition: all 0.2s;
            text-decoration: none;
        }
        .btn:hover {
            text-decoration: none;
        }
        .btn i {
            margin-right: 8px;
        }
        .btn-view {
            background-color: #00574b;
            color: white;
        }
        .btn-view:hover {
            background-color: #004a3f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 87, 75, 0.2);
        }
        .add-venue-btn {
            background-color: #00574b;
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: inline-flex;
            align-items: center;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(0, 87, 75, 0.2);
            text-decoration: none;
        }
        .add-venue-btn i {
            margin-right: 10px;
        }
        .add-venue-btn:hover {
            background-color: #003d35;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 87, 75, 0.3);
        }
        .action-buttons {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }
        .empty-venues {
            text-align: center;
            padding: 40px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
        }
        .empty-venues i {
            font-size: 48px;
            color: #6c757d;
            margin-bottom: 20px;
        }
        .empty-venues h3 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #343a40;
        }
        .empty-venues p {
            color: #6c757d;
            margin-bottom: 25px;
        }
        /* Alert styles */
        .alert {
            padding: 16px;
            margin-bottom: 25px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        .alert-success {
            background-color: #ebf9f1;
            color: #0d6832;
            border-left: 4px solid #0d6832;
        }
        .alert i {
            margin-right: 12px;
            font-size: 22px;
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
        .capacity-badge {
            background-color: rgba(255, 255, 255, 0.2);
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 13px;
            margin-left: 10px;
            display: inline-flex;
            align-items: center;
        }
        .capacity-badge i {
            margin-right: 5px;
            background: none;
            width: auto;
            height: auto;
        }
        @media (max-width: 768px) {
            .venues-container {
                grid-template-columns: 1fr;
            }
            .page-title {
                font-size: 28px;
            }
            .main-content {
                padding: 20px 15px;
            }
        }
    </style>
</head>
<body>
<<<<<<< HEAD
<!-- Include navigation bar -->
<jsp:include page="/WEB-INF/view/navbar.jsp" />

<div class="main-content">
    <%
        // Display success message if available
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
    %>
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <%= successMessage %>
    </div>
    <%
            // Remove the message from session so it doesn't show again on refresh
            session.removeAttribute("successMessage");
        }
    %>

    <div class="page-header">
        <h1 class="page-title">Explore Our Venues</h1>
        <p class="page-description">Discover perfect venues for your events, from intimate gatherings to grand celebrations</p>
    </div>

    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/add-venue" class="add-venue-btn">
            <i class="fas fa-plus"></i> Add New Venue
        </a>
    </div>

    <%
        List<Venue> venues = (List<Venue>) request.getAttribute("venues");
        if (venues != null && !venues.isEmpty()) {
    %>
    <div class="venues-container">
        <% for (Venue venue : venues) { %>
        <div class="venue-card">
            <div class="venue-header">
                <h2 class="venue-name">
                    <i class="fas fa-map-marker-alt"></i>
                    <%= venue.getName() %>
                    <span class="capacity-badge">
                                <i class="fas fa-users"></i> <%= venue.getCapacity() %>
                            </span>
                </h2>
            </div>
            <div class="venue-content">
                <div class="venue-detail">
                    <i class="fas fa-map-pin"></i>
                    <%= venue.getCity() %>
                </div>
                <div class="venue-detail">
                    <i class="fas fa-phone-alt"></i>
                    <%= venue.getContactNumber() %>
                </div>
            </div>
            <div class="venue-actions">
                <button class="btn btn-view" onclick="viewVenue(<%= venue.getId() %>)">
                    <i class="fas fa-eye"></i> View Details
                </button>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="empty-venues">
        <i class="fas fa-map-marked-alt"></i>
        <h3>No Venues Available</h3>
        <p>There are no venues available at the moment. Be the first to add one!</p>
        <a href="${pageContext.request.contextPath}/add-venue" class="add-venue-btn">
            <i class="fas fa-plus"></i> Add New Venue
        </a>
    </div>
    <% } %>
</div>

<!-- Include footer -->
<jsp:include page="/WEB-INF/view/footer.jsp" />

<script>
    function viewVenue(venueId) {
        window.location.href = '${pageContext.request.contextPath}/venue-details?id=' + venueId;
    }

    // Automatically hide the success message after 5 seconds
    setTimeout(function() {
        var successAlert = document.querySelector('.alert-success');
        if (successAlert) {
            successAlert.style.transition = 'opacity 1s';
            successAlert.style.opacity = '0';
            setTimeout(function() {
                successAlert.style.display = 'none';
            }, 1000);
        }
    }, 5000);
</script>
=======
    <!-- Include navigation bar -->
    <jsp:include page="/WEB-INF/view/navbar.jsp" />
    
    <div class="main-content">
        <%
        // Display success message if available
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
        %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <%= successMessage %>
            </div>
        <% 
            // Remove the message from session so it doesn't show again on refresh
            session.removeAttribute("successMessage");
        }
        %>
        
        <div class="page-header">
            <h1 class="page-title">Explore Our Venues</h1>
            <p class="page-description">Discover perfect venues for your events, from intimate gatherings to grand celebrations</p>
        </div>
        
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/add-venue" class="add-venue-btn">
                <i class="fas fa-plus"></i> Add New Venue
            </a>
        </div>
        
        <%
            List<Venue> venues = (List<Venue>) request.getAttribute("venues");
            if (venues != null && !venues.isEmpty()) {
        %>
        <div class="venues-container">
            <% for (Venue venue : venues) { %>
                <div class="venue-card">
                    <div class="venue-header">
                        <h2 class="venue-name">
                            <i class="fas fa-map-marker-alt"></i>
                            <%= venue.getName() %>
                            <span class="capacity-badge">
                                <i class="fas fa-users"></i> <%= venue.getCapacity() %>
                            </span>
                        </h2>
                    </div>
                    <div class="venue-content">
                        <div class="venue-detail">
                            <i class="fas fa-map-pin"></i>
                            <%= venue.getCity() %>
                        </div>
                        <div class="venue-detail">
                            <i class="fas fa-phone-alt"></i>
                            <%= venue.getContactNumber() %>
                        </div>
                    </div>
                    <div class="venue-actions">
                        <button class="btn btn-view" onclick="viewVenue(<%= venue.getId() %>)">
                            <i class="fas fa-eye"></i> View Details
                        </button>
                    </div>
                </div>
            <% } %>
        </div>
        <% } else { %>
            <div class="empty-venues">
                <i class="fas fa-map-marked-alt"></i>
                <h3>No Venues Available</h3>
                <p>There are no venues available at the moment. Be the first to add one!</p>
                <a href="${pageContext.request.contextPath}/add-venue" class="add-venue-btn">
                    <i class="fas fa-plus"></i> Add New Venue
                </a>
            </div>
        <% } %>
    </div>

    <!-- Include footer -->
    <jsp:include page="/WEB-INF/view/footer.jsp" />

    <script>
        function viewVenue(venueId) {
            window.location.href = '${pageContext.request.contextPath}/venue-details?id=' + venueId;
        }
        
        // Automatically hide the success message after 5 seconds
        setTimeout(function() {
            var successAlert = document.querySelector('.alert-success');
            if (successAlert) {
                successAlert.style.transition = 'opacity 1s';
                successAlert.style.opacity = '0';
                setTimeout(function() {
                    successAlert.style.display = 'none';
                }, 1000);
            }
        }, 5000);
    </script>
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
</body>
</html>
