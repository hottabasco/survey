package com.survey.controller;

import com.survey.model.DataSet;
import com.survey.model.SurveyReport;
import com.survey.service.DatabaseService;
import jakarta.annotation.PostConstruct;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.FacesContext;
import jakarta.faces.view.ViewScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import java.io.Serializable;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.primefaces.PrimeFaces;

@Named("surveyController")
@ViewScoped
public class SurveyController implements Serializable {
    private static final long serialVersionUID = 1L;

    @Inject
    private DatabaseService dbService;

    @Inject
    private LoginController loginController;

    private List<SurveyReport> reports;
    private SurveyReport selectedReport;
    private String trancheFilter;
    private List<DataSet> dataSets;
    private Integer selectedDataSetId;

    // Automatically inherits settings from the "com.survey" parent logger
    private static final Logger logger = Logger.getLogger(SurveyController.class.getName());

    // Getters and Setters
    public List<SurveyReport> getReports() {
        return reports;
    }

    public SurveyReport getSelectedReport() {
        return selectedReport;
    }

    public void setSelectedReport(SurveyReport selectedReport) {
        this.selectedReport = selectedReport;
    }

    public String getTrancheFilter() {
        return trancheFilter;
    }

    public void setTrancheFilter(String trancheFilter) {
        this.trancheFilter = trancheFilter;
    }

    public List<DataSet> getDataSets() {
        return dataSets;
    }

    public Integer getSelectedDataSetId() {
        return selectedDataSetId;
    }

    public void setSelectedDataSetId(Integer selectedDataSetId) {
        this.selectedDataSetId = selectedDataSetId;
    }

    @PostConstruct
    public void init() {
        logger.log(Level.INFO, "SurveyController init");
        this.dataSets = dbService.findActiveDataSets();
        loadReports();
        prepareNewReport();
    }

    public void loadReports() {
        reports = dbService.findFiltered(selectedDataSetId, trancheFilter);
    }

    public void clearFilter() {
        this.selectedDataSetId = null;
        this.trancheFilter = null;
        loadReports();
    }

    public void prepareNewReport() {
        selectedReport = new SurveyReport();
        if (this.selectedDataSetId != null) {
            selectedReport.setDataSetId(this.selectedDataSetId);
        }
    }

    public void saveReport() {
        if (!loginController.isCanEdit()) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Access Denied", "You do not have permission to modify survey records."));
            return;
        }
        if (selectedReport.getItemId() == null) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", "Item ID is required."));
            return;
        }

        if (selectedReport.getDataSetId() == null && selectedDataSetId != null) {
            selectedReport.setDataSetId(selectedDataSetId);
        }

        dbService.save(selectedReport);
        loadReports();
        prepareNewReport();
        FacesContext.getCurrentInstance().addMessage(null,
            new FacesMessage(FacesMessage.SEVERITY_INFO, "Success", "Survey Report Processed cleanly."));
    }

    public void copyTableToClipboard() {
        if (reports == null || reports.isEmpty()) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_WARN, "Nothing to Copy", "There are no survey records to copy."));
            return;
        }

        StringBuilder html = new StringBuilder();
        StringBuilder tsv = new StringBuilder();

        html.append("<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\" style=\"border-collapse: collapse; font-family: sans-serif; font-size: 10pt;\">")
            .append("<thead><tr style=\"background-color: #f0f0f0; font-weight: bold;\">")
            .append("<th>Item ID</th><th>Type</th><th>Element Type</th><th>Location</th>")
            .append("<th>Description</th><th>Maintenance Required</th><th>Priority</th><th>Tranche</th><th>Notes</th>")
            .append("</tr></thead><tbody>");

        tsv.append("Item ID\tType\tElement Type\tLocation\tDescription\tMaintenance Required\tPriority\tTranche\tNotes\n");

        for (SurveyReport r : reports) {
            String itemId = r.getItemId() != null ? r.getItemId().toPlainString() : "";
            String type = safeStr(r.getType());
            String elemType = safeStr(r.getElementType());
            String location = safeStr(r.getLocation());
            String desc = safeStr(r.getDescription());
            String maint = safeStr(r.getMaintenanceRequired());
            String priority = Boolean.TRUE.equals(r.getPriority()) ? "YES" : "NO";
            String tranche = safeStr(r.getTranche());
            String notes = safeStr(r.getNotes());

            html.append("<tr>")
                .append("<td>").append(escapeHtml(itemId)).append("</td>")
                .append("<td>").append(escapeHtml(type)).append("</td>")
                .append("<td>").append(escapeHtml(elemType)).append("</td>")
                .append("<td>").append(escapeHtml(location)).append("</td>")
                .append("<td>").append(escapeHtml(desc)).append("</td>")
                .append("<td>").append(escapeHtml(maint)).append("</td>")
                .append("<td>").append(priority).append("</td>")
                .append("<td>").append(escapeHtml(tranche)).append("</td>")
                .append("<td>").append(escapeHtml(notes)).append("</td>")
                .append("</tr>");

            tsv.append(cleanTsv(itemId)).append('\t')
                .append(cleanTsv(type)).append('\t')
                .append(cleanTsv(elemType)).append('\t')
                .append(cleanTsv(location)).append('\t')
                .append(cleanTsv(desc)).append('\t')
                .append(cleanTsv(maint)).append('\t')
                .append(priority).append('\t')
                .append(cleanTsv(tranche)).append('\t')
                .append(cleanTsv(notes)).append('\n');
        }

        html.append("</tbody></table>");

        PrimeFaces.current().ajax().addCallbackParam("clipboardHtml", html.toString());
        PrimeFaces.current().ajax().addCallbackParam("clipboardText", tsv.toString());
        PrimeFaces.current().ajax().addCallbackParam("rowCount", reports.size());
    }

    private String safeStr(String s) {
        return s != null ? s : "";
    }

    private String cleanTsv(String s) {
        return s.replace("\t", " ").replace("\r", " ").replace("\n", " ");
    }

    private String escapeHtml(String s) {
        return s.replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;");
    }
}

