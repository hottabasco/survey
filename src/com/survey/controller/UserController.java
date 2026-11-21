package com.survey.controller;

import com.survey.model.User;
import com.survey.service.DatabaseService;
import jakarta.annotation.PostConstruct;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.FacesContext;
import jakarta.faces.view.ViewScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import java.io.Serializable;
import java.util.List;

@Named
@ViewScoped
public class UserController implements Serializable {
    private static final long serialVersionUID = 1L;

    @Inject
    private DatabaseService dbService;

    private List<User> users;
    private User selectedUser;

    @PostConstruct
    public void init() {
        prepareNewUser();
        loadUsers();
    }

    public void loadUsers() {
        this.users = dbService.findAllUsers();
    }

    public void prepareNewUser() {
        this.selectedUser = new User();
    }

    public void saveUser() {
        try {
            dbService.saveUser(selectedUser);
            loadUsers();
            prepareNewUser();
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Saved", "User account saved successfully."));
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", e.getMessage()));
        }
    }

    public List<User> getUsers() { return users; }
    public User getSelectedUser() { return selectedUser; }
    public void setSelectedUser(User selectedUser) { this.selectedUser = selectedUser; }
}

