<%@ page import="model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    boolean isAdmin = currentUser != null && "ADMIN".equals(currentUser.getRole());
    boolean isLoggedIn = currentUser != null;
%>
<style>
    /* Professional Navbar Styles */
    header {
        background: #fff;
        box-shadow: 0 2px 8px rgba(0,97,88,0.08);
        padding: 0 20px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 56px;
        position: sticky;
        top: 0;
        z-index: 100;
    }
    .logo a {
        font-family: 'Montserrat', sans-serif;
        font-weight: 700;
        color: #006158;
        text-decoration: none;
        font-size: 28px;
        letter-spacing: -1px;
    }
    .navbar-right {
        display: flex;
        align-items: center;
        gap: 0;
        margin-left: auto;
    }
    .nav-menu {
        display: flex;
        align-items: center;
        gap: 5px;
        list-style: none;
        margin: 0;
        padding: 0;
    }
    .nav-menu li a {
        color: #006158;
        text-decoration: none;
        font-size: 14px;
        font-weight: 500;
        padding: 6px 12px;
        border-radius: 4px;
        transition: background 0.2s, color 0.2s;
        display: flex;
        align-items: center;
        gap: 4px;
    }
    .nav-menu li a i {
        font-size: 12px;
    }
    .nav-menu li a.active, .nav-menu li a:hover {
        background: #006158;
        color: #fff;
    }
    .search-bar {
        position: relative;
        width: 250px;
        margin-left: 15px;
    }
    .search-bar input {
        width: 100%;
        padding: 8px 14px 8px 35px;
        border: 1px solid #e0e0e0;
        border-radius: 25px;
        font-size: 14px;
        background: #f8f9fa;
        transition: border 0.2s, box-shadow 0.2s, background 0.2s;
    }
    .search-bar input:focus {
        outline: none;
        border-color: #006158;
        box-shadow: 0 0 0 3px rgba(0,97,88,0.10);
        background: #fff;
    }
    .search-bar i {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: #006158;
        font-size: 14px;
    }
    @media (max-width: 900px) {
        header {
            flex-direction: column;
            align-items: stretch;
            height: auto;
            padding: 0 10px;
        }
        .navbar-right {
            flex-direction: column;
            align-items: flex-end;
            gap: 10px;
            width: 100%;
        }
        .nav-menu {
            gap: 5px;
            justify-content: flex-end;
        }
        .search-bar {
            width: 100%;
            margin: 10px 0 0 0;
        }
    }
    @media (max-width: 600px) {
        header {
            flex-direction: column;
            padding: 0 2vw;
        }
        .logo a {
            font-size: 22px;
        }
        .navbar-right {
            flex-direction: column;
            align-items: flex-end;
            gap: 5px;
        }
        .nav-menu {
            flex-wrap: wrap;
            gap: 3px;
        }
        .search-bar {
            width: 100%;
        }
    }
</style>

<header>
    <div class="logo">
        <a href="${pageContext.request.contextPath}/">Eventify</a>
    </div>
    <div class="navbar-right">
        <ul class="nav-menu">
            <li><a href="${pageContext.request.contextPath}/" class="${pageContext.request.servletPath == '/index.jsp' ? 'active' : ''}">
                <i class="fas fa-home"></i> Home
            </a></li>
            <li><a href="${pageContext.request.contextPath}/events" class="${pageContext.request.servletPath.contains('events') ? 'active' : ''}">
                <i class="far fa-calendar-alt"></i> Events
            </a></li>
            <li><a href="${pageContext.request.contextPath}/venues" class="${pageContext.request.servletPath.contains('venues') ? 'active' : ''}">
                <i class="fas fa-map-marker-alt"></i> Venues
            </a></li>
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            <% if (isAdmin) { %>
            <li><a href="${pageContext.request.contextPath}/AdminDashboard" class="${pageContext.request.servletPath.contains('admin_dashboard') ? 'active' : ''}">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a></li>
            <li><a href="${pageContext.request.contextPath}/EventDashboard" class="${pageContext.request.servletPath.contains('event_dashboard') ? 'active' : ''}">
                <i class="fas fa-calendar-check"></i> Manage Events
            </a></li>
            <li><a href="${pageContext.request.contextPath}/VenueDashboard" class="${pageContext.request.servletPath.contains('venue_dashboard') ? 'active' : ''}">
                <i class="fas fa-building"></i> Manage Venues
            </a></li>
            <li><a href="${pageContext.request.contextPath}/admin/manage-users" class="${pageContext.request.servletPath.contains('manage-users') ? 'active' : ''}">
                <i class="fas fa-users-cog"></i> Manage Users
            </a></li>
            <% } %>
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            <% if (isLoggedIn) { %>
            <li><a href="${pageContext.request.contextPath}/profile" class="${pageContext.request.servletPath.contains('profile') ? 'active' : ''}">
                <i class="fas fa-user"></i> Profile
            </a></li>
            <li><a href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a></li>
            <% } else { %>
            <li><a href="${pageContext.request.contextPath}/login" class="${pageContext.request.servletPath.contains('login') ? 'active' : ''}">
                <i class="fas fa-sign-in-alt"></i> Login
            </a></li>
            <li><a href="${pageContext.request.contextPath}/register" class="${pageContext.request.servletPath.contains('register') ? 'active' : ''}">
                <i class="fas fa-user-plus"></i> Register
            </a></li>
            <% } %>
        </ul>
        <form action="${pageContext.request.contextPath}/search" method="get" class="search-bar">
            <input type="text" placeholder="Search here..." name="query">
            <i class="fas fa-search"></i>
        </form>
    </div>
</header> 