package com.survey.controller;

import com.survey.model.SurveyReport;
import com.survey.service.DatabaseService;
import jakarta.annotation.PostConstruct;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.FacesContext;
import jakarta.faces.view.ViewScoped;
import jakarta.inject.Named;
import java.io.Serializable;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@Named("surveyController")
@ViewScoped
public class SurveyController implements Serializable {
    private static final long serialVersionUID = 1L;

    @jakarta.inject.Inject
    private DatabaseService dbService;
    private List<SurveyReport> reports;
    private SurveyReport selectedReport;
    private String trancheFilter;

    // Automatically inherits settings from the "com.survey" parent logger
    private static final Logger logger = Logger.getLogger(SurveyController.class.getName());

    @PostConstruct
    public void init() {
        logger.log(Level.INFO, "SurveyController init");
        loadReports();
        prepareNewReport();
    }

    public void loadReports() {
        reports = dbService.findByTranche(trancheFilter);
    }

    public void clearFilter() {
        this.trancheFilter = null;
        loadReports();
    }

    public void prepareNewReport() {
        selectedReport = new SurveyReport();
    }

    public void saveReport() {
        if (selectedReport.getItemId() == null) {
            FacesContext.getCurrentInstance().addMessage(null, 
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", "Item ID is required."));
            return;
        }
        dbService.save(selectedReport);
        loadReports();
        prepareNewReport();
        FacesContext.getCurrentInstance().addMessage(null, 
            new FacesMessage(FacesMessage.SEVERITY_INFO, "Success", "Survey Report Processed cleanly."));
    }

    public List<SurveyReport> getReports() { return reports; }
    public SurveyReport getSelectedReport() { return selectedReport; }
    public void setSelectedReport(SurveyReport selectedReport) { this.selectedReport = selectedReport; }
    public String getTrancheFilter() { return trancheFilter; }
    public void setTrancheFilter(String trancheFilter) { this.trancheFilter = trancheFilter; }
}

