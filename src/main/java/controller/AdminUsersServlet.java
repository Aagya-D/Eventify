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
import java.util.List;

@WebServlet(name = "AdminUsersServlet", urlPatterns = {"/admin/users"})
public class AdminUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Additional security check - Only ADMIN can access
        if (user == null || !"ADMIN".equals(user.getRole())) {
            request.setAttribute("error", "Access denied. Admin privileges required.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        // Handle actions
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("edit")) {
                handleEditUser(request, response);
                return;
            } else if (action.equals("delete")) {
                handleDeleteUser(request, response);
                return;
            }
        }

        // Default: Show users list
        List<User> users = UserDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/view/admin/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Additional security check - Only ADMIN can access
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            request.setAttribute("error", "Access denied. Admin privileges required.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        // Handle form submissions
        String action = request.getParameter("action");

        if ("updateUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String role = request.getParameter("role");

            // Create user object with updated values
            User updatedUser = new User();
            updatedUser.setUserId(userId);
            updatedUser.setUserName(userName);
            updatedUser.setEmail(email);
            updatedUser.setRole(role);

            // Update user in database
            boolean success = UserDAO.updateUserByAdmin(updatedUser);

            if (success) {
                request.getSession().setAttribute("successMessage", "User updated successfully");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update user");
            }

            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    private void handleEditUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        User userToEdit = UserDAO.getUserById(userId);

        if (userToEdit != null) {
            request.setAttribute("userToEdit", userToEdit);
            request.getRequestDispatcher("/WEB-INF/view/admin/edit-user.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("errorMessage", "User not found");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));

        boolean success = UserDAO.deleteUserById(userId);

        if (success) {
            request.getSession().setAttribute("successMessage", "User deleted successfully");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to delete user");
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
} 