package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Venue;
import model.VenueDAO;

/**
 * Servlet that handles requests to the Venues page
 */
@WebServlet("/venues")
public class VenuesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch all venues from the database
        VenueDAO venueDAO = new VenueDAO();
        List<Venue> venues = venueDAO.getAllVenues();

        // Set venues as request attribute
        request.setAttribute("venues", venues);

        // Forward the request to the venues JSP page
        request.getRequestDispatcher("/WEB-INF/view/venues.jsp").forward(request, response);
    }
}