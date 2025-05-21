package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Event;
import model.EventDAO;
import model.User;

import java.io.IOException;

@WebServlet(name = "EventDetailsServlet", urlPatterns = {"/event-details"})
public class EventDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("EventDetailsServlet doGet() called");

        // Get event ID from request parameter
        String eventIdStr = request.getParameter("id");

        // Validate event ID
        if (eventIdStr == null || eventIdStr.trim().isEmpty()) {
            System.err.println("Error: No event ID provided");
            request.setAttribute("error", "No event ID provided");
            response.sendRedirect(request.getContextPath() + "/events");
            return;
        }

        try {
            // Parse event ID
            int eventId = Integer.parseInt(eventIdStr);

            // Get event details from database
            EventDAO eventDAO = new EventDAO();
            Event event = eventDAO.getEventById(eventId);

            if (event == null) {
                System.err.println("Error: Event not found with ID: " + eventId);
                request.setAttribute("error", "Event not found");
                response.sendRedirect(request.getContextPath() + "/events");
                return;
            }

            // Add event to request
            request.setAttribute("event", event);

            // Forward to event details JSP page
            request.getRequestDispatcher("/WEB-INF/view/event-details.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.err.println("Error: Invalid event ID format: " + eventIdStr);
            request.setAttribute("error", "Invalid event ID format");
            response.sendRedirect(request.getContextPath() + "/events");
        } catch (Exception e) {
            System.err.println("Error in EventDetailsServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Failed to retrieve event details: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/events");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // For now, just redirect to GET
        doGet(request, response);
    }
}