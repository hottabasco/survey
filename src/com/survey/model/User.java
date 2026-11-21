package com.survey.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private BigDecimal usrId;
    private String accountName;
    private String firstName;
    private String lastName;
    private String role;
    private LocalDate startDate = LocalDate.now();
    private LocalDate endDate;
    private String plainPassword; // Transient form input; never loaded from DB

    // Existing Getters & Setters...
    public BigDecimal getUsrId() { return usrId; }
    public void setUsrId(BigDecimal usrId) { this.usrId = usrId; }

    public String getAccountName() { return accountName; }
    public void setAccountName(String accountName) { this.accountName = accountName; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    // New Getters & Setters
    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

    public String getPlainPassword() { return plainPassword; }
    public void setPlainPassword(String plainPassword) { this.plainPassword = plainPassword; }
}

