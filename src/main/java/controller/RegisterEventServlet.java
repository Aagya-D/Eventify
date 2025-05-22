package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.EventDAO;
import model.User;

import java.io.IOException;

@WebServlet("/register-event")
public class RegisterEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("DEBUG: RegisterEventServlet doPost() called");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Check if user is logged in
        if (user == null) {
            System.out.println("DEBUG: RegisterEventServlet: User not logged in");
            session.setAttribute("errorMessage", "Please login to register for an event.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        System.out.println("DEBUG: RegisterEventServlet: User logged in: " + user.getUserId());

        // Get event ID from request
        String eventIdStr = request.getParameter("eventId");
        if (eventIdStr == null || eventIdStr.trim().isEmpty()) {
            System.out.println("DEBUG: RegisterEventServlet: No eventId received");
            session.setAttribute("errorMessage", "Invalid event.");
            response.sendRedirect(request.getContextPath() + "/events");
            return;
        }
        System.out.println("DEBUG: RegisterEventServlet: Received eventIdStr: " + eventIdStr);

        try {
            int eventId = Integer.parseInt(eventIdStr);
            System.out.println("DEBUG: RegisterEventServlet: Parsed eventId: " + eventId);
            EventDAO eventDAO = new EventDAO();

            // Call DAO method to register user for the event
            System.out.println("DEBUG: RegisterEventServlet: Calling registerUserForEvent for eventId " + eventId + " and userId " + user.getUserId());
            boolean success = eventDAO.registerUserForEvent(eventId, user.getUserId());

            if (success) {
                System.out.println("DEBUG: RegisterEventServlet: User registered successfully");
                session.setAttribute("successMessage", "Successfully registered for the event!");
            } else {
                System.out.println("DEBUG: RegisterEventServlet: User registration failed or already registered");
                session.setAttribute("errorMessage", "Failed to register for the event. You might already be registered.");
            }

            // Redirect back to the event details page
            System.out.println("DEBUG: RegisterEventServlet: Redirecting to event details page for eventId " + eventId);
            response.sendRedirect(request.getContextPath() + "/event-details?id=" + eventId);

        } catch (NumberFormatException e) {
            System.err.println("DEBUG: RegisterEventServlet: NumberFormatException for eventIdStr: " + eventIdStr);
            session.setAttribute("errorMessage", "Invalid event ID format.");
            response.sendRedirect(request.getContextPath() + "/events");
        } catch (Exception e) {
            System.err.println("DEBUG: RegisterEventServlet: An error occurred during registration: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred during registration: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/event-details?id=" + request.getParameter("eventId"));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Registration should be a POST request
        response.sendRedirect(request.getContextPath() + "/events");
    }
} 