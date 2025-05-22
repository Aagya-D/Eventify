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
import java.util.List;

@WebServlet(name = "EventsServlet", urlPatterns = {"/events"})
public class EventsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("EventsServlet doGet() called");
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            // Get all events
            EventDAO eventDAO = new EventDAO();
            List<Event> eventList = eventDAO.getAllEvents();
<<<<<<< HEAD

            System.out.println("Events retrieved: " + (eventList != null ? eventList.size() : "null"));

            // Add events to request
            request.setAttribute("eventList", eventList);

=======
            
            System.out.println("Events retrieved: " + (eventList != null ? eventList.size() : "null"));

            // Add events to request
            request.setAttribute("eventList", eventList);

>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Forward to events JSP page
            request.getRequestDispatcher("/WEB-INF/view/events.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in EventsServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Failed to retrieve events: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/events.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle post requests (e.g., for filtering events)
        doGet(request, response);
    }
}