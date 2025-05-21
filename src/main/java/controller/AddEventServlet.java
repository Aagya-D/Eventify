package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Event;
import model.EventDAO;
import model.User;
import model.VenueDAO;
import model.Venue;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class AddEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get venues for dropdown
        VenueDAO venueDAO = new VenueDAO();
        List<Venue> venues = venueDAO.getAllVenues();
        request.setAttribute("venues", venues);
        
        // Forward to the add event form
        request.getRequestDispatcher("/WEB-INF/view/add-event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String name = request.getParameter("name");
        String dateTimeStr = request.getParameter("dateTime");
        String venueIdStr = request.getParameter("venue");
        String description = request.getParameter("description");
        String manager = request.getParameter("manager");
        
        // Get venues for dropdown (in case we need to return to the form)
        VenueDAO venueDAO = new VenueDAO();
        List<Venue> venues = venueDAO.getAllVenues();
        request.setAttribute("venues", venues);
        
        // Validate required fields
        if (name == null || name.trim().isEmpty() || 
            dateTimeStr == null || dateTimeStr.trim().isEmpty() ||
            venueIdStr == null || venueIdStr.trim().isEmpty() ||
            description == null || description.trim().isEmpty() ||
            manager == null || manager.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/view/add-event.jsp").forward(request, response);
            return;
        }
        
        try {
            // Parse date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date dateTime = dateFormat.parse(dateTimeStr);
            
            // Get venue by ID
            int venueId = Integer.parseInt(venueIdStr);
            Venue venue = venueDAO.getVenueById(venueId);
            
            if (venue == null) {
                request.setAttribute("error", "Invalid venue selected");
                request.getRequestDispatcher("/WEB-INF/view/add-event.jsp").forward(request, response);
                return;
            }
            
            // Calculate days until event
            long diffInMillies = dateTime.getTime() - new Date().getTime();
            int daysUntilEvent = (int) (diffInMillies / (1000 * 60 * 60 * 24));
            
            // Create new event
            Event event = new Event();
            event.setName(name);
            event.setDateTime(dateTime);
            event.setDaysUntilEvent(daysUntilEvent);
            event.setVenue(venue.getName()); // Store the venue name in the event
            event.setDescription(description);
            event.setManager(manager);
            event.setApproved(false); // Default to not approved
            event.setAttendees(0); // Default to 0 attendees
            
            // Save to database
            EventDAO eventDAO = new EventDAO();
            boolean success = eventDAO.addEvent(event);
            
            if (success) {
                // Redirect to events page with success message
                response.sendRedirect(request.getContextPath() + "/events");
            } else {
                request.setAttribute("error", "Failed to create event. Please try again.");
                request.getRequestDispatcher("/WEB-INF/view/add-event.jsp").forward(request, response);
            }
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format");
            request.getRequestDispatcher("/WEB-INF/view/add-event.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid venue ID");
            request.getRequestDispatcher("/WEB-INF/view/add-event.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/add-event.jsp").forward(request, response);
        }
    }
} 