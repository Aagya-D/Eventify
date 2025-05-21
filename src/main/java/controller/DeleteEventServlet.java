package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Event;
import model.EventDAO;
import model.User;
import model.ActivityLogDAO;

import java.io.IOException;

@WebServlet("/admin/delete-event")
public class DeleteEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Delete operations should be performed via POST
        response.sendRedirect(request.getContextPath() + "/EventDashboard");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get event ID from request
        String eventIdStr = request.getParameter("id");
        if (eventIdStr == null || eventIdStr.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "No event ID provided");
            response.sendRedirect(request.getContextPath() + "/EventDashboard");
            return;
        }

        try {
            int eventId = Integer.parseInt(eventIdStr);

            // Get event by ID first to get its name for the log
            EventDAO eventDAO = new EventDAO();
            Event event = eventDAO.getEventById(eventId);

            if (event == null) {
                request.getSession().setAttribute("errorMessage", "Event not found");
                response.sendRedirect(request.getContextPath() + "/EventDashboard");
                return;
            }

            // Delete the event
            boolean success = eventDAO.deleteEvent(eventId);

            if (success) {
                // Log activity
                ActivityLogDAO.logActivity(user.getUserId(), "DELETE_EVENT", "Deleted event '" + event.getName() + "'");

                request.getSession().setAttribute("successMessage", "Event deleted successfully");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to delete event");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid event ID");
        }

        // Redirect back to events dashboard
        response.sendRedirect(request.getContextPath() + "/EventDashboard");
    }
} 