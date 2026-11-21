package com.survey.config;

import com.survey.controller.LoginController;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Inject
    private LoginController loginController;

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();

        boolean isLoginPage = uri.startsWith(contextPath + "/login.xhtml");
        boolean isResource = uri.startsWith(contextPath + "/jakarta.faces.resource/") 
                          || uri.startsWith(contextPath + "/resources/");
        boolean isLoggedIn = (loginController != null && loginController.isLoggedIn());

        if (isLoggedIn || isLoginPage || isResource) {
            // Prevent browser caching of protected pages so "Back" button doesn't work after logout
            if (!isResource) {
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                response.setHeader("Pragma", "no-cache");
                response.setDateHeader("Expires", 0);
            }
            chain.doFilter(req, res);
        } else {
            response.sendRedirect(contextPath + "/login.xhtml");
        }
    }
}

