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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ManageUsersServlet", urlPatterns = {"/admin/manage-users"})
public class ManageUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Security check - Only ADMIN can access
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get filter parameters
        String roleFilter = request.getParameter("roleFilter");
        String searchQuery = request.getParameter("searchQuery");

        // Check for any info messages
        String infoMessage = (String) session.getAttribute("infoMessage");
        if (infoMessage != null) {
            request.setAttribute("infoMessage", infoMessage);
            session.removeAttribute("infoMessage");
        }

        // Get all users
        List<User> allUsers = UserDAO.getAllUsers();
        List<User> filteredUsers = new ArrayList<>();

        // Apply filters if provided
        if (allUsers != null && !allUsers.isEmpty()) {
            for (User u : allUsers) {
                boolean includeUser = true;

                // Apply role filter if selected
                if (roleFilter != null && !roleFilter.isEmpty() && !roleFilter.equals("ALL")) {
                    if (!u.getRole().equals(roleFilter)) {
                        includeUser = false;
                    }
                }

                // Apply search filter if provided
                if (searchQuery != null && !searchQuery.isEmpty()) {
                    searchQuery = searchQuery.toLowerCase();
                    if (!(u.getUserName().toLowerCase().contains(searchQuery) ||
                            u.getEmail().toLowerCase().contains(searchQuery))) {
                        includeUser = false;
                    }
                }

                if (includeUser) {
                    filteredUsers.add(u);
                }
            }
        } else {
            filteredUsers = allUsers; // If no filters, use all users
        }

        // Get user counts by role for the filter dropdown counts
        int totalUsers = UserDAO.getUserCount();
        int pendingUsers = 0;
        int activeUsers = 0;

        for (User u : allUsers) {
            if ("PENDING".equals(u.getRole())) {
                pendingUsers++;
            } else if ("USER".equals(u.getRole())) {
                activeUsers++;
            }
        }

        // Pass data to request
        request.setAttribute("users", filteredUsers);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("pendingUsers", pendingUsers);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("roleFilter", roleFilter);
        request.setAttribute("searchQuery", searchQuery);

        // Forward to the manage users page
        request.getRequestDispatcher("/WEB-INF/view/admin/manage_users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        // Security check - Only ADMIN can access
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            int userId = Integer.parseInt(request.getParameter("userId"));

            switch (action) {
                case "approve":
                    handleUserApproval(session, userId);
                    break;

                case "changeRole":
                    String newRole = request.getParameter("newRole");
                    handleRoleChange(session, userId, newRole);
                    break;

                case "delete":
                    handleUserDeletion(session, userId);
                    break;

                default:
                    session.setAttribute("errorMessage", "Invalid action requested.");
                    break;
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid user ID format.");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
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

        // Redirect back to the manage users page with filters preserved
        response.sendRedirect(redirectUrl.toString());
    }

    private void handleUserApproval(HttpSession session, int userId) {
        User userToApprove = UserDAO.getUserById(userId);

        if (userToApprove != null) {
            String oldRole = userToApprove.getRole();
            boolean isPending = "PENDING".equals(oldRole);

            // Change role to USER
            userToApprove.setRole("USER");

            // Update the user
            boolean success = UserDAO.updateUserByAdmin(userToApprove);

            if (success) {
                if (isPending) {
                    session.setAttribute("successMessage", "User " + userToApprove.getUserName() + " has been approved successfully.");
                } else {
                    session.setAttribute("successMessage", "User " + userToApprove.getUserName() + " has been approved successfully.");
                }
            } else {
                session.setAttribute("errorMessage", "Failed to approve user. Please try again.");
            }
        } else {
            session.setAttribute("errorMessage", "User not found.");
        }
    }

    private void handleRoleChange(HttpSession session, int userId, String newRole) {
        if (newRole == null || newRole.isEmpty()) {
            session.setAttribute("errorMessage", "New role cannot be empty.");
            return;
        }

        // Validate the role
        if (!newRole.equals("USER") && !newRole.equals("MANAGER") && !newRole.equals("ADMIN")) {
            session.setAttribute("errorMessage", "Invalid role selected.");
            return;
        }

        User userToUpdate = UserDAO.getUserById(userId);

        if (userToUpdate != null) {
            // Don't allow changing own role (admin can't demote themselves)
            User currentAdmin = (User) session.getAttribute("user");
            if (userToUpdate.getUserId() == currentAdmin.getUserId()) {
                session.setAttribute("errorMessage", "You cannot change your own role.");
                return;
            }

            String oldRole = userToUpdate.getRole();
            userToUpdate.setRole(newRole);

            boolean success = UserDAO.updateUserByAdmin(userToUpdate);

            if (success) {
                session.setAttribute("successMessage",
                        "User " + userToUpdate.getUserName() + " role changed from " + oldRole + " to " + newRole + ".");
            } else {
                session.setAttribute("errorMessage", "Failed to update user role. Please try again.");
            }
        } else {
            session.setAttribute("errorMessage", "User not found.");
        }
    }

    private void handleUserDeletion(HttpSession session, int userId) {
        // Get the user first to show the username in the success message
        User userToDelete = UserDAO.getUserById(userId);

        if (userToDelete != null) {
            // Don't allow deleting yourself
            User currentAdmin = (User) session.getAttribute("user");
            if (userToDelete.getUserId() == currentAdmin.getUserId()) {
                session.setAttribute("errorMessage", "You cannot delete your own account.");
                return;
            }

            String username = userToDelete.getUserName();
            boolean success = UserDAO.deleteUserById(userId);

            if (success) {
                session.setAttribute("successMessage", "User " + username + " has been deleted successfully.");
            } else {
                session.setAttribute("errorMessage", "Failed to delete user. Please try again.");
            }
        } else {
            session.setAttribute("errorMessage", "User not found.");
        }
    }
} 