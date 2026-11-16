package com.survey.service;

import com.survey.model.SurveyReport;
import java.io.Serializable;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@jakarta.enterprise.context.ApplicationScoped
public class DatabaseService implements Serializable {
    private static final long serialVersionUID = 1L;

    private static final String URL = "jdbc:postgresql://127.0.0.1:5432/NTM";
    private static final String USER = "postgres";
    private static final String PWD = "pwd1";

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

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PWD);
    }

    public List<SurveyReport> findAll() {
        List<SurveyReport> list = new ArrayList<>();
        String sql = "SELECT item_id, \"Type\", \"Element Type\", \"Location\", \"Description\", \"Maintenance Required\", \"Priority\", \"Tranche\", \"Notes\" FROM public.survey_report ORDER BY item_id ASC";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
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
        } catch (SQLException e) {
            java.util.logging.Logger.getLogger(DatabaseService.class.getName()).log(java.util.logging.Level.SEVERE, "JDBC Error", e);
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
            java.util.logging.Logger.getLogger(DatabaseService.class.getName()).log(java.util.logging.Level.SEVERE, "JDBC Error", e);
        }
    }
}

