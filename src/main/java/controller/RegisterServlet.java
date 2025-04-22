package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import model.User;
import model.UserDAO;

import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register", "/RegisterServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,  // 1 MB
        maxFileSize = 1024 * 1024 * 5,     // 5 MB
        maxRequestSize = 1024 * 1024 * 10   // 10 MB
)
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect to the registration page
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get form parameters
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String fullName = request.getParameter("fullName");
            String dateOfBirthStr = request.getParameter("dateOfBirth");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            // Validation
            boolean hasError = false;
            String errorMessage = "";

            // Check if required fields are present
            if (username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty()) {
                
                hasError = true;
                errorMessage = "All fields are required";
            }
            // Check if passwords match
            else if (!password.equals(confirmPassword)) {
                hasError = true;
                errorMessage = "Passwords do not match";
            }

            // Parse date of birth
            Date dateOfBirth = null;
            try {
                if (dateOfBirthStr != null && !dateOfBirthStr.isEmpty()) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    dateOfBirth = sdf.parse(dateOfBirthStr);
                }
            } catch (ParseException e) {
                hasError = true;
                errorMessage = "Invalid date format";
            }

            // If validation fails, redirect back to registration form with error
            if (hasError) {
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
                return;
            }

            // Create user object
            User newUser = new User(
                    username,
                    email,
                    password
            );

            // Add user to database
            int userId = UserDAO.addUser(newUser);

            if (userId > 0) {
                // Registration successful, redirect to login page with success message
                request.getSession().setAttribute("success", "Registration successful! Please login.");
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                // Registration failed, redirect back to registration form with error
                request.setAttribute("error", "Registration failed. Username or email may already be in use.");
                request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Log the error
            System.err.println("Error in RegisterServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Handle any exceptions during processing
            request.setAttribute("error", "An error occurred during registration. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
        }
    }
}