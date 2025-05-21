package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.User;
import model.VenueDAO;
import model.Venue;
import model.ActivityLogDAO;
import java.util.List;

/**
 * Servlet that handles requests to the Admin Venue Dashboard page
 */
@WebServlet("/VenueDashboard")
public class VenueDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("VenueDashboardServlet doGet method called");

        // Check if user is logged in
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            // Redirect to login page if not logged in
            System.out.println("User not logged in, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if user has admin role
        if (!"ADMIN".equals(user.getRole())) {
            // Redirect to home page if not an admin
            System.out.println("User not an admin, redirecting to home page");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // Get search query parameter
        String searchQuery = request.getParameter("q");

        // Get venues from database based on search query
        System.out.println("Fetching venues from database");
        VenueDAO venueDAO = new VenueDAO();
        List<Venue> allVenues;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            // If search query exists, use search functionality
            System.out.println("Searching venues with query: " + searchQuery);
            allVenues = venueDAO.searchVenues(searchQuery);
            // Save search query for form
            request.setAttribute("searchQuery", searchQuery);
        } else {
            // Otherwise get all venues
            allVenues = venueDAO.getAllVenues();
        }

        System.out.println("Fetched " + allVenues.size() + " venues");

        // Set venues as request attribute
        request.setAttribute("venues", allVenues);

        // Check for success message in session
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        if (successMessage != null) {
            System.out.println("Success message found: " + successMessage);
            request.setAttribute("successMessage", successMessage);
            // Remove from session to prevent it from displaying on refresh
            request.getSession().removeAttribute("successMessage");
        }

        // Log admin activity
        ActivityLogDAO.logActivity(user.getUserId(), "VIEW", "Viewed venue dashboard");

        // Forward the request to the venue dashboard JSP page
        System.out.println("Forwarding to venue_dashboard.jsp");
        request.getRequestDispatcher("/WEB-INF/view/venue_dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle post requests the same way as get
        doGet(request, response);
    }
}
