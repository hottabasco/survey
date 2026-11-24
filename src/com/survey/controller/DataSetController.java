package com.survey.controller;

import com.survey.model.DataSet;
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
public class DataSetController implements Serializable {
    private static final long serialVersionUID = 1L;

    @Inject
    private DatabaseService dbService;

    @Inject
    private LoginController loginController;

    private List<DataSet> dataSets;
    private DataSet selectedDataSet;

    @PostConstruct
    public void init() {
        prepareNewDataSet();
        loadDataSets();
    }

    public void loadDataSets() {
        this.dataSets = dbService.findAllDataSets();
    }

    public void prepareNewDataSet() {
        this.selectedDataSet = new DataSet();
        this.selectedDataSet.setStartDate(LocalDate.now());
    }

    public void saveDataSet() {
        if (!loginController.isCanEdit()) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Access Denied", "You do not have permission to modify data sets."));
            return;
        }
        try {
            dbService.saveDataSet(selectedDataSet);
            loadDataSets();
            prepareNewDataSet();
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Saved", "Data set saved successfully."));
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", e.getMessage()));
        }
    }

    public List<DataSet> getDataSets() { return dataSets; }
    public DataSet getSelectedDataSet() { return selectedDataSet; }
    public void setSelectedDataSet(DataSet selectedDataSet) { this.selectedDataSet = selectedDataSet; }
}

