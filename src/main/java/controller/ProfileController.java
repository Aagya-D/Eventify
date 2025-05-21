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

@WebServlet("/profile/*")
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            // Show profile page
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/view/userprofile.jsp").forward(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Show edit form
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/view/editprofile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            // Update profile
            updateProfile(request, response, currentUser, session);
        } else if (pathInfo.equals("/delete")) {
            // Delete profile
            deleteProfile(request, response, currentUser);
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User currentUser, HttpSession session)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String fullName = request.getParameter("fullName");

            // Update user object
            if (username != null && !username.equals(currentUser.getUserName())) {
                currentUser.setUserName(username);
            }
            if (email != null && !email.equals(currentUser.getEmail())) {
                currentUser.setEmail(email);
            }
            if (phone != null && !phone.equals(currentUser.getPhone())) {
                currentUser.setPhone(phone);
            }
            if (fullName != null && !fullName.equals(currentUser.getFullName())) {
                currentUser.setFullName(fullName);
            }

            // Validate the updated user
            if (!currentUser.isValid()) {
                request.setAttribute("error", "Invalid input data");
                request.getRequestDispatcher("/WEB-INF/view/editprofile.jsp").forward(request, response);
                return;
            }

            // Update in database
            boolean success = UserDAO.updateUserByAdmin(currentUser);

            if (success) {
                // Update session
                session.setAttribute("user", currentUser);
                request.setAttribute("success", "Profile updated successfully");
            } else {
                request.setAttribute("error", "Failed to update profile");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
        }

        // Forward back to profile page
        request.getRequestDispatcher("/WEB-INF/view/userprofile.jsp").forward(request, response);
    }

    private void deleteProfile(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        String password = request.getParameter("password");

        if (password == null || password.isEmpty()) {
            request.setAttribute("error", "Password is required for account deletion");
            request.getRequestDispatcher("/WEB-INF/view/userprofile.jsp").forward(request, response);
            return;
        }

        // Verify password before deletion
        User user = UserDAO.getUserByEmailOrUsername(currentUser.getEmail(), password);
        if (user == null) {
            request.setAttribute("error", "Incorrect password");
            request.getRequestDispatcher("/WEB-INF/view/userprofile.jsp").forward(request, response);
            return;
        }

        // Delete user
        boolean success = UserDAO.deleteUserById(currentUser.getUserId());
        if (success) {
            // Invalidate session
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            request.setAttribute("error", "Failed to delete account");
            request.getRequestDispatcher("/WEB-INF/view/userprofile.jsp").forward(request, response);
        }
    }
} 