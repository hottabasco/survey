package com.survey.config;

import com.survey.controller.LoginController;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

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
		boolean isResource = uri.startsWith(contextPath + "/jakarta.faces.resource/") ||
			uri.startsWith(contextPath + "/resources/");
		boolean isLoggedIn = (loginController != null && loginController.isLoggedIn());

		if(isLoggedIn && (uri.startsWith(contextPath + "/import.xhtml")
				|| uri.startsWith(contextPath + "/datasets.xhtml")
				|| uri.startsWith(contextPath + "/contractors.xhtml"))) {
			if(!loginController.isCanEdit()) {
				response.sendRedirect(contextPath + "/index.xhtml");
				return;
			}
		}

		if(isLoggedIn && (uri.startsWith(contextPath + "/import.xhtml") || uri.startsWith(contextPath + "/datasets.xhtml"))) {
			if(!loginController.isCanEdit()) {
				response.sendRedirect(contextPath + "/index.xhtml");
				return;
			}
		}

		if(isLoggedIn && uri.startsWith(contextPath + "/import.xhtml")) {
			if(!loginController.isCanEdit()) {
				response.sendRedirect(contextPath + "/index.xhtml");
				return;
			}
		}

		// Restrict users.xhtml strictly to ADMIN role
		if(isLoggedIn && uri.startsWith(contextPath + "/users.xhtml")) {
			String role = loginController.getCurrentUser().getRole();
			if(!"ADMIN".equalsIgnoreCase(role)) {
				response.sendRedirect(contextPath + "/index.xhtml");
				return;
			}
		}

		if(isLoggedIn || isLoginPage || isResource) {
			if(!isResource) {
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
