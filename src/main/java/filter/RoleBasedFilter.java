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

@WebFilter(urlPatterns = {"/admin/*"})
public class RoleBasedFilter implements Filter {
    
    // Define role-based URL patterns
    private static final Map<String, List<String>> ROLE_PATHS = new HashMap<>();
    
    static {
        // Admin paths
        ROLE_PATHS.put("ADMIN", Arrays.asList(
            "/admin",
            "/admin/dashboard",
            "/admin/events",
            "/admin/users"
        ));
        
        // Moderator paths (if you have this role)
        ROLE_PATHS.put("MODERATOR", Arrays.asList(
            "/admin/events"
        ));
    }

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
        
        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        // Get user role
        User user = (User) session.getAttribute("user");
        String userRole = user.getRole();
        
        // Check if user has permission to access the requested page
        if (hasPermission(userRole, requestPath)) {
            chain.doFilter(request, response);
        } else {
            // Redirect to access denied page or home
            httpRequest.setAttribute("error", "You don't have permission to access this resource");
            httpRequest.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
    
    private boolean hasPermission(String role, String path) {
        // Admin has access to everything
        if ("ADMIN".equals(role)) {
            return true;
        }
        
        // Check role-specific paths
        List<String> allowedPaths = ROLE_PATHS.get(role);
        if (allowedPaths != null) {
            for (String allowedPath : allowedPaths) {
                if (path.equals(allowedPath) || path.startsWith(allowedPath + "/")) {
                    return true;
                }
            }
        }
        
        // Default user role can access regular pages but not admin
        return !path.startsWith("/admin");
    }
} 