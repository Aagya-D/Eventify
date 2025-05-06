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
public class AddVenueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Forward to the add venue form
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
        
        // Check database connection first
        if (!isDatabaseAvailable()) {
            request.setAttribute("errorMessage", "Database connection failed. Please ensure MySQL is running on port 3306.");
            request.getRequestDispatcher("/WEB-INF/view/admin/add_venue.jsp").forward(request, response);
            return;
        }
        
        // Get form parameters
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String zipCode = request.getParameter("zipCode");
        String phone = request.getParameter("phone");
        String web = request.getParameter("web");
        String email = request.getParameter("email");
        
        // Validate required fields
        if (name == null || name.trim().isEmpty() || 
            address == null || address.trim().isEmpty() ||
            zipCode == null || zipCode.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Please fill out all required fields");
            request.getRequestDispatcher("/WEB-INF/view/admin/add_venue.jsp").forward(request, response);
            return;
        }
        
        // Create new venue
        Venue venue = new Venue();
        venue.setName(name);
        venue.setAddress(address);
        venue.setZipCode(zipCode);
        venue.setPhone(phone);
        venue.setWeb(web != null ? web : "");
        venue.setEmailAddress(email);
        
        System.out.println("Attempting to add venue: " + name);
        
        // Save to database
        VenueDAO venueDAO = new VenueDAO();
        boolean success = venueDAO.addVenue(venue);
        
        System.out.println("Add venue result: " + (success ? "Success" : "Failed"));
        
        if (success) {
            // Log activity
            ActivityLogDAO.logActivity(user.getUserId(), "ADD_VENUE", "Added venue '" + name + "'");
            
            // Add debug output
            System.out.println("Venue added successfully. Redirecting to: " + request.getContextPath() + "/VenueDashboard");
            
            // Set success message and redirect to venues dashboard
            request.getSession().setAttribute("successMessage", "Venue added successfully");
            
            // Try absolute URL instead of relative
            String redirectURL = request.getContextPath() + "/VenueDashboard";
            response.sendRedirect(redirectURL);
        } else {
            // Handle failure
            request.setAttribute("errorMessage", "Failed to add venue. Please check database connection.");
            request.getRequestDispatcher("/WEB-INF/view/admin/add_venue.jsp").forward(request, response);
        }
    }
    
    private boolean isDatabaseAvailable() {
        try {
            VenueDAO venueDAO = new VenueDAO();
            // Just try to get venues to test connection
            venueDAO.getAllVenues();
            return true;
        } catch (Exception e) {
            System.err.println("Database availability check failed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
