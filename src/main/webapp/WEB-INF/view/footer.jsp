<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Footer</title>
</head>
<style>
  .gap-content {
    width: 100%;
    height: 100px;
    background-color: #FDF8F3;
  }
  /* Footer Styles */
  .footer {
    background-color: #006B54;
    color: white;
    padding: 3rem 0;
    height:190px;

  }

  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    padding: 0 2rem;
  }

  .footer-section {
    flex: 1;
    margin: 0 1rem;
  }

  .footer-section h3 {
    font-size: 1.2rem;
    margin-bottom: 1rem;
    color: white;
  }

  .footer-section p, .footer-section a {
    color: white;
    text-decoration: none;
    margin-bottom: 0.5rem;
    display: block;
  }

  .footer-section a:hover {
    text-decoration: underline;
  }

  .contact-info {
    display: flex;
    align-items: center;
    margin-bottom: 0.5rem;
  }

  .contact-info i {
    margin-right: 0.5rem;
  }

</style>
<body>
<div class="gap-content"></div>
<footer class="footer">
  <div class="footer-content">
    <div class="footer-section">
      <h3>Eventify</h3>
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
      <div class="contact-info">
        <i class="fas fa-envelope"></i>
        <a href="mailto:supporteventify@gmail.com">supporteventify@gmail.com</a>
      </div>
      <div class="contact-info">
        <i class="fas fa-phone"></i>
        <p>9826321921</p>
      </div>
    </div>
  </div>
</footer>
</body>
</html>