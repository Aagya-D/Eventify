<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Venue - Eventify</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        body {
            background-color: #f4f7fa;
            color: #333;
            line-height: 1.6;
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .main-content {
            flex: 1;
            padding: 40px 20px;
            max-width: 900px;
            margin: 0 auto;
            width: 100%;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Form container */
        .form-container {
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            margin-bottom: 40px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Form header */
        .form-header {
            background: linear-gradient(135deg, #00574b 0%, #007c6c 100%);
            color: white;
            padding: 30px;
            position: relative;
            text-align: center;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .form-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 10px;
            font-family: 'Montserrat', sans-serif;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .form-subtitle {
            font-size: 16px;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Form content */
        .form-content {
            padding: 40px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #495057;
            font-size: 15px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
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
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .form-control:focus {
            outline: none;
            border-color: #00574b;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(0, 87, 75, 0.1);
        }
<<<<<<< HEAD

        .form-control::placeholder {
            color: #adb5bd;
        }

        input[type="number"].form-control {
            -moz-appearance: textfield;
        }

=======
        
        .form-control::placeholder {
            color: #adb5bd;
        }
        
        input[type="number"].form-control {
            -moz-appearance: textfield;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        input[type="number"].form-control::-webkit-outer-spin-button,
        input[type="number"].form-control::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Icon inputs */
        .input-with-icon {
            position: relative;
        }
<<<<<<< HEAD

        .input-with-icon .form-control {
            padding-left: 45px;
        }

=======
        
        .input-with-icon .form-control {
            padding-left: 45px;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Helper text */
        .form-help-text {
            display: block;
            font-size: 13px;
            color: #6c757d;
            margin-top: 5px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Required field marker */
        .required-field {
            color: #00574b;
            margin-left: 2px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Form actions */
        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
            gap: 20px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
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
            text-decoration: none;
        }
<<<<<<< HEAD

        .btn i {
            margin-right: 10px;
        }

=======
        
        .btn i {
            margin-right: 10px;
        }
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .btn-primary {
            background-color: #00574b;
            color: white;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .btn-primary:hover {
            background-color: #004a3f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 87, 75, 0.2);
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .btn-secondary {
            background-color: #f1f3f5;
            color: #495057;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .btn-secondary:hover {
            background-color: #e9ecef;
            transform: translateY(-2px);
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Error message */
        .alert {
            padding: 16px;
            margin-bottom: 25px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .alert-error {
            background-color: #fee2e2;
            color: #b91c1c;
            border-left: 4px solid #b91c1c;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        .alert i {
            margin-right: 12px;
            font-size: 22px;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        /* Responsive */
        @media (max-width: 768px) {
            .main-content {
                padding: 20px 15px;
            }
<<<<<<< HEAD

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

=======
            
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
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<<<<<<< HEAD
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
            <h1 class="form-title">Venue Details</h1>
            <p class="form-subtitle">Add a new venue to host amazing events</p>
        </div>

        <div class="form-content">
            <form action="${pageContext.request.contextPath}/add-venue" method="post" id="venue-form">
                <div class="form-group">
                    <label for="name">Venue Name<span class="required-field">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-building input-icon"></i>
                        <input type="text" id="name" name="name" class="form-control" placeholder="Enter venue name" required>
                    </div>
                    <span class="form-help-text">Enter the official name of the venue</span>
                </div>

                <div class="form-group">
                    <label for="address">Address<span class="required-field">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-map-marker-alt input-icon"></i>
                        <input type="text" id="address" name="address" class="form-control" placeholder="Enter full address" required>
                    </div>
                    <span class="form-help-text">Enter the street address</span>
                </div>

                <div class="form-group">
                    <label for="city">City<span class="required-field">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-city input-icon"></i>
                        <input type="text" id="city" name="city" class="form-control" placeholder="Enter city name" required>
                    </div>
                    <span class="form-help-text">Enter the city where the venue is located</span>
                </div>

                <div class="form-group">
                    <label for="contactNumber">Contact Number<span class="required-field">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-phone-alt input-icon"></i>
                        <input type="text" id="contactNumber" name="contactNumber" class="form-control" placeholder="Enter contact number" required>
                    </div>
                    <span class="form-help-text">Enter a valid phone number for venue inquiries</span>
                </div>

                <div class="form-group">
                    <label for="capacity">Capacity<span class="required-field">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-users input-icon"></i>
                        <input type="number" id="capacity" name="capacity" class="form-control" placeholder="Enter maximum capacity" required min="1">
                    </div>
                    <span class="form-help-text">Enter the maximum number of people the venue can accommodate</span>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/venues" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Save Venue
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/view/footer.jsp" />

<script>
    // Form validation
    document.getElementById('venue-form').addEventListener('submit', function(event) {
        const capacity = document.getElementById('capacity').value;
        if (capacity <= 0) {
            event.preventDefault();
            document.getElementById('capacity').setCustomValidity('Capacity must be greater than zero');
            document.getElementById('capacity').reportValidity();
        } else {
            document.getElementById('capacity').setCustomValidity('');
        }
    });

    // Phone number validation
    document.getElementById('contactNumber').addEventListener('input', function() {
        const phoneInput = this.value.replace(/\D/g, '');
        if (phoneInput.length > 0) {
            this.setCustomValidity('');
        }
    });
</script>
=======
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
                <h1 class="form-title">Venue Details</h1>
                <p class="form-subtitle">Add a new venue to host amazing events</p>
            </div>
            
            <div class="form-content">
                <form action="${pageContext.request.contextPath}/add-venue" method="post" id="venue-form">
                    <div class="form-group">
                        <label for="name">Venue Name<span class="required-field">*</span></label>
                        <div class="input-with-icon">
                            <i class="fas fa-building input-icon"></i>
                            <input type="text" id="name" name="name" class="form-control" placeholder="Enter venue name" required>
                        </div>
                        <span class="form-help-text">Enter the official name of the venue</span>
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Address<span class="required-field">*</span></label>
                        <div class="input-with-icon">
                            <i class="fas fa-map-marker-alt input-icon"></i>
                            <input type="text" id="address" name="address" class="form-control" placeholder="Enter full address" required>
                        </div>
                        <span class="form-help-text">Enter the street address</span>
                    </div>
                    
                    <div class="form-group">
                        <label for="city">City<span class="required-field">*</span></label>
                        <div class="input-with-icon">
                            <i class="fas fa-city input-icon"></i>
                            <input type="text" id="city" name="city" class="form-control" placeholder="Enter city name" required>
                        </div>
                        <span class="form-help-text">Enter the city where the venue is located</span>
                    </div>
                    
                    <div class="form-group">
                        <label for="contactNumber">Contact Number<span class="required-field">*</span></label>
                        <div class="input-with-icon">
                            <i class="fas fa-phone-alt input-icon"></i>
                            <input type="text" id="contactNumber" name="contactNumber" class="form-control" placeholder="Enter contact number" required>
                        </div>
                        <span class="form-help-text">Enter a valid phone number for venue inquiries</span>
                    </div>
                    
                    <div class="form-group">
                        <label for="capacity">Capacity<span class="required-field">*</span></label>
                        <div class="input-with-icon">
                            <i class="fas fa-users input-icon"></i>
                            <input type="number" id="capacity" name="capacity" class="form-control" placeholder="Enter maximum capacity" required min="1">
                        </div>
                        <span class="form-help-text">Enter the maximum number of people the venue can accommodate</span>
                    </div>
                    
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/venues" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Venue
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/view/footer.jsp" />
    
    <script>
        // Form validation
        document.getElementById('venue-form').addEventListener('submit', function(event) {
            const capacity = document.getElementById('capacity').value;
            if (capacity <= 0) {
                event.preventDefault();
                document.getElementById('capacity').setCustomValidity('Capacity must be greater than zero');
                document.getElementById('capacity').reportValidity();
            } else {
                document.getElementById('capacity').setCustomValidity('');
            }
        });
        
        // Phone number validation
        document.getElementById('contactNumber').addEventListener('input', function() {
            const phoneInput = this.value.replace(/\D/g, '');
            if (phoneInput.length > 0) {
                this.setCustomValidity('');
            }
        });
    </script>
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
</body>
</html> 