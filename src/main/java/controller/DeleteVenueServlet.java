package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Venue;
import model.VenueDAO;
import model.User;
import model.ActivityLogDAO;

import java.io.IOException;

@WebServlet("/admin/delete-venue")
public class DeleteVenueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Delete operations should be performed via POST
        response.sendRedirect(request.getContextPath() + "/VenueDashboard");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // Get venue ID from request
        String venueIdStr = request.getParameter("id");
        if (venueIdStr == null || venueIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "No venue ID provided");
            response.sendRedirect(request.getContextPath() + "/VenueDashboard");
            return;
        }
<<<<<<< HEAD

        try {
            int venueId = Integer.parseInt(venueIdStr);

            // Get venue by ID first to get its name for the log
            VenueDAO venueDAO = new VenueDAO();
            Venue venue = venueDAO.getVenueById(venueId);

=======
        
        try {
            int venueId = Integer.parseInt(venueIdStr);
            
            // Get venue by ID first to get its name for the log
            VenueDAO venueDAO = new VenueDAO();
            Venue venue = venueDAO.getVenueById(venueId);
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            if (venue == null) {
                request.getSession().setAttribute("errorMessage", "Venue not found");
                response.sendRedirect(request.getContextPath() + "/VenueDashboard");
                return;
            }
<<<<<<< HEAD

            // Delete the venue
            boolean success = venueDAO.deleteVenue(venueId);

            if (success) {
                // Log activity
                ActivityLogDAO.logActivity(user.getUserId(), "DELETE_VENUE", "Deleted venue '" + venue.getName() + "'");

=======
            
            // Delete the venue
            boolean success = venueDAO.deleteVenue(venueId);
            
            if (success) {
                // Log activity
                ActivityLogDAO.logActivity(user.getUserId(), "DELETE_VENUE", "Deleted venue '" + venue.getName() + "'");
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                request.getSession().setAttribute("successMessage", "Venue deleted successfully");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to delete venue. Please ensure there are no active events at this venue.");
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid venue ID");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // Redirect back to venues dashboard
        response.sendRedirect(request.getContextPath() + "/VenueDashboard");
    }
} 