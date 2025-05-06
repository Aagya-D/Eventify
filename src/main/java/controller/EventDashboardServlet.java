package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.User;
import model.EventDAO;
import model.Event;
import model.ActivityLogDAO;
import java.util.List;

/**
 * Servlet that handles requests to the Admin Event Dashboard page
 */
@WebServlet("/EventDashboard")
public class EventDashboardServlet extends HttpServlet {

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

        // Get all events for dashboard from the database
        EventDAO eventDAO = new EventDAO();
        List<Event> allEvents = eventDAO.getAllEvents();

        // Set events as request attribute
        request.setAttribute("events", allEvents);
        
        // Log admin activity
        ActivityLogDAO.logActivity(user.getUserId(), "VIEW", "Viewed event dashboard");

        // Forward the request to the event dashboard JSP page
        request.getRequestDispatcher("/WEB-INF/view/event_dashboard.jsp").forward(request, response);
    }
}
