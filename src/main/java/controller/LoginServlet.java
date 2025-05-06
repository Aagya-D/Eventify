package controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.User;
import model.UserDAO;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private static final String REMEMBER_ME_COOKIE_NAME = "rememberMe";
    private static final int COOKIE_MAX_AGE = 7 * 24 * 60 * 60; // 7 days in seconds

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is already logged in via remember me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (REMEMBER_ME_COOKIE_NAME.equals(cookie.getName())) {
                    String[] credentials = decodeCookieValue(cookie.getValue());
                    if (credentials != null && credentials.length == 2) {
                        String email = credentials[0];
                        String password = credentials[1];
                        User user = UserDAO.getUserByEmailOrUsername(email, password);
                        if (user != null) {
                            // Auto login successful
                            HttpSession session = request.getSession();
                            session.setAttribute("user", user);
                            session.setAttribute("loggedIn", true);
                            
                            // Check if user is an admin and redirect accordingly
                            if ("ADMIN".equals(user.getRole())) {
                                response.sendRedirect(request.getContextPath() + "/AdminDashboard");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/");
                            }
                            return;
                        }
                    }
                }
            }
        }

        // Check if there's a success message
        String registrationSuccess = (String) request.getSession().getAttribute("registrationSuccess");
        if (registrationSuccess != null) {
            request.setAttribute("registrationSuccess", registrationSuccess);
            // Remove the session attribute to prevent showing the message again
            request.getSession().removeAttribute("registrationSuccess");
        }

        // Redirect to the login.jsp page in WEB-INF/view directory
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return;
        }

        // Authenticate user
        User user = UserDAO.getUserByEmailOrUsername(email, password);

        if (user != null) {
            // Authentication successful
            // Store user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("loggedIn", true);

            // Handle remember me functionality
            if (rememberMe != null && rememberMe.equals("on")) {
                String cookieValue = encodeCookieValue(email, password);
                
                // Set the standard cookie with available attributes
                Cookie rememberMeCookie = new Cookie(REMEMBER_ME_COOKIE_NAME, cookieValue);
                rememberMeCookie.setMaxAge(COOKIE_MAX_AGE);
                rememberMeCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                rememberMeCookie.setHttpOnly(true); // Not accessible via JavaScript
                
                if (request.isSecure()) {
                    rememberMeCookie.setSecure(true); // HTTPS only
                }
                
                response.addCookie(rememberMeCookie);
                
                // Add the SameSite attribute via header (not supported in javax.servlet Cookie API)
                String headerValue = String.format("%s=%s; Max-Age=%d; Path=%s; HttpOnly; SameSite=Strict", 
                    REMEMBER_ME_COOKIE_NAME, 
                    cookieValue, 
                    COOKIE_MAX_AGE, 
                    request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                
                if (request.isSecure()) {
                    headerValue += "; Secure";
                }
                
                response.setHeader("Set-Cookie", headerValue);
            }

            // Check user role and redirect accordingly
            if ("ADMIN".equals(user.getRole())) {
                // Admin user - redirect to admin dashboard
                response.sendRedirect(request.getContextPath() + "/AdminDashboard");
            } else {
                // Regular user - redirect to homepage
                response.sendRedirect(request.getContextPath() + "/");
            }
        } else {
            // Authentication failed
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }

    // Helper method to encode username and password for cookie
    private String encodeCookieValue(String username, String password) {
        // Simple encoding - in production, use more secure methods
        return username + ":" + password;
    }

    // Helper method to decode cookie value
    private String[] decodeCookieValue(String cookieValue) {
        // Simple decoding - in production, use more secure methods
        return cookieValue.split(":");
    }
}