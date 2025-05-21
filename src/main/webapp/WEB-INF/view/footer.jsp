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
    background: #006158;
    color: #fff;
    padding: 48px 0 24px 0;
    box-shadow: 0 -2px 8px rgba(0,97,88,0.08);
    font-family: 'Montserrat', 'Inter', Arial, sans-serif;
    border-top-left-radius: 18px;
    border-top-right-radius: 18px;
    margin-top: 48px;
  }

  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 32px;
    padding: 0 2rem;
  }

  .footer-section {
    flex: 1 1 220px;
    min-width: 200px;
    margin: 0 1rem;
  }

  .footer-section h3 {
    font-size: 1.25rem;
    margin-bottom: 1.2rem;
    color: #fff;
    font-weight: 700;
    letter-spacing: 0.5px;
  }

  .footer-section p, .footer-section a, .footer-section span {
    color: #e1e9e8;
    text-decoration: none;
    margin-bottom: 0.7rem;
    display: block;
    font-size: 1rem;
    font-weight: 400;
    transition: color 0.2s;
  }

  .footer-section a:hover {
    color: #fff;
    text-decoration: underline;
  }

  .contact-item {
    display: flex;
    align-items: center;
    margin-bottom: 0.7rem;
    font-size: 1rem;
  }

  .contact-item i {
    margin-right: 0.7rem;
    color: #fff;
    font-size: 1.1rem;
  }

  .footer-bottom {
    text-align: center;
    color: #e1e9e8;
    font-size: 0.95rem;
    margin-top: 32px;
    padding-top: 16px;
    border-top: 1px solid rgba(255,255,255,0.08);
    letter-spacing: 0.2px;
  }

  @media (max-width: 900px) {
    .footer-content {
      flex-direction: column;
      gap: 0;
      padding: 0 1rem;
    }
    .footer-section {
      margin: 0 0 2rem 0;
    }
  }
</style>
<body>
<div class="gap-content"></div>
<footer class="footer">
  <div class="footer-content">
    <div class="footer-section">
      <h3>About Eventify</h3>
      <p>Your one-stop platform for event management and venue booking. We make organizing and attending events seamless and enjoyable.</p>
    </div>
    <div class="footer-section">
      <h3>Quick Links</h3>
      <a href="${pageContext.request.contextPath}/">Home</a>
      <a href="${pageContext.request.contextPath}/events">Events</a>
      <a href="${pageContext.request.contextPath}/venues">Venues</a>
    </div>
    <div class="footer-section">
      <h3>Contact Us</h3>
      <div class="contact-item">
        <i class="fas fa-envelope"></i>
        <span>support@eventify.com</span>
      </div>
      <div class="contact-item">
        <i class="fas fa-phone"></i>
        <span>+1 234 567 890</span>
      </div>
    </div>
  </div>
  <div class="footer-bottom">
    &copy; <%= java.time.Year.now() %> Eventify. All rights reserved.
  </div>
</footer>
</body>
</html>