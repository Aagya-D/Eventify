package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter(urlPatterns = {"/*"})
public class AuthenticationFilter implements Filter {
    
    // Paths that don't require authentication
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/login", "/LoginServlet",
        "/register", "/RegisterServlet",
        "/assets", 
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
        
        // Check if the path is public or if the user is already authenticated
        boolean isPublicResource = isPublicResource(requestPath);
        boolean isAuthenticated = (session != null && session.getAttribute("user") != null);
        
        if (isPublicResource || isAuthenticated) {
            // Continue with the request
            chain.doFilter(request, response);
        } else {
            // Store the original request URL to redirect after login
            httpRequest.getSession().setAttribute("redirectURL", requestPath);
            
            // Redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
    
    private boolean isPublicResource(String path) {
        // Check if the path is in the public list
        for (String publicPath : PUBLIC_PATHS) {
            if (path.equals(publicPath) || path.startsWith(publicPath + "/")) {
                return true;
            }
        }
        return false;
    }
} 