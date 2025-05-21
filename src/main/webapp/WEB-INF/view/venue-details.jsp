<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Venue" %>
<!DOCTYPE html>
<html>
<head>
    <title>Venue Details - Eventify</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fa;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            color: #333;
        }
        .main-content {
            flex: 1;
            padding: 40px 20px;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }
        .venue-details-container {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            padding: 0;
            margin-top: 20px;
            overflow: hidden;
        }
        .venue-banner {
            background: linear-gradient(135deg, #00574b 0%, #007c6c 100%);
            color: white;
            padding: 40px;
            position: relative;
        }
        .venue-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .venue-title {
            margin: 0;
            font-size: 28px;
            font-weight: 600;
            display: flex;
            align-items: center;
        }
        .venue-title i {
            margin-right: 15px;
            font-size: 32px;
            background-color: rgba(255, 255, 255, 0.2);
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        .venue-location {
            font-size: 18px;
            opacity: 0.9;
            margin-top: 10px;
        }
        .venue-content {
            padding: 40px;
        }
        .venue-info {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }
        .info-group {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.03);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .info-group:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.06);
        }
        .info-label {
            font-weight: 600;
            color: #00574b;
            margin-bottom: 10px;
            display: block;
            font-size: 16px;
            display: flex;
            align-items: center;
        }
        .info-label i {
            margin-right: 10px;
            width: 24px;
            text-align: center;
        }
        .info-value {
            font-size: 18px;
            color: #333;
            font-weight: 500;
        }
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            font-size: 15px;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn i {
            margin-right: 10px;
        }
        .btn-back {
            background-color: #f1f3f5;
            color: #495057;
        }
        .btn-back:hover {
            background-color: #e9ecef;
        }
        .btn-update {
            background-color: #00574b;
            color: white;
        }
        .btn-update:hover {
            background-color: #004a3f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 87, 75, 0.2);
        }
        .venue-map {
            margin-top: 40px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            border: 1px solid #eaeaea;
        }
        .section-title {
            font-size: 22px;
            color: #00574b;
            margin-bottom: 20px;
            font-weight: 600;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 10px;
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
        .badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            background-color: rgba(255, 255, 255, 0.25);
            color: white;
            font-weight: 500;
            margin-left: 15px;
        }
        @media (max-width: 768px) {
            .venue-info {
                grid-template-columns: 1fr;
            }
            .venue-title {
                font-size: 22px;
            }
            .venue-title i {
                width: 45px;
                height: 45px;
                font-size: 22px;
            }
            .main-content {
                padding: 20px 15px;
            }
            .venue-banner {
                padding: 25px;
            }
            .venue-content {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <!-- Include navigation bar -->
    <jsp:include page="/WEB-INF/view/navbar.jsp" />
    
    <div class="main-content">
        <div class="venue-details-container">
            <%
                Venue venue = (Venue) request.getAttribute("venue");
                if (venue != null) {
            %>
                <div class="venue-banner">
                    <div class="venue-header">
                        <h1 class="venue-title">
                            <i class="fas fa-map-marker-alt"></i>
                            <%= venue.getName() %>
                            <span class="badge"><i class="fas fa-users"></i> <%= venue.getCapacity() %> capacity</span>
                        </h1>
                    </div>
                    <div class="venue-location">
                        <i class="fas fa-map-pin"></i> <%= venue.getCity() %>
                    </div>
                </div>
                
                <div class="venue-content">
                    <h3 class="section-title">Venue Information</h3>
                    <div class="venue-info">
                        <div class="info-group">
                            <span class="info-label"><i class="fas fa-home"></i> Address</span>
                            <div class="info-value"><%= venue.getAddress() %></div>
                        </div>
                        
                        <div class="info-group">
                            <span class="info-label"><i class="fas fa-city"></i> City</span>
                            <div class="info-value"><%= venue.getCity() %></div>
                        </div>
                        
                        <div class="info-group">
                            <span class="info-label"><i class="fas fa-phone-alt"></i> Contact Number</span>
                            <div class="info-value"><%= venue.getContactNumber() %></div>
                        </div>
                        
                        <div class="info-group">
                            <span class="info-label"><i class="fas fa-users"></i> Capacity</span>
                            <div class="info-value"><%= venue.getCapacity() %> people</div>
                        </div>
                    </div>
                    
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/venues" class="btn btn-back">
                            <i class="fas fa-arrow-left"></i> Back to Venues
                        </a>
                        <a href="${pageContext.request.contextPath}/update-venue?id=<%= venue.getId() %>" class="btn btn-update">
                            <i class="fas fa-edit"></i> Update Venue
                        </a>
                    </div>
                </div>
            <% } else { %>
                <div class="venue-banner">
                    <h1 class="venue-title">
                        <i class="fas fa-exclamation-triangle"></i>
                        Venue Not Found
                    </h1>
                </div>
                <div class="venue-content">
                    <p>The requested venue could not be found.</p>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/venues" class="btn btn-back">
                            <i class="fas fa-arrow-left"></i> Back to Venues
                        </a>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Include footer -->
    <jsp:include page="/WEB-INF/view/footer.jsp" />
</body>
</html> 