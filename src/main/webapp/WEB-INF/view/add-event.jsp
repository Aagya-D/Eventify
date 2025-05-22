<%@ page import="model.Venue" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Event - Eventify</title>
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
            max-width: 900px;
            margin: 0 auto;
            width: 100%;
        }

        /* Form container */
        .form-container {
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            margin-bottom: 40px;
        }

        /* Form header */
        .form-header {
            background: linear-gradient(135deg, #00574b 0%, #007c6c 100%);
            color: white;
            padding: 30px;
            position: relative;
            text-align: center;
        }

        .form-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 10px;
            font-family: 'Montserrat', sans-serif;
        }

        .form-subtitle {
            font-size: 16px;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Form content */
        .form-content {
            padding: 40px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #495057;
            font-size: 15px;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            transition: all 0.3s;
            background-color: #f8f9fa;
            color: #495057;
        }

        .form-control:focus {
            outline: none;
            border-color: #00574b;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(0, 87, 75, 0.1);
        }

        .form-control::placeholder {
            color: #adb5bd;
        }

        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%23495057' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            padding-right: 40px;
        }

        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }

        /* Icon inputs */
        .input-with-icon {
            position: relative;
        }

        .input-with-icon .form-control {
            padding-left: 45px;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        /* Form actions */
        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
            gap: 20px;
        }

        .btn {
            padding: 14px 28px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex: 1;
        }

        .btn i {
            margin-right: 10px;
        }

        .btn-primary {
            background-color: #00574b;
            color: white;
        }

        .btn-primary:hover {
            background-color: #004a3f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 87, 75, 0.2);
        }

        .btn-secondary {
            background-color: #f1f3f5;
            color: #495057;
            text-decoration: none;
        }

        .btn-secondary:hover {
            background-color: #e9ecef;
            transform: translateY(-2px);
        }

        /* Error message */
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

        /* Form steps indicator */
        .form-steps {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        .step {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: #6c757d;
            margin: 0 15px;
        }

        .step-number {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #e9ecef;
            margin-right: 10px;
            font-weight: 600;
        }

        .step.active {
            color: #00574b;
        }

        .step.active .step-number {
            background-color: #00574b;
            color: white;
        }

        /* Helper text */
        .form-help-text {
            display: block;
            font-size: 13px;
            color: #6c757d;
            margin-top: 5px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-content {
                padding: 20px 15px;
            }

            .form-header {
                padding: 25px 20px;
            }

            .form-title {
                font-size: 24px;
            }

            .form-content {
                padding: 25px 20px;
            }

            .form-actions {
                flex-direction: column-reverse;
            }

            .btn {
                width: 100%;
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
    <% } %>

    <div class="form-container">
        <div class="form-header">
            <h1 class="form-title">Add New Event</h1>
            <p class="form-subtitle">Create an amazing event and invite people to join you</p>
        </div>

        <div class="form-content">
            <div class="form-steps">
                <div class="step active">
                    <div class="step-number">1</div>
                    <span>Event Details</span>
                </div>
                <div class="step">
                    <div class="step-number">2</div>
                    <span>Confirmation</span>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/add-event" method="post" id="event-form">
                <div class="form-group">
                    <label for="name">Event Name</label>
                    <div class="input-with-icon">
                        <i class="fas fa-calendar-alt input-icon"></i>
                        <input type="text" id="name" name="name" class="form-control" placeholder="Enter event name" required>
                    </div>
                    <span class="form-help-text">Choose a catchy name that describes your event</span>
                </div>

                <div class="form-group">
                    <label for="dateTime">Date and Time</label>
                    <div class="input-with-icon">
                        <i class="fas fa-clock input-icon"></i>
                        <input type="datetime-local" id="dateTime" name="dateTime" class="form-control" required>
                    </div>
                    <span class="form-help-text">When will your event take place?</span>
                </div>

                <div class="form-group">
                    <label for="venue">Venue</label>
                    <div class="input-with-icon">
                        <i class="fas fa-map-marker-alt input-icon"></i>
                        <select id="venue" name="venue" class="form-control" required>
                            <option value="">-- Select Venue --</option>
                            <%
                                List<Venue> venues = (List<Venue>) request.getAttribute("venues");
                                if (venues != null && !venues.isEmpty()) {
                                    for (Venue venue : venues) {
                            %>
                            <option value="<%= venue.getId() %>"><%= venue.getName() %> - <%= venue.getCity() %></option>
                            <%
                                }
                            } else {
                            %>
                            <option value="" disabled>No venues available</option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <span class="form-help-text">Where will your event be held?</span>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" class="form-control" placeholder="Describe your event in detail..." required></textarea>
                    <span class="form-help-text">Provide details about what attendees can expect</span>
                </div>

                <div class="form-group">
                    <label for="manager">Manager</label>
                    <div class="input-with-icon">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" id="manager" name="manager" class="form-control" placeholder="Enter manager name" required>
                    </div>
                    <span class="form-help-text">Who will be managing this event?</span>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/events" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus-circle"></i> Create Event
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/view/footer.jsp" />

<script>
    // Add current date as min date for date picker
    document.addEventListener('DOMContentLoaded', function() {
        const now = new Date();
        const year = now.getFullYear();
        let month = now.getMonth() + 1;
        let day = now.getDate();
        let hours = now.getHours();
        let minutes = now.getMinutes();

        // Format with leading zeros
        month = month < 10 ? '0' + month : month;
        day = day < 10 ? '0' + day : day;
        hours = hours < 10 ? '0' + hours : hours;
        minutes = minutes < 10 ? '0' + minutes : minutes;

        const currentDateTime = `${year}-${month}-${day}T${hours}:${minutes}`;
        document.getElementById('dateTime').setAttribute('min', currentDateTime);
    });
</script>
</body>
</html>