package com.survey.controller;

import com.survey.model.SurveyReport;
import com.survey.service.DatabaseService;
import jakarta.enterprise.context.RequestScoped;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.FacesContext;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.primefaces.model.file.UploadedFile;

@Named
@RequestScoped
public class ImportController {

    private static final Logger logger = Logger.getLogger(ImportController.class.getName());

    @Inject
    private DatabaseService dbService;

    @Inject
    private LoginController loginController;

    private UploadedFile csvFile;
    private String dataSetName;
    private String dataSetDescription;

    public void uploadAndImport() {
        if (!loginController.isCanEdit()) {
            addMsg(FacesMessage.SEVERITY_ERROR, "Access Denied", "You do not have permission to import data.");
            return;
        }

        if (csvFile == null || csvFile.getSize() == 0) {
            addMsg(FacesMessage.SEVERITY_ERROR, "File Error", "Please select a valid, non-empty CSV file.");
            return;
        }

        List<SurveyReport> parsedRecords = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(csvFile.getInputStream(), StandardCharsets.UTF_8))) {

            String line;
            int lineNum = 0;

            while ((line = reader.readLine()) != null) {
                lineNum++;
                if (line.trim().isEmpty()) {
                    continue;
                }

                List<String> cols = parseCsvLine(line);

                // Skip header row if first column is not a valid number
                if (lineNum == 1 && !isNumeric(cols.get(0))) {
                    continue;
                }

                if (cols.size() < 7) {
                    throw new IllegalArgumentException("Line " + lineNum + " has fewer than 7 columns.");
                }

                // Inside ImportController.java -> uploadAndImport():
                SurveyReport r = new SurveyReport();
                r.setItemId(new BigDecimal(cols.get(0).trim()));
                r.setType(emptyToNull(cols.get(1)));
                r.setElementType(requireNonEmpty(cols.get(2), "Element Type", lineNum));
                r.setLocation(requireNonEmpty(cols.get(3), "Location", lineNum));
                r.setDescription(requireNonEmpty(cols.get(4), "Description", lineNum));
                r.setMaintenanceRequired(requireNonEmpty(cols.get(5), "Maintenance Required", lineNum));
                r.setPriority(parseBoolean(cols.get(6)));
                r.setTranche(cols.size() > 7 ? emptyToNull(cols.get(7)) : null);
                r.setNotes(cols.size() > 8 ? emptyToNull(cols.get(8)) : null);

                parsedRecords.add(r);
            }

            if (parsedRecords.isEmpty()) {
                addMsg(FacesMessage.SEVERITY_ERROR, "Import Abandoned", "The CSV file contained no data rows.");
                return;
            }

            int newDataSetId = dbService.importSurveyDataSet(dataSetName, dataSetDescription, parsedRecords);
            addMsg(FacesMessage.SEVERITY_INFO, "Import Complete",
                   "Loaded " + parsedRecords.size() + " records into Data Set '" + dataSetName + "' (ID: " + newDataSetId + ").");

            // Reset form fields
            this.dataSetName = null;
            this.dataSetDescription = null;

        } catch (Exception e) {
            logger.log(Level.SEVERE, "CSV Import failed", e);
            addMsg(FacesMessage.SEVERITY_ERROR, "Import Abandoned", "Unable to read or load CSV: " + e.getMessage());
        }
    }

    private List<String> parseCsvLine(String line) {
        List<String> result = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        boolean inQuotes = false;

        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            if (c == '"') {
                if (inQuotes && i + 1 < line.length() && line.charAt(i + 1) == '"') {
                    current.append('"');
                    i++;
                } else {
                    inQuotes = !inQuotes;
                }
            } else if (c == ',' && !inQuotes) {
                result.add(current.toString());
                current.setLength(0);
            } else {
                current.append(c);
            }
        }
        result.add(current.toString());
        return result;
    }

    private boolean isNumeric(String str) {
        if (str == null || str.trim().isEmpty()) return false;
        try {
            new BigDecimal(str.trim());
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private String emptyToNull(String s) {
        return (s == null || s.trim().isEmpty()) ? null : s.trim();
    }

    private String requireNonEmpty(String s, String fieldName, int lineNum) {
        if (s == null || s.trim().isEmpty()) {
            throw new IllegalArgumentException("Line " + lineNum + ": '" + fieldName + "' is required.");
        }
        return s.trim();
    }

    private Boolean parseBoolean(String s) {
        if (s == null || s.trim().isEmpty()) return null;
        String val = s.trim().toLowerCase();
        return "true".equals(val) || "yes".equals(val) || "1".equals(val) || "t".equals(val);
    }

    private void addMsg(FacesMessage.Severity severity, String summary, String detail) {
        FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(severity, summary, detail));
    }

    // Getters & Setters
    public UploadedFile getCsvFile() { return csvFile; }
    public void setCsvFile(UploadedFile csvFile) { this.csvFile = csvFile; }

    public String getDataSetName() { return dataSetName; }
    public void setDataSetName(String dataSetName) { this.dataSetName = dataSetName; }

    public String getDataSetDescription() { return dataSetDescription; }
    public void setDataSetDescription(String dataSetDescription) { this.dataSetDescription = dataSetDescription; }
}

