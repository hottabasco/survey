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

@Named("surveyController")
@ViewScoped
public class SurveyController implements Serializable {
    private static final long serialVersionUID = 1L;

    @jakarta.inject.Inject
    private DatabaseService dbService;
    private List<SurveyReport> reports;
    private SurveyReport selectedReport;

    @PostConstruct
    public void init() {
        loadReports();
        prepareNewReport();
    }

    public void loadReports() {
        reports = dbService.findAll();
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
}

