package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Event;
import model.EventDAO;
import model.User;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AddEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // Redirect to login page if not logged in
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Forward to add event JSP page
        request.getRequestDispatcher("/WEB-INF/view/add-event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // Redirect to login page if not logged in
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get form parameters
        String name = request.getParameter("name");
        String dateTimeStr = request.getParameter("dateTime");
        String venue = request.getParameter("venue");
        String description = request.getParameter("description");
        String manager = request.getParameter("manager");

        // Validate form parameters
        if (name == null || name.trim().isEmpty() ||
            dateTimeStr == null || dateTimeStr.trim().isEmpty() ||
            venue == null || venue.trim().isEmpty() ||
            description == null || description.trim().isEmpty() ||
            manager == null || manager.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/view/add-event.jsp").forward(request, response);
            return;
        }

        try {
            // Parse date and time
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date dateTime = dateFormat.parse(dateTimeStr);

            // Calculate days until event
            Date today = new Date();
            long diffInMillies = dateTime.getTime() - today.getTime();
            int daysUntilEvent = (int) (diffInMillies / (1000 * 60 * 60 * 24));

            // Create event object
            Event event = new Event();
            event.setName(name);
            event.setDateTime(dateTime);
            event.setDaysUntilEvent(daysUntilEvent);
            event.setVenue(venue);
            event.setDescription(description);
            event.setManager(manager);
            event.setApproved(false);
            event.setAttendees(0);

            // Add event to database
            EventDAO eventDAO = new EventDAO();
            boolean success = eventDAO.addEvent(event);

            if (success) {
                // Redirect to events page with success message
                request.getSession().setAttribute("successMessage", "Event added successfully");
                response.sendRedirect(request.getContextPath() + "/events");
            } else {
                // Show error message
                request.setAttribute("error", "Failed to add event");
                request.getRequestDispatcher("/WEB-INF/view/add-event.jsp").forward(request, response);
            }

        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format");
            request.getRequestDispatcher("/WEB-INF/view/add-event.jsp").forward(request, response);
        }
    }
}