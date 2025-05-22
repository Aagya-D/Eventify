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
import java.util.List;

@WebServlet("/api/users/*")
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
<<<<<<< HEAD
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

=======
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all users (admin only)
            getAllUsers(request, response);
        } else {
            // Get user by ID
            String[] splits = pathInfo.split("/");
            if (splits.length == 2) {
                try {
                    int userId = Integer.parseInt(splits[1]);
                    getUserById(request, response, userId);
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }

    @Override
<<<<<<< HEAD
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
=======
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            throws ServletException, IOException {
        // Create new user
        createUser(request, response);
    }

    @Override
<<<<<<< HEAD
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
=======
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.length() > 1) {
            try {
                int userId = Integer.parseInt(pathInfo.substring(1));
                updateUser(request, response, userId);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID required");
        }
    }

    @Override
<<<<<<< HEAD
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
=======
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.length() > 1) {
            try {
                int userId = Integer.parseInt(pathInfo.substring(1));
                deleteUser(request, response, userId);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID required");
        }
    }

<<<<<<< HEAD
    private void getAllUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

=======
    private void getAllUsers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required");
            return;
        }

        List<User> users = UserDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/view/admin/users.jsp").forward(request, response);
    }

<<<<<<< HEAD
    private void getUserById(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

=======
    private void getUserById(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        if (!"ADMIN".equals(currentUser.getRole()) && currentUser.getUserId() != userId) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        User user = UserDAO.getUserById(userId);
        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/view/userprofile.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
        }
    }

<<<<<<< HEAD
    private void createUser(HttpServletRequest request, HttpServletResponse response)
=======
    private void createUser(HttpServletRequest request, HttpServletResponse response) 
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");

            User user = new User(username, email, password);
            user.setPhone(phone);

            if (!user.isValid()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user data");
                return;
            }

            int userId = UserDAO.addUser(user);
            if (userId > 0) {
                response.setStatus(HttpServletResponse.SC_CREATED);
                response.getWriter().write("User created successfully");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create user");
            }
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }

<<<<<<< HEAD
    private void updateUser(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

=======
    private void updateUser(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        if (!"ADMIN".equals(currentUser.getRole()) && currentUser.getUserId() != userId) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            User user = UserDAO.getUserById(userId);
            if (user == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
                return;
            }

            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");

            if (username != null) user.setUserName(username);
            if (email != null) user.setEmail(email);
            if (phone != null) user.setPhone(phone);
            if (role != null && "ADMIN".equals(currentUser.getRole())) user.setRole(role);

            if (!user.isValid()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user data");
                return;
            }

            boolean success = UserDAO.updateUserByAdmin(user);
            if (success) {
                response.getWriter().write("User updated successfully");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update user");
            }
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }

<<<<<<< HEAD
    private void deleteUser(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

=======
    private void deleteUser(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        if (!"ADMIN".equals(currentUser.getRole()) && currentUser.getUserId() != userId) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        boolean success = UserDAO.deleteUserById(userId);
        if (success) {
            if (currentUser.getUserId() == userId) {
                session.invalidate();
            }
            response.getWriter().write("User deleted successfully");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete user");
        }
    }
} 