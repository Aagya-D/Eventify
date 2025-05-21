<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer>
    <div class="footer-content">
        <div class="footer-section">
            <h3>Eventify Admin</h3>
            <p>Manage events, venues, and users with ease.</p>
        </div>
        <div class="footer-section">
            <h3>Quick Links</h3>
            <a href="${pageContext.request.contextPath}/AdminDashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/manage-users">Manage Users</a>
            <a href="${pageContext.request.contextPath}/EventDashboard">Events</a>
            <a href="${pageContext.request.contextPath}/VenueDashboard">Venues</a>
        </div>
        <div class="footer-section">
            <h3>Admin Actions</h3>
            <a href="${pageContext.request.contextPath}/admin/profile">Admin Profile</a>
            <a href="${pageContext.request.contextPath}/resetpassword">Change Password</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
</footer> 