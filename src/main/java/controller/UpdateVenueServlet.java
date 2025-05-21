package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Venue;
import model.VenueDAO;

/**
 * Servlet that handles requests to update venue information
 */
@WebServlet("/update-venue")
public class UpdateVenueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get venue ID from the request parameter
        String venueIdParam = request.getParameter("id");

        // Check if venue ID is provided
        if (venueIdParam == null || venueIdParam.isEmpty()) {
            // Redirect to venues page if no ID is provided
            response.sendRedirect(request.getContextPath() + "/venues");
            return;
        }

        try {
            // Parse the venue ID
            int venueId = Integer.parseInt(venueIdParam);

            // Get venue details from the database
            VenueDAO venueDAO = new VenueDAO();
            Venue venue = venueDAO.getVenueById(venueId);

            // Check if venue exists
            if (venue == null) {
                // Redirect to venues page if venue not found
                response.sendRedirect(request.getContextPath() + "/venues");
                return;
            }

            // Set venue as request attribute
            request.setAttribute("venue", venue);

            // Forward the request to the update venue JSP page
            request.getRequestDispatcher("/WEB-INF/view/update-venue.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Redirect to venues page if ID is not a valid number
            response.sendRedirect(request.getContextPath() + "/venues");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get venue ID from the request parameter
        String venueIdParam = request.getParameter("id");

        // Process form submission
        try {
            // Parse the venue ID
            int venueId = Integer.parseInt(venueIdParam);

            // Create a venue object with the updated information
            Venue venue = new Venue();
            venue.setId(venueId);
            venue.setName(request.getParameter("name"));
            venue.setAddress(request.getParameter("address"));
            venue.setCity(request.getParameter("city"));
            venue.setContactNumber(request.getParameter("contactNumber"));

            // Parse capacity as integer
            try {
                int capacity = Integer.parseInt(request.getParameter("capacity"));
                venue.setCapacity(capacity);
            } catch (NumberFormatException e) {
                // Set default capacity if parsing fails
                venue.setCapacity(0);
            }

            // Update venue in the database
            VenueDAO venueDAO = new VenueDAO();
            boolean updateSuccess = venueDAO.updateVenue(venue);

            // Set success message
            HttpSession session = request.getSession();
            if (updateSuccess) {
                session.setAttribute("successMessage", "Venue updated successfully.");
            } else {
                session.setAttribute("errorMessage", "Failed to update venue. Please try again.");
            }

            // Redirect to venue details page
            response.sendRedirect(request.getContextPath() + "/venue-details?id=" + venueId);

        } catch (NumberFormatException e) {
            // Redirect to venues page if ID is not a valid number
            response.sendRedirect(request.getContextPath() + "/venues");
        }
    }
}