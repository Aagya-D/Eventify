package controller;

import model.User;
import model.UserDAO;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Check if user is logged in and is an admin
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get the admin user and pass to JSP
        request.setAttribute("user", currentUser);
        
        // Get admin stats
        int userCount = UserDAO.getUserCount();
        request.setAttribute("userCount", userCount);
        
        // Forward to admin profile page
        request.getRequestDispatcher("/WEB-INF/view/admin/admin_profile.jsp").forward(request, response);
    }
} 