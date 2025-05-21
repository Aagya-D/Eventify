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

@WebServlet("/admin/edit-venue")
public class EditVenueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get venue ID from request
        String venueIdStr = request.getParameter("id");
        if (venueIdStr == null || venueIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/VenueDashboard");
            return;
        }
        
        try {
            int venueId = Integer.parseInt(venueIdStr);
            
            // Get venue by ID
            VenueDAO venueDAO = new VenueDAO();
            Venue venue = venueDAO.getVenueById(venueId);
            
            if (venue == null) {
                // Venue not found
                request.getSession().setAttribute("errorMessage", "Venue not found");
                response.sendRedirect(request.getContextPath() + "/VenueDashboard");
                return;
            }
            
            // Set venue for the form
            request.setAttribute("venue", venue);
            
            // Forward to the edit venue page
            request.getRequestDispatcher("/WEB-INF/view/admin/edit_venue.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid venue ID");
            response.sendRedirect(request.getContextPath() + "/VenueDashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get form parameters
        String venueIdStr = request.getParameter("id");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String contactNumber = request.getParameter("contactNumber");
        String capacityStr = request.getParameter("capacity");
        
        // Validate required fields
        if (venueIdStr == null || venueIdStr.trim().isEmpty() ||
            name == null || name.trim().isEmpty() || 
            address == null || address.trim().isEmpty() ||
            city == null || city.trim().isEmpty() ||
            contactNumber == null || contactNumber.trim().isEmpty() ||
            capacityStr == null || capacityStr.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Please fill out all required fields");
            
            // Try to get venue for form values
            try {
                int venueId = Integer.parseInt(venueIdStr);
                VenueDAO venueDAO = new VenueDAO();
                Venue venue = venueDAO.getVenueById(venueId);
                request.setAttribute("venue", venue);
                
                request.getRequestDispatcher("/WEB-INF/view/admin/edit_venue.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/VenueDashboard");
            }
            return;
        }
        
        try {
            int venueId = Integer.parseInt(venueIdStr);
            int capacity = Integer.parseInt(capacityStr);
            
            if (capacity <= 0) {
                request.setAttribute("errorMessage", "Capacity must be greater than zero");
                VenueDAO venueDAO = new VenueDAO();
                Venue venue = venueDAO.getVenueById(venueId);
                request.setAttribute("venue", venue);
                request.getRequestDispatcher("/WEB-INF/view/admin/edit_venue.jsp").forward(request, response);
                return;
            }
            
            // Get existing venue to preserve any values not in the form
            VenueDAO venueDAO = new VenueDAO();
            Venue existingVenue = venueDAO.getVenueById(venueId);
            
            if (existingVenue == null) {
                request.getSession().setAttribute("errorMessage", "Venue not found");
                response.sendRedirect(request.getContextPath() + "/VenueDashboard");
                return;
            }
            
            // Update venue with new values
            existingVenue.setName(name);
            existingVenue.setAddress(address);
            existingVenue.setCity(city);
            existingVenue.setContactNumber(contactNumber);
            existingVenue.setCapacity(capacity);
            
            // Save to database
            boolean success = venueDAO.updateVenue(existingVenue);
            
            if (success) {
                // Log activity
                ActivityLogDAO.logActivity(user.getUserId(), "UPDATE_VENUE", "Updated venue '" + name + "'");
                
                // Set success message and redirect to venues dashboard
                request.getSession().setAttribute("successMessage", "Venue updated successfully");
                response.sendRedirect(request.getContextPath() + "/VenueDashboard");
            } else {
                // Handle failure
                request.setAttribute("errorMessage", "Failed to update venue");
                request.setAttribute("venue", existingVenue);
                
                request.getRequestDispatcher("/WEB-INF/view/admin/edit_venue.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid venue ID or capacity");
            response.sendRedirect(request.getContextPath() + "/VenueDashboard");
        }
    }
} 