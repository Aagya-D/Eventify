package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import model.Venue;
import model.VenueDAO;

import java.io.IOException;

@WebServlet("/add-venue")
public class AddVenueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // Redirect to login page if not logged in
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        // Forward to add venue JSP page
        request.getRequestDispatcher("/WEB-INF/view/addvenue.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // Redirect to login page if not logged in
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        // Get form parameters
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String zipCode = request.getParameter("zipCode");
        String phone = request.getParameter("phone");
        String web = request.getParameter("web");
        String email = request.getParameter("email");

        // Validate form parameters
        if (name == null || name.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                zipCode == null || zipCode.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {

            request.setAttribute("error", "All required fields must be filled");
            request.getRequestDispatcher("/WEB-INF/view/addvenue.jsp").forward(request, response);
            return;
        }

        // Create venue object
        Venue venue = new Venue();
        venue.setName(name);
        venue.setAddress(address);
        venue.setZipCode(zipCode);
        venue.setPhone(phone);
        venue.setWeb(web);
        venue.setEmailAddress(email);

        // Add venue to database
        VenueDAO venueDAO = new VenueDAO();
        boolean success = venueDAO.addVenue(venue);

        if (success) {
            // Redirect to venues page with success message
            request.getSession().setAttribute("successMessage", "Venue added successfully");
            response.sendRedirect(request.getContextPath() + "/venues");
        } else {
            // Show error message
            request.setAttribute("error", "Failed to add venue");
            request.getRequestDispatcher("/WEB-INF/view/addvenue.jsp").forward(request, response);
 }
}
}
