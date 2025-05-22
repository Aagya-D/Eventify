package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Event;
import model.EventDAO;
import model.Venue;
import model.VenueDAO;

/**
 * Unified Servlet that handles all search requests for both events and venues
 */
@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get search parameters
        String query = request.getParameter("query");
        String type = request.getParameter("type"); // "events", "venues", or null/all (for both)
<<<<<<< HEAD

        if (query != null && !query.trim().isEmpty()) {
            // Set search query as request attribute
            request.setAttribute("searchQuery", query);

=======
        
        if (query != null && !query.trim().isEmpty()) {
            // Set search query as request attribute
            request.setAttribute("searchQuery", query);
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Perform search based on type
            if (type == null || "all".equals(type)) {
                // Search both events and venues
                EventDAO eventDAO = new EventDAO();
                VenueDAO venueDAO = new VenueDAO();
<<<<<<< HEAD

                List<Event> events = eventDAO.searchEventsByTitle(query);
                List<Venue> venues = venueDAO.searchVenuesByName(query);

=======
                
                List<Event> events = eventDAO.searchEventsByTitle(query);
                List<Venue> venues = venueDAO.searchVenuesByName(query);
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                request.setAttribute("events", events);
                request.setAttribute("venues", venues);
                request.setAttribute("eventCount", events.size());
                request.setAttribute("venueCount", venues.size());
                request.setAttribute("totalResults", events.size() + venues.size());
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            } else if ("events".equals(type)) {
                // Search only events
                EventDAO eventDAO = new EventDAO();
                List<Event> events = eventDAO.searchEventsByTitle(query);
<<<<<<< HEAD

                request.setAttribute("events", events);
                request.setAttribute("eventCount", events.size());
                request.setAttribute("totalResults", events.size());

=======
                
                request.setAttribute("events", events);
                request.setAttribute("eventCount", events.size());
                request.setAttribute("totalResults", events.size());
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            } else if ("venues".equals(type)) {
                // Search only venues
                VenueDAO venueDAO = new VenueDAO();
                List<Venue> venues = venueDAO.searchVenuesByName(query);
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                request.setAttribute("venues", venues);
                request.setAttribute("venueCount", venues.size());
                request.setAttribute("totalResults", venues.size());
            }
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // Set the search type
        if (type != null) {
            request.setAttribute("searchType", type);
        } else {
            request.setAttribute("searchType", "all");
        }
<<<<<<< HEAD

        // Forward the request to the unified search JSP page
        request.getRequestDispatcher("/WEB-INF/view/search.jsp").forward(request, response);
    }

=======
        
        // Forward the request to the unified search JSP page
        request.getRequestDispatcher("/WEB-INF/view/search.jsp").forward(request, response);
    }
    
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Process POST requests the same way as GET
        doGet(request, response);
    }
<<<<<<< HEAD
}
=======
} 
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
