package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Arrays;
import java.util.List;

@WebFilter(urlPatterns = {"/*"})
public class RoleBasedFilter implements Filter {

    // Define admin-specific URL patterns
    private static final List<String> ADMIN_PATHS = Arrays.asList(
            "/admin",
            "/AdminDashboard",
            "/VenueDashboard",
            "/EventDashboard",
            "/admin/add-venue",
            "/admin/edit-venue",
            "/admin/delete-venue",
            "/admin/add-event",
            "/admin/edit-event",
            "/admin/delete-event",
            "/admin/manage-users",
            "/admin/users",
            "/admin/profile",
            "/venue/details",
            "/venue/edit",
            "/ManageUsers",
            "/BatchApproveUsers"
    );

    // Define regular user URL patterns
    private static final List<String> USER_PATHS = Arrays.asList(
            "/events",
            "/venues",
            "/profile",
            "/UserProfileServlet",
            "/editprofile",
            "/resetpassword",
            "/reset-password",
            "/ResetPasswordServlet",
            "/logout",
            "/LogoutServlet",
            "/add-event",
            "/AddEventServlet",
            "/delete-account",
            "/DeleteAccountServlet",
            "/index.jsp",
            "/"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestPath = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // Skip processing for public resources
        if (isPublicResource(requestPath)) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        // Get user role
        User user = (User) session.getAttribute("user");
        String userRole = user.getRole();

        // Check access permissions
        if (isAdminPath(requestPath) && !"ADMIN".equals(userRole)) {
            // Non-admin user trying to access admin paths
            httpRequest.setAttribute("error", "You don't have permission to access this resource");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/");
            return;
        }

        // Allow the request to proceed
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }

    private boolean isAdminPath(String path) {
        for (String adminPath : ADMIN_PATHS) {
            if (path.equals(adminPath) || path.startsWith(adminPath + "/")) {
                return true;
            }
        }
        return false;
    }

    private boolean isUserPath(String path) {
        for (String userPath : USER_PATHS) {
            if (path.equals(userPath) || path.startsWith(userPath + "/")) {
                return true;
            }
        }
        return false;
    }

    private boolean isPublicResource(String path) {
        // Public resources that don't require role checking
        List<String> publicPaths = Arrays.asList(
                "/login", "/LoginServlet",
                "/register", "/RegisterServlet",
                "/assets", "/css", "/js", "/images",
                "/search-events", "/search-venues",
                "/index.jsp",
                "/"
        );

        for (String publicPath : publicPaths) {
            if (path.equals(publicPath) || path.startsWith(publicPath + "/")) {
                return true;
            }
        }
        return false;
    }
} 