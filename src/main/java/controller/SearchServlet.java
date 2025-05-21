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
        
        if (query != null && !query.trim().isEmpty()) {
            // Set search query as request attribute
            request.setAttribute("searchQuery", query);
            
            // Perform search based on type
            if (type == null || "all".equals(type)) {
                // Search both events and venues
                EventDAO eventDAO = new EventDAO();
                VenueDAO venueDAO = new VenueDAO();
                
                List<Event> events = eventDAO.searchEventsByTitle(query);
                List<Venue> venues = venueDAO.searchVenuesByName(query);
                
                request.setAttribute("events", events);
                request.setAttribute("venues", venues);
                request.setAttribute("eventCount", events.size());
                request.setAttribute("venueCount", venues.size());
                request.setAttribute("totalResults", events.size() + venues.size());
                
            } else if ("events".equals(type)) {
                // Search only events
                EventDAO eventDAO = new EventDAO();
                List<Event> events = eventDAO.searchEventsByTitle(query);
                
                request.setAttribute("events", events);
                request.setAttribute("eventCount", events.size());
                request.setAttribute("totalResults", events.size());
                
            } else if ("venues".equals(type)) {
                // Search only venues
                VenueDAO venueDAO = new VenueDAO();
                List<Venue> venues = venueDAO.searchVenuesByName(query);
                
                request.setAttribute("venues", venues);
                request.setAttribute("venueCount", venues.size());
                request.setAttribute("totalResults", venues.size());
            }
        }
        
        // Set the search type
        if (type != null) {
            request.setAttribute("searchType", type);
        } else {
            request.setAttribute("searchType", "all");
        }
        
        // Forward the request to the unified search JSP page
        request.getRequestDispatcher("/WEB-INF/view/search.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Process POST requests the same way as GET
        doGet(request, response);
    }
} 