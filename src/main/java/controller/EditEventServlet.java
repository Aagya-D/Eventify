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

@WebServlet("/admin/edit-event")
public class EditEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get event ID from request
        String eventIdStr = request.getParameter("id");
        if (eventIdStr == null || eventIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/EventDashboard");
            return;
        }

        try {
            int eventId = Integer.parseInt(eventIdStr);

            // Get event by ID
            EventDAO eventDAO = new EventDAO();
            Event event = eventDAO.getEventById(eventId);

            if (event == null) {
                // Event not found
                request.getSession().setAttribute("errorMessage", "Event not found");
                response.sendRedirect(request.getContextPath() + "/EventDashboard");
                return;
            }

            // Get venues for dropdown
            VenueDAO venueDAO = new VenueDAO();
            List<Venue> venues = venueDAO.getAllVenues();

            // Set attributes for the form
            request.setAttribute("event", event);
            request.setAttribute("venues", venues);

            // Format date for the form
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            String formattedDate = dateFormat.format(event.getDateTime());
            request.setAttribute("formattedDate", formattedDate);

            // Forward to the edit event page
            request.getRequestDispatcher("/WEB-INF/view/admin/edit_event.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid event ID");
            response.sendRedirect(request.getContextPath() + "/EventDashboard");
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
        String eventIdStr = request.getParameter("id");
        String name = request.getParameter("name");
        String dateStr = request.getParameter("date");
        String venue = request.getParameter("venue");
        String description = request.getParameter("description");
        String manager = request.getParameter("manager");
        boolean approved = request.getParameter("approved") != null;
        String attendeesStr = request.getParameter("attendees");

        // Validate required fields
        if (eventIdStr == null || eventIdStr.trim().isEmpty() ||
                name == null || name.trim().isEmpty() ||
                dateStr == null || dateStr.trim().isEmpty() ||
                venue == null || venue.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Please fill out all required fields");

            // Get event for form values
            try {
                int eventId = Integer.parseInt(eventIdStr);
                EventDAO eventDAO = new EventDAO();
                Event event = eventDAO.getEventById(eventId);
                request.setAttribute("event", event);

                // Get venues for dropdown
                VenueDAO venueDAO = new VenueDAO();
                List<Venue> venues = venueDAO.getAllVenues();
                request.setAttribute("venues", venues);

                request.getRequestDispatcher("/WEB-INF/view/admin/edit_event.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/EventDashboard");
            }
            return;
        }

        try {
            int eventId = Integer.parseInt(eventIdStr);
            int attendees = 0;

            if (attendeesStr != null && !attendeesStr.trim().isEmpty()) {
                try {
                    attendees = Integer.parseInt(attendeesStr);
                } catch (NumberFormatException e) {
                    // Keep default 0 if parsing fails
                }
            }

            // Parse date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date eventDate = dateFormat.parse(dateStr);

            // Get existing event to preserve any values not in the form
            EventDAO eventDAO = new EventDAO();
            Event existingEvent = eventDAO.getEventById(eventId);

            if (existingEvent == null) {
                request.getSession().setAttribute("errorMessage", "Event not found");
                response.sendRedirect(request.getContextPath() + "/EventDashboard");
                return;
            }

            // Update event with new values
            existingEvent.setName(name);
            existingEvent.setDateTime(eventDate);
            existingEvent.setVenue(venue);
            existingEvent.setDescription(description);
            existingEvent.setManager(manager);
            existingEvent.setApproved(approved);
            existingEvent.setAttendees(attendees);

            // Save to database
            boolean success = eventDAO.updateEvent(existingEvent);

            if (success) {
                // Log activity
                ActivityLogDAO.logActivity(user.getUserId(), "UPDATE_EVENT", "Updated event '" + name + "'");

                // Set success message and redirect to events dashboard
                request.getSession().setAttribute("successMessage", "Event updated successfully");
                response.sendRedirect(request.getContextPath() + "/EventDashboard");
            } else {
                // Handle failure
                request.setAttribute("errorMessage", "Failed to update event");

                // Get venues for dropdown
                VenueDAO venueDAO = new VenueDAO();
                List<Venue> venues = venueDAO.getAllVenues();
                request.setAttribute("venues", venues);
                request.setAttribute("event", existingEvent);

                request.getRequestDispatcher("/WEB-INF/view/admin/edit_event.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid event ID");
            response.sendRedirect(request.getContextPath() + "/EventDashboard");
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid date format");

            try {
                int eventId = Integer.parseInt(eventIdStr);
                EventDAO eventDAO = new EventDAO();
                Event event = eventDAO.getEventById(eventId);
                request.setAttribute("event", event);

                // Get venues for dropdown
                VenueDAO venueDAO = new VenueDAO();
                List<Venue> venues = venueDAO.getAllVenues();
                request.setAttribute("venues", venues);

                request.getRequestDispatcher("/WEB-INF/view/admin/edit_event.jsp").forward(request, response);
            } catch (NumberFormatException ex) {
                response.sendRedirect(request.getContextPath() + "/EventDashboard");
            }
        }
    }
} 