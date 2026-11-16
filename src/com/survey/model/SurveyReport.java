package com.survey.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SurveyReport implements Serializable {
    private static final long serialVersionUID = 1L;

    // Automatically inherits settings from the "com.survey" parent logger
    private static final Logger logger = Logger.getLogger(SurveyReport.class.getName());

    private BigDecimal itemId;
    private String type;
    private String elementType;
    private String location;
    private String description;
    private String maintenanceRequired;
    private Boolean priority;
    private String tranche;
    private String notes;

    public SurveyReport() 
    {
        logger.log(Level.INFO, "entering SurveyReport");
    }

    public BigDecimal getItemId() { return itemId; }
    public void setItemId(BigDecimal itemId) { this.itemId = itemId; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getElementType() { return elementType; }
    public void setElementType(String elementType) { this.elementType = elementType; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getMaintenanceRequired() { return maintenanceRequired; }
    public void setMaintenanceRequired(String maintenanceRequired) { this.maintenanceRequired = maintenanceRequired; }

    public Boolean getPriority() { return priority; }
    public void setPriority(Boolean priority) { this.priority = priority; }

    public String getTranche() { return tranche; }
    public void setTranche(String tranche) { this.tranche = tranche; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}

