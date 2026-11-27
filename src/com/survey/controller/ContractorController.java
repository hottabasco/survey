package com.survey.controller;

import com.survey.model.Contractor;
import com.survey.service.DatabaseService;
import jakarta.annotation.PostConstruct;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.FacesContext;
import jakarta.faces.view.ViewScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Named
@ViewScoped
public class ContractorController implements Serializable {
    private static final long serialVersionUID = 1L;

    @Inject
    private DatabaseService dbService;

    @Inject
    private LoginController loginController;

    private List<Contractor> contractors;
    private Contractor selectedContractor;

    @PostConstruct
    public void init() {
        prepareNewContractor();
        loadContractors();
    }

    public void loadContractors() {
        this.contractors = dbService.findAllContractors();
    }

    public void prepareNewContractor() {
        this.selectedContractor = new Contractor();
        this.selectedContractor.setStartDate(LocalDate.now());
    }

    public void saveContractor() {
        if (!loginController.isCanEdit()) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Access Denied", "You do not have permission to modify contractors."));
            return;
        }
        try {
            dbService.saveContractor(selectedContractor);
            loadContractors();
            prepareNewContractor();
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Saved", "Contractor saved successfully."));
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", e.getMessage()));
        }
    }

    public void deleteContractor() {
        if (!loginController.isCanEdit()) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Access Denied", "You do not have permission to delete contractors."));
            return;
        }
        if (selectedContractor == null || selectedContractor.getContractorId() == null) {
            return;
        }
        try {
            dbService.deleteContractor(selectedContractor.getContractorId());
            loadContractors();
            prepareNewContractor();
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Deleted", "Contractor removed successfully."));
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Delete Failed", "Cannot delete contractor (may be referenced by other records): " + e.getMessage()));
        }
    }

    public List<Contractor> getContractors() {
        return contractors;
    }

    public Contractor getSelectedContractor() {
        return selectedContractor;
    }

    public void setSelectedContractor(Contractor selectedContractor) {
        this.selectedContractor = selectedContractor;
    }
}

