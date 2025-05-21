package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.Event;
import model.EventDAO;
import model.VenueDAO;
import model.Venue;
import model.ActivityLogDAO;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/add-event")
public class AdminAddEventServlet extends HttpServlet {

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

        // Forward to the admin add event form
        request.getRequestDispatcher("/WEB-INF/view/admin/add_event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("AdminAddEventServlet: Processing POST request");

        // Check if user is logged in and is an admin
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            System.out.println("AdminAddEventServlet: User not authenticated or not admin");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get form parameters
        String name = request.getParameter("name");
        String dateStr = request.getParameter("date");
        String venueName = request.getParameter("venue");
        String description = request.getParameter("description");
        String manager = request.getParameter("manager");
        boolean approved = request.getParameter("approved") != null;

        System.out.println("AdminAddEventServlet: Received form data - Name: " + name +
                ", Date: " + dateStr + ", Venue: " + venueName +
                ", Manager: " + manager + ", Approved: " + approved);

        // Validation
        if (name == null || name.trim().isEmpty() ||
                dateStr == null || dateStr.trim().isEmpty() ||
                venueName == null || venueName.trim().isEmpty()) {

            System.out.println("AdminAddEventServlet: Validation failed - missing required fields");

            // Set error message
            request.setAttribute("errorMessage", "Please fill in all required fields");

            // Repopulate the venue dropdown
            VenueDAO venueDAO = new VenueDAO();
            List<Venue> venues = venueDAO.getAllVenues();
            request.setAttribute("venues", venues);

            // Forward back to the form
            request.getRequestDispatcher("/WEB-INF/view/admin/add_event.jsp").forward(request, response);
            return;
        }

        try {
            // Parse date
            System.out.println("AdminAddEventServlet: Parsing date: " + dateStr);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date dateTime = dateFormat.parse(dateStr);
            System.out.println("AdminAddEventServlet: Parsed date as: " + dateTime);

            // Calculate days until event
            long diffInMillies = dateTime.getTime() - new Date().getTime();
            int daysUntilEvent = (int) (diffInMillies / (1000 * 60 * 60 * 24));
            System.out.println("AdminAddEventServlet: Days until event: " + daysUntilEvent);

            // Create new event
            Event event = new Event();
            event.setName(name);
            event.setDateTime(dateTime);
            event.setDaysUntilEvent(daysUntilEvent);
            event.setVenue(venueName);
            event.setDescription(description);
            event.setManager(manager);
            event.setApproved(approved);
            event.setAttendees(0); // Default to 0 attendees

            // Save to database
            System.out.println("AdminAddEventServlet: Attempting to save event to database");
            EventDAO eventDAO = new EventDAO();
            boolean success = eventDAO.addEvent(event);

            if (success) {
                System.out.println("AdminAddEventServlet: Event created successfully");
                // Log admin activity
                ActivityLogDAO.logActivity(user.getUserId(), "CREATE", "Created new event: " + name);

                // Set success message in session for redirect
                request.getSession().setAttribute("successMessage", "Event created successfully!");

                // Redirect to event dashboard
                response.sendRedirect(request.getContextPath() + "/EventDashboard");
            } else {
                System.err.println("AdminAddEventServlet: Failed to create event");
                // Set error message
                request.setAttribute("errorMessage", "Failed to create event. Please check database connection.");

                // Repopulate the venue dropdown
                VenueDAO venueDAO = new VenueDAO();
                List<Venue> venues = venueDAO.getAllVenues();
                request.setAttribute("venues", venues);

                // Forward back to the form
                request.getRequestDispatcher("/WEB-INF/view/admin/add_event.jsp").forward(request, response);
            }
        } catch (ParseException e) {
            System.err.println("AdminAddEventServlet: Date parsing error: " + e.getMessage());
            // Set error message
            request.setAttribute("errorMessage", "Invalid date format. Please try again.");

            // Repopulate the venue dropdown
            VenueDAO venueDAO = new VenueDAO();
            List<Venue> venues = venueDAO.getAllVenues();
            request.setAttribute("venues", venues);

            // Forward back to the form
            request.getRequestDispatcher("/WEB-INF/view/admin/add_event.jsp").forward(request, response);
        }
    }
}