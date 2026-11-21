package com.survey.controller;

import com.survey.model.User;
import com.survey.service.DatabaseService;
import jakarta.enterprise.context.SessionScoped;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.FacesContext;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import java.io.Serializable;

@Named
@SessionScoped
public class LoginController implements Serializable {
	private static final long serialVersionUID = 1L;

	@Inject
	private DatabaseService dbService;

	private String username;
	private String password;
	private User currentUser;

	public String login() {
		User authenticatedUser = dbService.authenticate(username, password);

		if(authenticatedUser != null) {
			this.currentUser = authenticatedUser;
			this.password = null; // Clear password from memory
			return "/index.xhtml?faces-redirect=true";
		} else {
			FacesContext.getCurrentInstance().addMessage(null,
				new FacesMessage(FacesMessage.SEVERITY_ERROR, "Login Failed", "Invalid credentials or inactive account."));
			return null;
		}
	}

	public String logout() {
		FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
		return "/login.xhtml?faces-redirect=true";
	}

	public boolean isLoggedIn() {
		return currentUser != null;
	}

	// Add these methods to src/com/survey/controller/LoginController.java
	public boolean isAdmin() {
		return currentUser != null && "ADMIN".equalsIgnoreCase(currentUser.getRole());
	}

	public boolean isCanEdit() {
		if(currentUser == null || currentUser.getRole() == null) {
			return false;
		}
		String role = currentUser.getRole().toUpperCase();
		return "ADMIN".equals(role) || "EDITOR".equals(role);
	}

	// Getters and Setters
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public User getCurrentUser() {
		return currentUser;
	}
}
