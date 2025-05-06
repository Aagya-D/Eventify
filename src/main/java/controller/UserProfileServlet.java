package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;

public class UserProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            // User not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/UserProfile");
            return;
        }
        String success = (String) session.getAttribute("success");
        request.setAttribute("success", success);
        String error = (String) session.getAttribute("error");
        request.setAttribute("error", error);
        // Forward to user profile page
        request.getRequestDispatcher("/WEB-INF/view/userprofile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}