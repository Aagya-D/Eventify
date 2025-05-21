package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.Venue;
import model.VenueDAO;
import model.ActivityLogDAO;

import java.io.IOException;

@WebServlet("/admin/add-venue")
public class AdminAddVenueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Forward to the admin add venue form
        request.getRequestDispatcher("/WEB-INF/view/admin/add_venue.jsp").forward(request, response);
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
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String contactNumber = request.getParameter("contactNumber");
        String capacityStr = request.getParameter("capacity");
        
        // Validate required fields
        if (name == null || name.trim().isEmpty() || 
            address == null || address.trim().isEmpty() ||
            city == null || city.trim().isEmpty() ||
            contactNumber == null || contactNumber.trim().isEmpty() ||
            capacityStr == null || capacityStr.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/view/admin/add_venue.jsp").forward(request, response);
            return;
        }
        
        try {
            // Parse capacity
            int capacity = Integer.parseInt(capacityStr);
            
            if (capacity <= 0) {
                request.setAttribute("errorMessage", "Capacity must be greater than zero");
                request.getRequestDispatcher("/WEB-INF/view/admin/add_venue.jsp").forward(request, response);
                return;
            }
            
            // Create new venue object
            Venue venue = new Venue();
            venue.setName(name);
            venue.setAddress(address);
            venue.setCity(city);
            venue.setContactNumber(contactNumber);
            venue.setCapacity(capacity);
            
            // Save to database
            VenueDAO venueDAO = new VenueDAO();
            boolean success = venueDAO.addVenue(venue);
            
            if (success) {
                // Log activity
                ActivityLogDAO.logActivity(user.getUserId(), "ADD_VENUE", "Added venue '" + name + "'");
                
                // Set success message and redirect to venues dashboard
                request.getSession().setAttribute("successMessage", "Venue '" + name + "' has been created successfully with capacity of " + capacity + "!");
                response.sendRedirect(request.getContextPath() + "/VenueDashboard");
            } else {
                request.setAttribute("errorMessage", "Failed to add venue. Please check database connection.");
                request.getRequestDispatcher("/WEB-INF/view/admin/add_venue.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Capacity must be a valid number");
            request.getRequestDispatcher("/WEB-INF/view/admin/add_venue.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/admin/add_venue.jsp").forward(request, response);
        }
    }
} 