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
import java.util.List;

public class EventsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Get all events
        EventDAO eventDAO = new EventDAO();
        List<Event> eventList = eventDAO.getAllEvents();

        // Add events to request
        request.setAttribute("eventList", eventList);

        // Forward to events JSP page
        request.getRequestDispatcher("/WEB-INF/view/events.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle post requests (e.g., for filtering events)
        doGet(request, response);
    }
}