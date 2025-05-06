<%@ page import="model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    boolean isAdmin = currentUser != null && "ADMIN".equals(currentUser.getRole());
    boolean isLoggedIn = currentUser != null;
%>
<header>
    <div class="logo">
        <a href="${pageContext.request.contextPath}/">Eventify</a>
    </div>

    <ul class="nav-menu">
        <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>
        <li><a href="${pageContext.request.contextPath}/events"><i class="far fa-calendar-alt"></i> Events</a></li>
        <li><a href="${pageContext.request.contextPath}/venues"><i class="fas fa-map-marker-alt"></i> Venues</a></li>
        
        <% if (isAdmin) { %>
        <li><a href="${pageContext.request.contextPath}/AdminDashboard"><i class="fas fa-tachometer-alt"></i> Admin Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/EventDashboard"><i class="fas fa-calendar-check"></i> Manage Events</a></li>
        <li><a href="${pageContext.request.contextPath}/VenueDashboard"><i class="fas fa-building"></i> Manage Venues</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/manage-users"><i class="fas fa-users-cog"></i> Manage Users</a></li>
        <% } %>
        
<%--        <% if (isLoggedIn && !isAdmin) { %>--%>
<%--        <li><a href="${pageContext.request.contextPath}/add-event"><i class="fas fa-plus-circle"></i> Add Event</a></li>--%>
<%--        <% } %>--%>
        
        <% if (isLoggedIn) { %>
        <li><a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i> Profile</a></li>
        <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        <% } else { %>
        <li><a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i> Login</a></li>
        <li><a href="${pageContext.request.contextPath}/register"><i class="fas fa-user-plus"></i> Register</a></li>
        <% } %>
    </ul>

    <div class="search-bar">
        <input type="text" placeholder="Search here...">
        <i class="fas fa-search"></i>
    </div>
</header> 