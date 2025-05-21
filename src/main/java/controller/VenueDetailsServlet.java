package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Venue;
import model.VenueDAO;

/**
 * Servlet that handles requests to display venue details
 */
@WebServlet("/venue-details")
public class VenueDetailsServlet extends HttpServlet {

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
            
            // Forward the request to the venue details JSP page
            request.getRequestDispatcher("/WEB-INF/view/venue-details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            // Redirect to venues page if ID is not a valid number
            response.sendRedirect(request.getContextPath() + "/venues");
        }
    }
} 