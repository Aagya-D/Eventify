package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Event;
import model.EventDAO;
import model.User;
import model.VenueDAO;
import model.Venue;
import model.ActivityLogDAO;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/add-event")
public class AddEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get venues for dropdown
        VenueDAO venueDAO = new VenueDAO();
        List<Venue> venues = venueDAO.getAllVenues();
        request.setAttribute("venues", venues);
        
        // Forward to the add event form
        request.getRequestDispatcher("/WEB-INF/view/admin/add_event.jsp").forward(request, response);
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
        String dateStr = request.getParameter("date");
        String venue = request.getParameter("venue");
        String description = request.getParameter("description");
        String manager = request.getParameter("manager");
        boolean approved = request.getParameter("approved") != null;
        
        // Validate required fields
        if (name == null || name.trim().isEmpty() || 
            dateStr == null || dateStr.trim().isEmpty() ||
            venue == null || venue.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Please fill out all required fields");
            
            // Get venues for dropdown
            VenueDAO venueDAO = new VenueDAO();
            List<Venue> venues = venueDAO.getAllVenues();
            request.setAttribute("venues", venues);
            
            request.getRequestDispatcher("/WEB-INF/view/admin/add_event.jsp").forward(request, response);
            return;
        }
        
        try {
            // Parse date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date eventDate = dateFormat.parse(dateStr);
            
            // Create new event
            Event event = new Event();
            event.setName(name);
            event.setDateTime(eventDate);
            event.setVenue(venue);
            event.setDescription(description);
            event.setManager(manager);
            event.setApproved(approved);
            event.setAttendees(0); // Default for new event
            
            // Save to database
            EventDAO eventDAO = new EventDAO();
            boolean success = eventDAO.addEvent(event);
            
            if (success) {
                // Log activity
                ActivityLogDAO.logActivity(user.getUserId(), "ADD_EVENT", "Added event '" + name + "'");
                
                // Set success message and redirect to events dashboard
                request.getSession().setAttribute("successMessage", "Event added successfully");
                response.sendRedirect(request.getContextPath() + "/EventDashboard");
            } else {
                // Handle failure
                request.setAttribute("errorMessage", "Failed to add event");
                
                // Get venues for dropdown
                VenueDAO venueDAO = new VenueDAO();
                List<Venue> venues = venueDAO.getAllVenues();
                request.setAttribute("venues", venues);
                
                request.getRequestDispatcher("/WEB-INF/view/admin/add_event.jsp").forward(request, response);
            }
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid date format");
            
            // Get venues for dropdown
            VenueDAO venueDAO = new VenueDAO();
            List<Venue> venues = venueDAO.getAllVenues();
            request.setAttribute("venues", venues);
            
            request.getRequestDispatcher("/WEB-INF/view/admin/add_event.jsp").forward(request, response);
        }
    }
}