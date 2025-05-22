package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import model.UserDAO;

import java.io.IOException;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/resetpassword"})
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        if (user == null) {
            // User not logged in, redirect to login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // Forward to reset password JSP
        request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get session and user
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        if (user == null) {
            // User not logged in, redirect to login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // Get form parameters
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
            return;
        }
        
        // Check if new password and confirm password match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New password and confirm password do not match");
            request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
            return;
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // Check if new password meets minimum requirements (at least 6 characters)
        if (newPassword.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters long");
            request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
            return;
        }
<<<<<<< HEAD

        try {
            // Verify current password and update to new password
            boolean authenticated = UserDAO.authenticate(user.getUserName(), currentPassword);

=======
        
        try {
            // Verify current password and update to new password
            boolean authenticated = UserDAO.authenticate(user.getUserName(), currentPassword);
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            if (!authenticated) {
                request.setAttribute("error", "Current password is incorrect");
                request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
                return;
            }
<<<<<<< HEAD

            // Update password
            boolean success = UserDAO.updatePassword(user.getId(), newPassword);

=======
            
            // Update password
            boolean success = UserDAO.updatePassword(user.getId(), newPassword);
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            if (success) {
                // Set success message and redirect to profile
                session.setAttribute("successMessage", "Password updated successfully");
                response.sendRedirect(request.getContextPath() + "/profile");
            } else {
                request.setAttribute("error", "Failed to update password");
                request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error updating password: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
        }
    }
}
