package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.Venue;
import model.VenueDAO;
import model.ActivityLogDAO;

import java.io.IOException;

@WebServlet("/add-venue")
public class AddVenueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the add venue form
        request.getRequestDispatcher("/WEB-INF/view/add-venue.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String contactNumber = request.getParameter("contactNumber");
        String capacityStr = request.getParameter("capacity");

        // Validate required fields
        if (name == null || name.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                city == null || city.trim().isEmpty() ||
                contactNumber == null || contactNumber.trim().isEmpty() ||
                capacityStr == null || capacityStr.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/view/add-venue.jsp").forward(request, response);
            return;
        }

        try {
            // Parse capacity
            int capacity = Integer.parseInt(capacityStr);

            if (capacity <= 0) {
                request.setAttribute("error", "Capacity must be greater than zero");
                request.getRequestDispatcher("/WEB-INF/view/add-venue.jsp").forward(request, response);
                return;
            }

            // Create new venue object
            Venue venue = new Venue();
            venue.setName(name);
            venue.setAddress(address);
            venue.setCity(city);
            venue.setContactNumber(contactNumber);
            venue.setCapacity(capacity);

            // Save to database
            VenueDAO venueDAO = new VenueDAO();
            boolean success = venueDAO.addVenue(venue);

            if (success) {
                // Set success message in session so it persists through redirect
                request.getSession().setAttribute("successMessage", "Venue '" + name + "' has been created successfully!");
                // Redirect to venues page with success parameter
                response.sendRedirect(request.getContextPath() + "/venues?success=true");
            } else {
                request.setAttribute("error", "Failed to add venue. Please try again.");
                request.getRequestDispatcher("/WEB-INF/view/add-venue.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Capacity must be a valid number");
            request.getRequestDispatcher("/WEB-INF/view/add-venue.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/add-venue.jsp").forward(request, response);
        }
    }
}
