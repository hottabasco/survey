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
import com.survey.model.User;
import org.mindrot.jbcrypt.BCrypt; // From jbcrypt-0.4.j
import java.time.LocalDate;
import com.survey.model.DataSet;

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
			if(input == null) {
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

	public List < SurveyReport > findAll() {
		return findByTranche(null);
	}

	public List < SurveyReport > findByTranche(String tranche) {
		List < SurveyReport > list = new ArrayList < > ();
		boolean hasFilter = (tranche != null && !tranche.trim().isEmpty());
		String sql = "SELECT item_id, \"Type\", \"Element Type\", \"Location\", \"Description\", \"Maintenance Required\", \"Priority\", \"Tranche\", \"Notes\" " + "FROM public.survey_report " + (hasFilter ? "WHERE \"Tranche\" = ? " : "") + "ORDER BY item_id ASC";
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			if(hasFilter) {
				ps.setString(1, tranche.trim());
			}
			try (ResultSet rs = ps.executeQuery()) {
				while(rs.next()) {
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

	public List<DataSet> findActiveDataSets() {
		List<DataSet> list = new ArrayList<>();
		String sql = "SELECT data_set_id, data_set_name, data_set_description, start_date, end_date " +
					 "FROM public.data_set " +
					 "WHERE start_date <= CURRENT_DATE " +
					 "AND (end_date IS NULL OR end_date >= CURRENT_DATE) " +
					 "ORDER BY data_set_id DESC";
		try (Connection conn = getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				DataSet ds = new DataSet();
				ds.setDataSetId(rs.getInt("data_set_id"));
				ds.setDataSetName(rs.getString("data_set_name"));
				ds.setDataSetDescription(rs.getString("data_set_description"));
				Date sd = rs.getDate("start_date");
				ds.setStartDate(sd != null ? sd.toLocalDate() : null);
				Date ed = rs.getDate("end_date");
				ds.setEndDate(ed != null ? ed.toLocalDate() : null);
				list.add(ds);
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "JDBC Error fetching active data sets", e);
		}
		return list;
	}

	public List<SurveyReport> findFiltered(Integer dataSetId, String tranche) {
		List<SurveyReport> list = new ArrayList<>();
		boolean hasDataSet = (dataSetId != null);
		boolean hasTranche = (tranche != null && !tranche.trim().isEmpty());

		StringBuilder sql = new StringBuilder(
			"SELECT sr.item_id, sr.\"Type\", sr.\"Element Type\", sr.\"Location\", sr.\"Description\", " +
			"sr.\"Maintenance Required\", sr.\"Priority\", sr.\"Tranche\", sr.\"Notes\", sr.data_set_id, " +
			"ds.data_set_name, ds.data_set_description " +
			"FROM public.survey_report sr " +
			"LEFT JOIN public.data_set ds ON sr.data_set_id = ds.data_set_id " +
			"WHERE 1=1 "
		);

		if (hasDataSet) {
			sql.append("AND sr.data_set_id = ? ");
		}
		if (hasTranche) {
			sql.append("AND sr.\"Tranche\" = ? ");
		}
		sql.append("ORDER BY sr.data_set_id DESC, sr.item_id ASC");

		try (Connection conn = getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql.toString())) {

			int paramIdx = 1;
			if (hasDataSet) {
				ps.setInt(paramIdx++, dataSetId);
			}
			if (hasTranche) {
				ps.setString(paramIdx++, tranche.trim());
			}

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					SurveyReport r = new SurveyReport();
					r.setItemId(rs.getBigDecimal(1));
					r.setType(rs.getString(2));
					r.setElementType(rs.getString(3));
					r.setLocation(rs.getString(4));
					r.setDescription(rs.getString(5));
					r.setMaintenanceRequired(rs.getString(6));
					r.setPriority(rs.getObject(7) != null ? rs.getBoolean(7) : null);
					r.setTranche(rs.getString(8));
					r.setNotes(rs.getString(9));
					r.setDataSetId(rs.getInt(10));
					r.setDataSetName(rs.getString(11));
					r.setDataSetDescription(rs.getString(12));
					list.add(r);
				}
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "JDBC Error fetching filtered survey reports", e);
		}
		return list;
	}

	public List<DataSet> findAllDataSets() {
		List<DataSet> list = new ArrayList<>();
		String sql = "SELECT data_set_id, data_set_name, data_set_description, start_date, end_date " +
					 "FROM public.data_set ORDER BY data_set_id DESC";
		try (Connection conn = getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				DataSet ds = new DataSet();
				ds.setDataSetId(rs.getInt("data_set_id"));
				ds.setDataSetName(rs.getString("data_set_name"));
				ds.setDataSetDescription(rs.getString("data_set_description"));
				Date sd = rs.getDate("start_date");
				ds.setStartDate(sd != null ? sd.toLocalDate() : null);
				Date ed = rs.getDate("end_date");
				ds.setEndDate(ed != null ? ed.toLocalDate() : null);
				list.add(ds);
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Error fetching all data sets", e);
		}
		return list;
	}

	public void saveDataSet(DataSet ds) throws SQLException {
		if (ds.getDataSetId() == null) {
			String sql = "INSERT INTO public.data_set (data_set_name, data_set_description, start_date, end_date) " +
						 "VALUES (?, ?, ?, ?)";
			try (Connection conn = getConnection();
				 PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setString(1, ds.getDataSetName().trim());
				ps.setString(2, ds.getDataSetDescription().trim());
				ps.setDate(3, ds.getStartDate() != null ? Date.valueOf(ds.getStartDate()) : Date.valueOf(LocalDate.now()));
				if (ds.getEndDate() != null) ps.setDate(4, Date.valueOf(ds.getEndDate()));
				else ps.setNull(4, Types.DATE);
				ps.executeUpdate();
			}
		} else {
			String sql = "UPDATE public.data_set " +
						 "SET data_set_name = ?, data_set_description = ?, start_date = ?, end_date = ? " +
						 "WHERE data_set_id = ?";
			try (Connection conn = getConnection();
				 PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setString(1, ds.getDataSetName().trim());
				ps.setString(2, ds.getDataSetDescription().trim());
				ps.setDate(3, ds.getStartDate() != null ? Date.valueOf(ds.getStartDate()) : Date.valueOf(LocalDate.now()));
				if (ds.getEndDate() != null) ps.setDate(4, Date.valueOf(ds.getEndDate()));
				else ps.setNull(4, Types.DATE);
				ps.setInt(5, ds.getDataSetId());
				ps.executeUpdate();
			}
		}
	}

        public void save(SurveyReport r) {
            String sql = "INSERT INTO public.survey_report " +
                         "(data_set_id, item_id, \"Type\", \"Element Type\", \"Location\", \"Description\", \"Maintenance Required\", \"Priority\", \"Tranche\", \"Notes\") " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                         "ON CONFLICT (data_set_id, item_id) DO UPDATE SET " +
                         "\"Type\" = ?, \"Element Type\" = ?, \"Location\" = ?, \"Description\" = ?, \"Maintenance Required\" = ?, \"Priority\" = ?, \"Tranche\" = ?, \"Notes\" = ?";
        
            int dsId = (r.getDataSetId() != null) ? r.getDataSetId() : 1;
        
            try (Connection conn = getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
        
                // INSERT values
                ps.setInt(1, dsId);
                ps.setBigDecimal(2, r.getItemId());
                ps.setString(3, r.getType());
                ps.setString(4, r.getElementType());
                ps.setString(5, r.getLocation());
                ps.setString(6, r.getDescription());
                ps.setString(7, r.getMaintenanceRequired());
                if (r.getPriority() != null) ps.setBoolean(8, r.getPriority()); else ps.setNull(8, Types.BOOLEAN);
                ps.setString(9, r.getTranche());
                ps.setString(10, r.getNotes());
        
                // ON CONFLICT DO UPDATE values
                ps.setString(11, r.getType());
                ps.setString(12, r.getElementType());
                ps.setString(13, r.getLocation());
                ps.setString(14, r.getDescription());
                ps.setString(15, r.getMaintenanceRequired());
                if (r.getPriority() != null) ps.setBoolean(16, r.getPriority()); else ps.setNull(16, Types.BOOLEAN);
                ps.setString(17, r.getTranche());
                ps.setString(18, r.getNotes());
        
                ps.executeUpdate();
            } catch (SQLException e) {
                logger.log(Level.SEVERE, "JDBC Error", e);
            }
        }

	public User authenticate(String accountName, String plainPassword) {
		if(accountName == null || plainPassword == null) {
			return null;
		}
		String sql = "SELECT usr_id, account_name, first_name, last_name, role, password " + "FROM public.usr " + "WHERE account_name = ? " + "AND start_date <= CURRENT_DATE " + "AND (end_date IS NULL OR end_date >= CURRENT_DATE)";
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, accountName.trim());
			try (ResultSet rs = ps.executeQuery()) {
				if(rs.next()) {
					String storedHash = rs.getString("password");
					// Verify the password against the BCrypt hash
					if(storedHash != null && BCrypt.checkpw(plainPassword, storedHash)) {
						User user = new User();
						user.setUsrId(rs.getBigDecimal("usr_id"));
						user.setAccountName(rs.getString("account_name"));
						user.setFirstName(rs.getString("first_name"));
						user.setLastName(rs.getString("last_name"));
						user.setRole(rs.getString("role"));
						return user;
					}
				}
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Authentication JDBC Error", e);
		}
		return null;
	}

	public List < User > findAllUsers() {
		List < User > list = new ArrayList < > ();
		String sql = "SELECT usr_id, account_name, first_name, last_name, role, start_date, end_date " +
			"FROM public.usr ORDER BY usr_id ASC";

		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

			while(rs.next()) {
				User u = new User();
				u.setUsrId(rs.getBigDecimal("usr_id"));
				u.setAccountName(rs.getString("account_name"));
				u.setFirstName(rs.getString("first_name"));
				u.setLastName(rs.getString("last_name"));
				u.setRole(rs.getString("role"));
				Date sd = rs.getDate("start_date");
				u.setStartDate(sd != null ? sd.toLocalDate() : null);
				Date ed = rs.getDate("end_date");
				u.setEndDate(ed != null ? ed.toLocalDate() : null);
				list.add(u);
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Error fetching users", e);
		}
		return list;
	}

	public void saveUser(User u) throws SQLException {
		boolean hasNewPassword = (u.getPlainPassword() != null && !u.getPlainPassword().trim().isEmpty());

		if(hasNewPassword) {
			String hashed = BCrypt.hashpw(u.getPlainPassword().trim(), BCrypt.gensalt());
			String sql = "INSERT INTO public.usr (usr_id, account_name, first_name, last_name, role, password, start_date, end_date) " +
				"VALUES (?, ?, ?, ?, ?, ?, ?, ?) " +
				"ON CONFLICT (usr_id) DO UPDATE SET " +
				"account_name = ?, first_name = ?, last_name = ?, role = ?, password = ?, start_date = ?, end_date = ?";

			try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setBigDecimal(1, u.getUsrId());
				ps.setString(2, u.getAccountName().trim());
				ps.setString(3, u.getFirstName().trim());
				ps.setString(4, u.getLastName().trim());
				ps.setString(5, u.getRole());
				ps.setString(6, hashed);
				ps.setDate(7, u.getStartDate() != null ? Date.valueOf(u.getStartDate()) : Date.valueOf(LocalDate.now()));
				if(u.getEndDate() != null) ps.setDate(8, Date.valueOf(u.getEndDate()));
				else ps.setNull(8, Types.DATE);

				ps.setString(9, u.getAccountName().trim());
				ps.setString(10, u.getFirstName().trim());
				ps.setString(11, u.getLastName().trim());
				ps.setString(12, u.getRole());
				ps.setString(13, hashed);
				ps.setDate(14, u.getStartDate() != null ? Date.valueOf(u.getStartDate()) : Date.valueOf(LocalDate.now()));
				if(u.getEndDate() != null) ps.setDate(15, Date.valueOf(u.getEndDate()));
				else ps.setNull(15, Types.DATE);

				ps.executeUpdate();
			}
		} else {
			// Update existing user without overwriting password
			String sql = "UPDATE public.usr SET account_name = ?, first_name = ?, last_name = ?, role = ?, start_date = ?, end_date = ? " +
				"WHERE usr_id = ?";
			try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setString(1, u.getAccountName().trim());
				ps.setString(2, u.getFirstName().trim());
				ps.setString(3, u.getLastName().trim());
				ps.setString(4, u.getRole());
				ps.setDate(5, u.getStartDate() != null ? Date.valueOf(u.getStartDate()) : Date.valueOf(LocalDate.now()));
				if(u.getEndDate() != null) ps.setDate(6, Date.valueOf(u.getEndDate()));
				else ps.setNull(6, Types.DATE);
				ps.setBigDecimal(7, u.getUsrId());

				int updated = ps.executeUpdate();
				if(updated == 0) {
					throw new SQLException("Password is required when creating a new user.");
				}
			}
		}
	}

	public int importSurveyDataSet(String dataSetName, String dataSetDescription, List < SurveyReport > records) throws SQLException {
		String insertDataSetSql = "INSERT INTO public.data_set (data_set_name, data_set_description) VALUES (?, ?)";
                String insertReportSql = "INSERT INTO public.survey_report " +
                        "(item_id, \"Type\", \"Element Type\", \"Location\", \"Description\", \"Maintenance Required\", \"Priority\", \"Tranche\", \"Notes\", data_set_id) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Connection conn = null;
		try {
			conn = getConnection();
			conn.setAutoCommit(false);

			int generatedDataSetId;
			try (PreparedStatement psDs = conn.prepareStatement(insertDataSetSql, Statement.RETURN_GENERATED_KEYS)) {
				psDs.setString(1, dataSetName.trim());
				psDs.setString(2, dataSetDescription.trim());
				psDs.executeUpdate();

				try (ResultSet keys = psDs.getGeneratedKeys()) {
					if(keys.next()) {
						generatedDataSetId = keys.getInt(1);
					} else {
						throw new SQLException("Failed to retrieve generated data_set_id.");
					}
				}
			}

			try (PreparedStatement psRep = conn.prepareStatement(insertReportSql)) {
				for(SurveyReport r: records) {
					psRep.setBigDecimal(1, r.getItemId());
					psRep.setString(2, r.getType());
					psRep.setString(3, r.getElementType());
					psRep.setString(4, r.getLocation());
					psRep.setString(5, r.getDescription());
					psRep.setString(6, r.getMaintenanceRequired());
					if(r.getPriority() != null) {
						psRep.setBoolean(7, r.getPriority());
					} else {
						psRep.setNull(7, Types.BOOLEAN);
					}
					psRep.setString(8, r.getTranche());
					psRep.setString(9, r.getNotes());
					psRep.setInt(10, generatedDataSetId);
					psRep.addBatch();
				}
				psRep.executeBatch();
			}

			conn.commit();
			return generatedDataSetId;

		} catch (SQLException e) {
			if(conn != null) {
				try {
					conn.rollback();
				} catch (SQLException rollbackEx) {
					logger.log(Level.SEVERE, "Rollback failed", rollbackEx);
				}
			}
			throw e;
		} finally {
			if(conn != null) {
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (SQLException closeEx) {
					logger.log(Level.WARNING, "Failed to close connection", closeEx);
				}
			}
		}
	}

}
