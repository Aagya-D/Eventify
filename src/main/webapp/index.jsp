<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Check if user is logged in
    boolean isLoggedIn = false;
    if (session.getAttribute("user") != null) {
        isLoggedIn = true;

        // If the user is an admin, redirect to admin dashboard
        User user = (User) session.getAttribute("user");
        if ("ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/AdminDashboard");
            return;
        }
    }

    // Get the first letter of the user's name for the avatar
    String firstLetter = "";
    if (isLoggedIn) {
        User user = (User) session.getAttribute("user");
        if (user.getFullName() != null && !user.getFullName().isEmpty()) {
            firstLetter = user.getFullName().substring(0, 1).toUpperCase();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventify - Your Event Management Solution</title>
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
            transition: all 0.3s ease;
        }

        header.scrolled {
            padding: 10px 5%;
            background-color: rgba(255, 253, 245, 0.98);
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }

        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 600;
            color: #006158;
            transition: transform 0.3s ease;
        }

        .logo:hover {
            transform: scale(1.05);
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

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 30px;
            border: none;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-light {
            background-color: #e1e9e8;
            color: #006158;
        }

        .btn-primary {
            background-color: #006158;
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        /* Hero section */
        .hero {
            display: flex;
            height: 500px;
            background-color: #006158;
        }

        .hero-content {
            flex: 1;
            padding: 60px 5%;
            color: white;
        }

        .hero-content h1 {
            font-size: 36px;
            margin-bottom: 20px;
            font-family: 'Playfair Display', serif;
            font-weight: 600;
        }

        .hero-content p {
            font-size: 16px;
            margin-bottom: 30px;
            max-width: 500px;
        }

        .hero-buttons {
            display: flex;
            gap: 15px;
        }

        .btn-white {
            background-color: white;
            color: #006158;
        }

        .btn-outline {
            background-color: transparent;
            color: white;
            border: 1px solid white;
        }

        .hero-image {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #e0e0e0;
        }

        .hero-image img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }

        /* Services section */
        .services {
            padding: 60px 5%;
            text-align: center;
        }

        .services h2 {
            font-size: 32px;
            margin-bottom: 40px;
            font-family: 'Playfair Display', serif;
            font-weight: 600;
        }

        .service-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .service-card {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            background-color: white;
        }

        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .service-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .service-card-content {
            padding: 15px;
            text-align: left;
        }

        .service-card h3 {
            font-size: 18px;
            margin-bottom: 5px;
            color: #006158;
        }

        .service-card p {
            font-size: 14px;
            color: #666;
        }

        /* Features section */
        .features {
            padding: 60px 5%;
            text-align: center;
            background-color: #fffdf5;
        }

        .features h2 {
            font-size: 32px;
            margin-bottom: 40px;
            font-family: 'Playfair Display', serif;
            font-weight: 600;
        }

        .feature-cards {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 30px;
        }

        .feature-card {
            flex: 1;
            min-width: 250px;
            max-width: 350px;
            padding: 30px;
            text-align: center;
        }

        .feature-icon {
            font-size: 36px;
            margin-bottom: 20px;
            color: #006158;
        }

        .feature-card h3 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #006158;
        }

        /* Statistics Section */
        .statistics {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-top: 60px;
            background-color: #006158;
            border-radius: 15px;
            padding: 40px 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .stat-item {
            text-align: center;
            padding: 20px;
            flex: 1;
            min-width: 150px;
        }

        .stat-number {
            font-size: 42px;
            font-weight: 700;
            margin-bottom: 10px;
            color: white;
            font-family: 'Playfair Display', serif;
        }

        .stat-label {
            font-size: 16px;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
        }

        /* Conference section */
        .conference {
            height: 400px;
            background-color: #333;
            position: relative;
            overflow: hidden;
        }

        .conference img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.8;
        }

        /* Testimonials Section */
        .testimonials {
            padding: 80px 5%;
            text-align: center;
            background-color: #f5f5f5;
        }

        .testimonials h2 {
            font-size: 32px;
            margin-bottom: 50px;
            font-family: 'Playfair Display', serif;
            font-weight: 600;
            color: #006158;
        }

        .testimonial-slider {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
        }

        .testimonial-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            padding: 30px;
            max-width: 350px;
            text-align: left;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .testimonial-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .testimonial-content {
            margin-bottom: 20px;
        }

        .testimonial-content p {
            font-style: italic;
            color: #555;
            line-height: 1.6;
            font-size: 16px;
            position: relative;
        }

        .testimonial-content p::before {
            content: '"';
            font-size: 60px;
            color: #006158;
            opacity: 0.2;
            position: absolute;
            top: -20px;
            left: -15px;
            font-family: Georgia, serif;
        }

        .testimonial-author {
            display: flex;
            align-items: center;
        }

        .author-image {
            margin-right: 15px;
            font-size: 40px;
            color: #006158;
        }

        .author-info h4 {
            margin: 0;
            font-size: 18px;
            color: #006158;
        }

        .author-info p {
            margin: 0;
            font-size: 14px;
            color: #777;
        }

        /* Call to Action Section */
        .cta-section {
            background: linear-gradient(to right, #006158, #009688);
            color: white;
            padding: 80px 5%;
            text-align: center;
            margin: 60px 0 0;
        }

        .cta-content {
            max-width: 800px;
            margin: 0 auto;
        }

        .cta-content h2 {
            font-size: 32px;
            margin-bottom: 20px;
            font-family: 'Playfair Display', serif;
            font-weight: 600;
        }

        .cta-content p {
            font-size: 18px;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .cta-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .btn-outline-dark {
            background-color: transparent;
            color: white;
            border: 2px solid white;
        }

        .btn-outline-dark:hover {
            background-color: white;
            color: #006158;
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

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .hero {
                flex-direction: column;
                height: auto;
            }

            .hero-content, .hero-image {
                padding: 40px 5%;
            }

            .service-cards {
                grid-template-columns: 1fr;
            }

            .footer-columns {
                flex-direction: column;
            }

            .footer-column {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<%--<!-- Include the common navbar -->--%>
<jsp:include page="/WEB-INF/view/navbar.jsp" />
<!-- Header with navigation -->
<%--    <header>--%>
<%--        <div class="logo">--%>
<%--            <a href="${pageContext.request.contextPath}/">Eventify</a>--%>
<%--        </div>--%>

<%--        <ul class="nav-menu">--%>
<%--            <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/events"><i class="fas fa-calendar-alt"></i> Events</a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/venues"><i class="fas fa-map-marker-alt"></i> Venues</a></li>--%>
<%--            <% if (isLoggedIn) { %>--%>
<%--&lt;%&ndash;            <li><a href="${pageContext.request.contextPath}/admin"><i class="fas fa-user-cog"></i> Admin</a></li>&ndash;%&gt;--%>
<%--            <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>--%>
<%--            <% } else { %>--%>
<%--            <li><a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i> Sign In</a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/register"><i class="fas fa-user-plus"></i> Register</a></li>--%>
<%--            <% } %>--%>
<%--        </ul>--%>

<%--        <div class="action-buttons">--%>
<%--            <a href="#features" class="btn btn-light">How it works</a>--%>
<%--            <a href="${pageContext.request.contextPath}/RegisterServlet" class="btn btn-primary">Get Started</a>--%>
<%--        </div>--%>
<%--    </header>--%>

<!-- Hero section -->
<section class="hero">
    <div class="hero-content">
        <h1>Create Unforgettable Events</h1>
        <p>Transform your events into extraordinary experiences with Deep Events. Professional Planning, seamless execution.</p>
        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/RegisterServlet" class="btn btn-white">Get Started</a>
            <a href="#features" class="btn btn-outline">Learn More</a>
        </div>
    </div>

    <div class="hero-image">
        <img src="${pageContext.request.contextPath}/assets/images/image 1.png" alt="Floating temple on an island">
    </div>
</section>

<!-- Services section -->
<section class="services">
    <h2>Our Services:</h2>

    <div class="service-cards">
        <!-- Wedding -->
        <div class="service-card">
            <img src="${pageContext.request.contextPath}/assets/images/ceremony.png" alt="Wedding ceremony">
            <div class="service-card-content">
                <h3>Wedding</h3>
                <p>From intimate gatherings to grand celebrations, we specialize in creating dream wedding experiences.</p>
            </div>
        </div>

        <!-- Rice Pudding -->
        <div class="service-card">
            <img src="${pageContext.request.contextPath}/assets/images/ceremony1.png" alt="Rice Pudding">
            <div class="service-card-content">
                <h3>Rice Pudding</h3>
                <p>Celebrating a baby's first solid food with a beautiful and meaningful cultural ceremony.</p>
            </div>
        </div>

        <!-- Baby Shower -->
        <div class="service-card">
            <img src="${pageContext.request.contextPath}/assets/images/ceremony2.png" alt="Baby shower decoration">
            <div class="service-card-content">
                <h3>Baby Shower</h3>
                <p>A joyful celebration to welcome a little bundle of joy. We host creative and gorgeous baby showers.</p>
            </div>
        </div>

        <!-- Graduation Party -->
        <div class="service-card">
            <img src="${pageContext.request.contextPath}/assets/images/ceremony3.png" alt="Graduation celebration">
            <div class="service-card-content">
                <h3>Graduation Party</h3>
                <p>Celebrate academic milestones with a memorable party for graduates, friends, and family.</p>
            </div>
        </div>

        <!-- Project Launching -->
        <div class="service-card">
            <img src="${pageContext.request.contextPath}/assets/images/ceremony4.png" alt="Project launch event">
            <div class="service-card-content">
                <h3>Project Launching</h3>
                <p>Introduce your new project with a well-executed launch event that leaves positive impressions.</p>
            </div>
        </div>

        <!-- Christmas Party -->
        <div class="service-card">
            <img src="${pageContext.request.contextPath}/assets/images/ceremony5.png" alt="Christmas celebration">
            <div class="service-card-content">
                <h3>Christmas Party</h3>
                <p>Celebrate the festive season with warmth, joy, and a touch of holiday magic.</p>
            </div>
        </div>

        <!-- Press Conferences -->
        <div class="service-card">
            <img src="${pageContext.request.contextPath}/assets/images/ceremony6.png" alt="Press conference setup">
            <div class="service-card-content">
                <h3>Press Conferences</h3>
                <p>Celebrate academic milestones with a memorable event for journalists, friends, and family.</p>
            </div>
        </div>

        <!-- Product Launches -->
        <div class="service-card">
            <img src="${pageContext.request.contextPath}/assets/images/ceremony7.png" alt="Product launch event">
            <div class="service-card-content">
                <h3>Product Launches</h3>
                <p>Make your product stand out with a creative and impactful unveiling event.</p>
            </div>
        </div>

        <!-- Beauty Pageant -->
        <div class="service-card">
            <img src="${pageContext.request.contextPath}/assets/images/ceremony8.png" alt="Beauty pageant winners">
            <div class="service-card-content">
                <h3>Beauty Pageant</h3>
                <p>A grand celebration of grace, confidence, and outstanding beauty with meaningful events.</p>
            </div>
        </div>
    </div>
</section>

<!-- Features section -->
<section class="features" id="features">
    <h2>Why to choose Eventify?</h2>

    <div class="feature-cards">
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-calendar-check"></i>
            </div>
            <h3>Easy Booking</h3>
            <p>Simple, fast process to book your events without complications.</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-users"></i>
            </div>
            <h3>Professional Team</h3>
            <p>Expert planners and coordinators dedicated to your event's success.</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <h3>Real-Time Analysis</h3>
            <p>Track your event metrics and performance in real-time.</p>
        </div>
    </div>

    <!-- Statistics Section -->
    <div class="statistics">
        <div class="stat-item">
            <div class="stat-number">500+</div>
            <div class="stat-label">Events Organized</div>
        </div>

        <div class="stat-item">
            <div class="stat-number">50+</div>
            <div class="stat-label">Corporate Partners</div>
        </div>

        <div class="stat-item">
            <div class="stat-number">98%</div>
            <div class="stat-label">Client Satisfaction</div>
        </div>

        <div class="stat-item">
            <div class="stat-number">25+</div>
            <div class="stat-label">Awards Won</div>
        </div>
    </div>
</section>

<!-- Conference image section -->
<section class="conference">
    <img src="${pageContext.request.contextPath}/assets/images/last.png" alt="Large conference hall">
</section>

<!-- Testimonials Section -->
<section class="testimonials">
    <h2>What Our Clients Say</h2>
    <div class="testimonial-slider">
        <div class="testimonial-card">
            <div class="testimonial-content">
                <p>"Eventify transformed our corporate event into an unforgettable experience. Their attention to detail and professionalism exceeded our expectations."</p>
            </div>
            <div class="testimonial-author">
                <div class="author-image">
                    <i class="fas fa-user-circle"></i>
                </div>
                <div class="author-info">
                    <h4>Sarah Johnson</h4>
                    <p>Marketing Director, TechCorp</p>
                </div>
            </div>
        </div>

        <div class="testimonial-card">
            <div class="testimonial-content">
                <p>"Planning our wedding with Eventify was the best decision we made. They handled everything flawlessly, allowing us to enjoy our special day without stress."</p>
            </div>
            <div class="testimonial-author">
                <div class="author-image">
                    <i class="fas fa-user-circle"></i>
                </div>
                <div class="author-info">
                    <h4>Michael & Emily Collins</h4>
                    <p>Wedding Clients</p>
                </div>
            </div>
        </div>

        <div class="testimonial-card">
            <div class="testimonial-content">
                <p>"The product launch event organized by Eventify generated incredible buzz for our new line. The team's creativity and execution were impeccable."</p>
            </div>
            <div class="testimonial-author">
                <div class="author-image">
                    <i class="fas fa-user-circle"></i>
                </div>
                <div class="author-info">
                    <h4>David Chen</h4>
                    <p>CEO, Innovate Design</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action Section -->
<section class="cta-section">
    <div class="cta-content">
        <h2>Ready to Create Your Memorable Event?</h2>
        <p>Let's start planning your next extraordinary experience together.</p>
        <div class="cta-buttons">
            <a href="${pageContext.request.contextPath}/RegisterServlet" class="btn btn-primary">Get Started Today</a>
            <a href="#" class="btn btn-outline-dark">Contact Us</a>
        </div>
    </div>
</section>

<!-- Footer -->
<jsp:include page="/WEB-INF/view/footer.jsp" />

<script>
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();

            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);

            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop,
                    behavior: 'smooth'
                });
            }
        });
    });

    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // Simple animation for statistics
    const statNumbers = document.querySelectorAll('.stat-number');

    function animateStats() {
        statNumbers.forEach(stat => {
            const target = parseInt(stat.textContent);
            let current = 0;
            const increment = target / 30; // Adjust for animation speed

            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    stat.textContent = target + (stat.textContent.includes('%') ? '%' : '+');
                    clearInterval(timer);
                } else {
                    stat.textContent = Math.floor(current) + (stat.textContent.includes('%') ? '%' : '+');
                }
            }, 30);
        });
    }

    // Use Intersection Observer to trigger animation when stats are visible
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                animateStats();
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    const statsSection = document.querySelector('.statistics');
    if (statsSection) {
        observer.observe(statsSection);
    }
</script>
</body>
</html>
