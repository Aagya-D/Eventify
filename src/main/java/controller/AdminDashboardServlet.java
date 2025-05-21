package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.User;
import model.UserDAO;
import model.EventDAO;
import model.VenueDAO;
import model.Event;
import model.Venue;
import model.ActivityLog;
import model.ActivityLogDAO;
import java.util.List;

/**
 * Servlet that handles requests to the Admin Dashboard page
 */
@WebServlet("/AdminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            // Redirect to login page if not logged in
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if user has admin role
        if (!"ADMIN".equals(user.getRole())) {
            // Redirect to home page if not an admin
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // Get counts for dashboard
        EventDAO eventDAO = new EventDAO();
        VenueDAO venueDAO = new VenueDAO();

        // Get actual counts from database
        int eventCount = eventDAO.getEventCount();
        int venueCount = venueDAO.getAllVenues().size();
        int userCount = UserDAO.getUserCount();
        int approvedEventCount = eventDAO.getApprovedEventCount();

        // Set counts as request attributes
        request.setAttribute("eventCount", eventCount);
        request.setAttribute("venueCount", venueCount);
        request.setAttribute("userCount", userCount);
        request.setAttribute("approvedEventCount", approvedEventCount);

        // Get recent events for activity feed (limit to 5)
        List<Event> recentEvents = eventDAO.getRecentEvents(5);
        request.setAttribute("recentEvents", recentEvents);

        // Get recent users (limit to 5)
        List<User> recentUsers = UserDAO.getAllUsers();
        if (recentUsers.size() > 5) {
            recentUsers = recentUsers.subList(0, 5);
        }
        request.setAttribute("recentUsers", recentUsers);

        // Get recent activity logs (limit to 5)
        List<ActivityLog> recentActivities = ActivityLogDAO.getRecentActivities(5);
        request.setAttribute("recentActivities", recentActivities);

        // Forward the request to the admin dashboard JSP page
        request.getRequestDispatcher("/WEB-INF/view/admin_dashboard.jsp").forward(request, response);
    }
}
