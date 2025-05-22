package controller;

import model.User;
import model.UserDAO;
import model.EventDAO;
import model.VenueDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/profile")
public class AdminProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
<<<<<<< HEAD
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

=======
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // Check if user is logged in and is an admin
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get the admin user and pass to JSP
        request.setAttribute("user", currentUser);
<<<<<<< HEAD

        // Get admin stats from DAOs
        int userCount = UserDAO.getUserCount();

        EventDAO eventDAO = new EventDAO();
        int eventCount = eventDAO.getEventCount();

        VenueDAO venueDAO = new VenueDAO();
        int venueCount = venueDAO.getVenueCount();

=======
        
        // Get admin stats from DAOs
        int userCount = UserDAO.getUserCount();
        
        EventDAO eventDAO = new EventDAO();
        int eventCount = eventDAO.getEventCount();
        
        VenueDAO venueDAO = new VenueDAO();
        int venueCount = venueDAO.getVenueCount();
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // Set attributes for JSP
        request.setAttribute("userCount", userCount);
        request.setAttribute("eventCount", eventCount);
        request.setAttribute("venueCount", venueCount);
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // Forward to admin profile page
        request.getRequestDispatcher("/WEB-INF/view/admin/admin_profile.jsp").forward(request, response);
    }
} 