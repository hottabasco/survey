package com.survey.service;

import com.survey.model.SurveyReport;
import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.ApplicationScoped;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

@ApplicationScoped
public class DatabaseService implements Serializable {
    private static final long serialVersionUID = 1L;

    private String dbUrl;
    private String dbUser;
    private String dbPassword;

    // Automatically inherits settings from the "com.survey" parent logger
    private static final Logger logger = Logger.getLogger(DatabaseService.class.getName());

    static {
        try {
            Class.forName("org.postgresql.Driver");
            logger.log(Level.INFO, "JDBC driver loaded");
        } catch (ClassNotFoundException e) {
            logger.log(Level.SEVERE, "Error loading JDBC driver", e);
        }
    }

    @PostConstruct
    public void init() {
        Properties props = new Properties();
        try (InputStream input = Thread.currentThread().getContextClassLoader().getResourceAsStream("survey.properties")) {
            if (input == null) {
                logger.log(Level.SEVERE, "Unable to find survey.properties on the classpath");
                throw new IllegalStateException("Missing survey.properties on classpath");
            }
            props.load(input);
            this.dbUrl = props.getProperty("db.url");
            this.dbUser = props.getProperty("db.user");
            this.dbPassword = props.getProperty("db.password");
            logger.log(Level.INFO, "Database configuration loaded from survey.properties");
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Error reading survey.properties", e);
            throw new IllegalStateException("Failed to load survey.properties", e);
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    }

    public List<SurveyReport> findAll() {
        return findByTranche(null);
    }

    public List<SurveyReport> findByTranche(String tranche) {
        List<SurveyReport> list = new ArrayList<>();
        boolean hasFilter = (tranche != null && !tranche.trim().isEmpty());

        String sql = "SELECT item_id, \"Type\", \"Element Type\", \"Location\", \"Description\", \"Maintenance Required\", \"Priority\", \"Tranche\", \"Notes\" "
                   + "FROM public.survey_report "
                   + (hasFilter ? "WHERE \"Tranche\" = ? " : "")
                   + "ORDER BY item_id ASC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (hasFilter) {
                ps.setString(1, tranche.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SurveyReport r = new SurveyReport();
                    r.setItemId(rs.getBigDecimal("item_id"));
                    r.setType(rs.getString(2));
                    r.setElementType(rs.getString(3));
                    r.setLocation(rs.getString(4));
                    r.setDescription(rs.getString(5));
                    r.setMaintenanceRequired(rs.getString(6));
                    r.setPriority(rs.getObject(7) != null ? rs.getBoolean(7) : null);
                    r.setTranche(rs.getString(8));
                    r.setNotes(rs.getString(9));
                    list.add(r);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "JDBC Error", e);
        }
        return list;
    }

    public void save(SurveyReport r) {
        String sql = "INSERT INTO public.survey_report (item_id, \"Type\", \"Element Type\", \"Location\", \"Description\", \"Maintenance Required\", \"Priority\", \"Tranche\", \"Notes\") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) "
                   + "ON CONFLICT (item_id) DO UPDATE SET \"Type\" = ?, \"Element Type\" = ?, \"Location\" = ?, \"Description\" = ?, \"Maintenance Required\" = ?, \"Priority\" = ?, \"Tranche\" = ?, \"Notes\" = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBigDecimal(1, r.getItemId());
            ps.setString(2, r.getType());
            ps.setString(3, r.getElementType());
            ps.setString(4, r.getLocation());
            ps.setString(5, r.getDescription());
            ps.setString(6, r.getMaintenanceRequired());
            if (r.getPriority() != null) ps.setBoolean(7, r.getPriority()); else ps.setNull(7, Types.BOOLEAN);
            ps.setString(8, r.getTranche());
            ps.setString(9, r.getNotes());

            ps.setString(10, r.getType());
            ps.setString(11, r.getElementType());
            ps.setString(12, r.getLocation());
            ps.setString(13, r.getDescription());
            ps.setString(14, r.getMaintenanceRequired());
            if (r.getPriority() != null) ps.setBoolean(15, r.getPriority()); else ps.setNull(15, Types.BOOLEAN);
            ps.setString(16, r.getTranche());
            ps.setString(17, r.getNotes());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "JDBC Error", e);
        }
    }
}

