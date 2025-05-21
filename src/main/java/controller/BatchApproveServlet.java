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

@WebServlet(name = "BatchApproveServlet", urlPatterns = {"/admin/batch-approve"})
public class BatchApproveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        // Security check - Only ADMIN can access
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get all users
            List<User> allUsers = UserDAO.getAllUsers();
            int approvedCount = 0;

            // Approve all pending users
            if (allUsers != null && !allUsers.isEmpty()) {
                for (User user : allUsers) {
                    if ("PENDING".equals(user.getRole())) {
                        // Change role to USER
                        user.setRole("USER");

                        // Update user
                        boolean success = UserDAO.updateUserByAdmin(user);
                        if (success) {
                            approvedCount++;
                        }
                    }
                }
            }

            // Set success message with count
            if (approvedCount > 0) {
                session.setAttribute("successMessage", approvedCount + " users have been approved successfully.");
            } else {
                session.setAttribute("infoMessage", "No pending users were found to approve.");
            }
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error during batch approval: " + e.getMessage());
        }

        // Preserve filters when redirecting back
        String roleFilter = request.getParameter("roleFilter");
        String searchQuery = request.getParameter("searchQuery");

        StringBuilder redirectUrl = new StringBuilder(request.getContextPath() + "/admin/manage-users");
        boolean hasParam = false;

        if (roleFilter != null && !roleFilter.isEmpty()) {
            redirectUrl.append("?roleFilter=").append(roleFilter);
            hasParam = true;
        }

        if (searchQuery != null && !searchQuery.isEmpty()) {
            redirectUrl.append(hasParam ? "&" : "?").append("searchQuery=").append(searchQuery);
        }

        // Redirect back to manage users page
        response.sendRedirect(redirectUrl.toString());
    }
} 