<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Venue" %>
<!DOCTYPE html>
<html>
<head>
<<<<<<< HEAD
  <title>Update Venue - Eventify</title>
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
      max-width: 1000px;
      margin: 0 auto;
      width: 100%;
    }
    .update-venue-container {
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
      padding: 0;
      overflow: hidden;
    }
    .form-header {
      background: linear-gradient(135deg, #00574b 0%, #007c6c 100%);
      color: white;
      padding: 30px;
    }
    .form-title {
      margin: 0;
      font-size: 24px;
      display: flex;
      align-items: center;
    }
    .form-title i {
      margin-right: 15px;
      font-size: 28px;
      background-color: rgba(255, 255, 255, 0.2);
      width: 50px;
      height: 50px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
    }
    .form-description {
      margin-top: 10px;
      font-size: 16px;
      opacity: 0.9;
    }
    .form-content {
      padding: 40px;
    }
    .form-group {
      margin-bottom: 25px;
    }
    .form-label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
      color: #495057;
    }
    .form-control {
      width: 100%;
      padding: 12px 15px;
      font-size: 16px;
      border: 1px solid #ced4da;
      border-radius: 8px;
      box-sizing: border-box;
      transition: border-color 0.3s;
    }
    .form-control:focus {
      border-color: #00574b;
      outline: none;
      box-shadow: 0 0 0 3px rgba(0, 87, 75, 0.2);
    }
    .form-footer {
      display: flex;
      justify-content: space-between;
      margin-top: 30px;
    }
    .btn {
      padding: 12px 24px;
      border-radius: 8px;
      border: none;
      cursor: pointer;
      font-weight: 600;
      font-size: 16px;
      transition: all 0.2s;
      display: inline-flex;
      align-items: center;
      text-decoration: none;
    }
    .btn i {
      margin-right: 8px;
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
    }
    .btn-secondary:hover {
      background-color: #e9ecef;
    }
    .error-message {
      color: #dc3545;
      margin-top: 5px;
      font-size: 14px;
    }
    footer {
      background-color: #00574b;
      color: white;
      padding: 30px;
      margin-top: auto;
    }
    @media (max-width: 768px) {
      .form-content {
        padding: 25px;
      }
      .form-header {
        padding: 20px;
      }
      .form-title {
        font-size: 20px;
      }
      .form-title i {
        width: 40px;
        height: 40px;
        font-size: 20px;
      }
      .form-footer {
        flex-direction: column;
        gap: 15px;
      }
      .btn {
        width: 100%;
        justify-content: center;
      }
    }
  </style>
</head>
<body>
<!-- Include navigation bar -->
<jsp:include page="/WEB-INF/view/navbar.jsp" />

<div class="main-content">
  <div class="update-venue-container">
    <div class="form-header">
      <h1 class="form-title">
        <i class="fas fa-edit"></i>
        Update Venue Information
      </h1>
      <p class="form-description">
        Update the details for this venue
      </p>
    </div>

    <div class="form-content">
      <%
        Venue venue = (Venue) request.getAttribute("venue");
        if (venue != null) {
      %>
      <form action="${pageContext.request.contextPath}/update-venue" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="id" value="<%= venue.getId() %>">

        <div class="form-group">
          <label for="name" class="form-label">Venue Name</label>
          <input type="text" id="name" name="name" class="form-control" value="<%= venue.getName() %>" required>
          <div id="nameError" class="error-message"></div>
        </div>

        <div class="form-group">
          <label for="address" class="form-label">Address</label>
          <input type="text" id="address" name="address" class="form-control" value="<%= venue.getAddress() %>" required>
          <div id="addressError" class="error-message"></div>
        </div>

        <div class="form-group">
          <label for="city" class="form-label">City</label>
          <input type="text" id="city" name="city" class="form-control" value="<%= venue.getCity() %>" required>
          <div id="cityError" class="error-message"></div>
        </div>

        <div class="form-group">
          <label for="contactNumber" class="form-label">Contact Number</label>
          <input type="text" id="contactNumber" name="contactNumber" class="form-control" value="<%= venue.getContactNumber() %>" required>
          <div id="contactNumberError" class="error-message"></div>
        </div>

        <div class="form-group">
          <label for="capacity" class="form-label">Capacity (number of people)</label>
          <input type="number" id="capacity" name="capacity" class="form-control" value="<%= venue.getCapacity() %>" min="1" required>
          <div id="capacityError" class="error-message"></div>
        </div>

        <div class="form-footer">
          <a href="${pageContext.request.contextPath}/venue-details?id=<%= venue.getId() %>" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Cancel
          </a>
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Save Changes
          </button>
        </div>
      </form>
      <% } else { %>
      <div class="error-container">
        <h2>Venue Not Found</h2>
        <p>The venue you are trying to update could not be found.</p>
        <a href="${pageContext.request.contextPath}/venues" class="btn btn-secondary">
          <i class="fas fa-arrow-left"></i> Back to Venues
        </a>
      </div>
      <% } %>
    </div>
  </div>
</div>

<!-- Include footer -->
<jsp:include page="/WEB-INF/view/footer.jsp" />

<script>
  function validateForm() {
    let isValid = true;

    // Reset error messages
    document.querySelectorAll('.error-message').forEach(element => {
      element.textContent = '';
    });

    // Validate name
    const name = document.getElementById('name').value.trim();
    if (name === '') {
      document.getElementById('nameError').textContent = 'Venue name is required';
      isValid = false;
    }

    // Validate address
    const address = document.getElementById('address').value.trim();
    if (address === '') {
      document.getElementById('addressError').textContent = 'Address is required';
      isValid = false;
    }

    // Validate city
    const city = document.getElementById('city').value.trim();
    if (city === '') {
      document.getElementById('cityError').textContent = 'City is required';
      isValid = false;
    }

    // Validate contact number
    const contactNumber = document.getElementById('contactNumber').value.trim();
    if (contactNumber === '') {
      document.getElementById('contactNumberError').textContent = 'Contact number is required';
      isValid = false;
    }

    // Validate capacity
    const capacity = document.getElementById('capacity').value;
    if (capacity === '' || parseInt(capacity) < 1) {
      document.getElementById('capacityError').textContent = 'Capacity must be a positive number';
      isValid = false;
    }

    return isValid;
  }
</script>
</body>
</html>
=======
    <title>Update Venue - Eventify</title>
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
            max-width: 1000px;
            margin: 0 auto;
            width: 100%;
        }
        .update-venue-container {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            padding: 0;
            overflow: hidden;
        }
        .form-header {
            background: linear-gradient(135deg, #00574b 0%, #007c6c 100%);
            color: white;
            padding: 30px;
        }
        .form-title {
            margin: 0;
            font-size: 24px;
            display: flex;
            align-items: center;
        }
        .form-title i {
            margin-right: 15px;
            font-size: 28px;
            background-color: rgba(255, 255, 255, 0.2);
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        .form-description {
            margin-top: 10px;
            font-size: 16px;
            opacity: 0.9;
        }
        .form-content {
            padding: 40px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #495057;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        .form-control:focus {
            border-color: #00574b;
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 87, 75, 0.2);
        }
        .form-footer {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            text-decoration: none;
        }
        .btn i {
            margin-right: 8px;
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
        }
        .btn-secondary:hover {
            background-color: #e9ecef;
        }
        .error-message {
            color: #dc3545;
            margin-top: 5px;
            font-size: 14px;
        }
        footer {
            background-color: #00574b;
            color: white;
            padding: 30px;
            margin-top: auto;
        }
        @media (max-width: 768px) {
            .form-content {
                padding: 25px;
            }
            .form-header {
                padding: 20px;
            }
            .form-title {
                font-size: 20px;
            }
            .form-title i {
                width: 40px;
                height: 40px;
                font-size: 20px;
            }
            .form-footer {
                flex-direction: column;
                gap: 15px;
            }
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Include navigation bar -->
    <jsp:include page="/WEB-INF/view/navbar.jsp" />
    
    <div class="main-content">
        <div class="update-venue-container">
            <div class="form-header">
                <h1 class="form-title">
                    <i class="fas fa-edit"></i>
                    Update Venue Information
                </h1>
                <p class="form-description">
                    Update the details for this venue
                </p>
            </div>
            
            <div class="form-content">
                <%
                    Venue venue = (Venue) request.getAttribute("venue");
                    if (venue != null) {
                %>
                <form action="${pageContext.request.contextPath}/update-venue" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="id" value="<%= venue.getId() %>">
                    
                    <div class="form-group">
                        <label for="name" class="form-label">Venue Name</label>
                        <input type="text" id="name" name="name" class="form-control" value="<%= venue.getName() %>" required>
                        <div id="nameError" class="error-message"></div>
                    </div>
                    
                    <div class="form-group">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" id="address" name="address" class="form-control" value="<%= venue.getAddress() %>" required>
                        <div id="addressError" class="error-message"></div>
                    </div>
                    
                    <div class="form-group">
                        <label for="city" class="form-label">City</label>
                        <input type="text" id="city" name="city" class="form-control" value="<%= venue.getCity() %>" required>
                        <div id="cityError" class="error-message"></div>
                    </div>
                    
                    <div class="form-group">
                        <label for="contactNumber" class="form-label">Contact Number</label>
                        <input type="text" id="contactNumber" name="contactNumber" class="form-control" value="<%= venue.getContactNumber() %>" required>
                        <div id="contactNumberError" class="error-message"></div>
                    </div>
                    
                    <div class="form-group">
                        <label for="capacity" class="form-label">Capacity (number of people)</label>
                        <input type="number" id="capacity" name="capacity" class="form-control" value="<%= venue.getCapacity() %>" min="1" required>
                        <div id="capacityError" class="error-message"></div>
                    </div>
                    
                    <div class="form-footer">
                        <a href="${pageContext.request.contextPath}/venue-details?id=<%= venue.getId() %>" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </div>
                </form>
                <% } else { %>
                <div class="error-container">
                    <h2>Venue Not Found</h2>
                    <p>The venue you are trying to update could not be found.</p>
                    <a href="${pageContext.request.contextPath}/venues" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Venues
                    </a>
                </div>
                <% } %>
            </div>
        </div>
    </div>
    
    <!-- Include footer -->
    <jsp:include page="/WEB-INF/view/footer.jsp" />
    
    <script>
        function validateForm() {
            let isValid = true;
            
            // Reset error messages
            document.querySelectorAll('.error-message').forEach(element => {
                element.textContent = '';
            });
            
            // Validate name
            const name = document.getElementById('name').value.trim();
            if (name === '') {
                document.getElementById('nameError').textContent = 'Venue name is required';
                isValid = false;
            }
            
            // Validate address
            const address = document.getElementById('address').value.trim();
            if (address === '') {
                document.getElementById('addressError').textContent = 'Address is required';
                isValid = false;
            }
            
            // Validate city
            const city = document.getElementById('city').value.trim();
            if (city === '') {
                document.getElementById('cityError').textContent = 'City is required';
                isValid = false;
            }
            
            // Validate contact number
            const contactNumber = document.getElementById('contactNumber').value.trim();
            if (contactNumber === '') {
                document.getElementById('contactNumberError').textContent = 'Contact number is required';
                isValid = false;
            }
            
            // Validate capacity
            const capacity = document.getElementById('capacity').value;
            if (capacity === '' || parseInt(capacity) < 1) {
                document.getElementById('capacityError').textContent = 'Capacity must be a positive number';
                isValid = false;
            }
            
            return isValid;
        }
    </script>
</body>
</html> 
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
