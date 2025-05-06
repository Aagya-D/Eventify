package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VenueDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/";
    private static final String DB_NAME = "eventify";
    private static final String JDBC_FULL_URL = JDBC_URL + DB_NAME + "?useSSL=false&allowPublicKeyRetrieval=true&connectTimeout=5000";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    // Get database connection
    private Connection getConnection() throws SQLException {
        try {
            System.out.println("Attempting connection to: " + JDBC_FULL_URL);
            return DriverManager.getConnection(JDBC_FULL_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (SQLException e) {
            System.err.println("Database connection failed. Error details:");
            System.err.println("Message: " + e.getMessage());
            System.err.println("SQLState: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            
            // Try to connect to just the server without database to see if server is available
            try {
                DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                System.err.println("MySQL server is available but database '" + DB_NAME + "' may not exist");
            } catch (SQLException e2) {
                System.err.println("MySQL server connection failed. Make sure MySQL is running on port 3306");
                System.err.println("Server connection error: " + e2.getMessage());
            }
            
            throw e;
        }
    }

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Create the database if it doesn't exist
            createDatabaseIfNotExists();
            // Create the table if it doesn't exist
            createVenueTableIfNotExists();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Create database if it doesn't exist
    private static void createDatabaseIfNotExists() throws SQLException {
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             Statement stmt = conn.createStatement()) {
            
            stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS " + DB_NAME);
            System.out.println("Database created or already exists: " + DB_NAME);
        }
    }
    
    // Create venue table if it doesn't exist
    private static void createVenueTableIfNotExists() {
        String query = "CREATE TABLE IF NOT EXISTS venue (" +
                      "venue_id INT AUTO_INCREMENT PRIMARY KEY, " +
                      "name VARCHAR(100) NOT NULL, " +
                      "address VARCHAR(200) NOT NULL, " +
                      "zip_code VARCHAR(20) NOT NULL, " +
                      "phone VARCHAR(20) NOT NULL, " +
                      "web VARCHAR(100), " +
                      "email VARCHAR(100) NOT NULL" +
                      ")";
                      
        try (Connection conn = DriverManager.getConnection(JDBC_FULL_URL, JDBC_USER, JDBC_PASSWORD);
             Statement stmt = conn.createStatement()) {
             
            stmt.execute(query);
            System.out.println("Venue table created successfully");
            
            // Check if table is empty and insert sample data if needed
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM venue");
            if (rs.next() && rs.getInt(1) == 0) {
                insertSampleVenues();
            }
        } catch (SQLException e) {
            System.err.println("Error creating venue table: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // Insert sample venues into the database if it's empty
    private static void insertSampleVenues() {
        String query = "INSERT INTO venue (name, address, zip_code, phone, web, email) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DriverManager.getConnection(JDBC_FULL_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            // Sample venues with real data
            insertSampleVenue(ps, "Grand Hall", "123 Main St", "12345", "555-0123", "www.grandhall.com", "info@grandhall.com");
            insertSampleVenue(ps, "City Center", "456 Park Ave", "67890", "555-0124", "www.citycenter.com", "info@citycenter.com");
            insertSampleVenue(ps, "Riverside Plaza", "789 River Rd", "13579", "555-0125", "www.riverside.com", "info@riverside.com");
            insertSampleVenue(ps, "Mountain View", "321 Summit Dr", "24680", "555-0126", "www.mountainview.com", "info@mountainview.com");
            insertSampleVenue(ps, "Ocean Breeze", "654 Beach Blvd", "97531", "555-0127", "www.oceanbreeze.com", "info@oceanbreeze.com");
            
            System.out.println("Sample venues inserted successfully");
        } catch (SQLException e) {
            System.err.println("Error inserting sample venues: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private static void insertSampleVenue(PreparedStatement ps, String name, String address, 
                                       String zipCode, String phone, String web, String email) throws SQLException {
        ps.setString(1, name);
        ps.setString(2, address);
        ps.setString(3, zipCode);
        ps.setString(4, phone);
        ps.setString(5, web);
        ps.setString(6, email);
        
        ps.executeUpdate();
    }

    public VenueDAO() {
        // Constructor
    }

    public List<Venue> getAllVenues() {
        List<Venue> venueList = new ArrayList<>();
        String query = "SELECT * FROM venue";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Venue venue = new Venue(
                    rs.getInt("venue_id"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("zip_code"),
                    rs.getString("phone"),
                    rs.getString("web"),
                    rs.getString("email")
                );
                venueList.add(venue);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving venues: " + e.getMessage());
            e.printStackTrace();
        }
        
        return venueList;
    }

    public Venue getVenueById(int venueId) {
        String query = "SELECT * FROM venue WHERE venue_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, venueId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return new Venue(
                    rs.getInt("venue_id"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("zip_code"),
                    rs.getString("phone"),
                    rs.getString("web"),
                    rs.getString("email")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving venue by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }

    public boolean addVenue(Venue venue) {
        String query = "INSERT INTO venue (name, address, zip_code, phone, web, email) VALUES (?, ?, ?, ?, ?, ?)";
        
        System.out.println("Connecting to database at: " + JDBC_FULL_URL);
        
        try (Connection conn = getConnection()) {
            System.out.println("Database connection successful");
            
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, venue.getName());
                ps.setString(2, venue.getAddress());
                ps.setString(3, venue.getZipCode());
                ps.setString(4, venue.getPhone());
                ps.setString(5, venue.getWeb());
                ps.setString(6, venue.getEmailAddress());
                
                System.out.println("Executing query: " + query);
                System.out.println("With values: " + venue.getName() + ", " + venue.getAddress() + ", " + 
                                  venue.getZipCode() + ", " + venue.getPhone() + ", " + venue.getWeb() + 
                                  ", " + venue.getEmailAddress());
                
                int result = ps.executeUpdate();
                System.out.println("Query executed, rows affected: " + result);
                return result > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error adding venue: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        }
        
        return false;
    }

    public boolean updateVenue(Venue venue) {
        String query = "UPDATE venue SET name = ?, address = ?, zip_code = ?, phone = ?, web = ?, email = ? WHERE venue_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setString(1, venue.getName());
            ps.setString(2, venue.getAddress());
            ps.setString(3, venue.getZipCode());
            ps.setString(4, venue.getPhone());
            ps.setString(5, venue.getWeb());
            ps.setString(6, venue.getEmailAddress());
            ps.setInt(7, venue.getId());
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                // Log the activity
                User user = (User) getCaller();
                if (user != null) {
                    ActivityLogDAO.logActivity(user.getUserId(), "UPDATE_VENUE", "Updated venue '" + venue.getName() + "'");
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error updating venue: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }

    public boolean deleteVenue(int venueId) {
        // First get the venue name for logging
        Venue venue = getVenueById(venueId);
        if (venue == null) return false;
        
        String query = "DELETE FROM venue WHERE venue_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, venueId);
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                // Log the activity
                User user = (User) getCaller();
                if (user != null) {
                    ActivityLogDAO.logActivity(user.getUserId(), "DELETE_VENUE", "Deleted venue '" + venue.getName() + "'");
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error deleting venue: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }

    public void closeConnection() {
        try {
            Connection conn = getConnection();
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Helper method to get the current user from the session
    private Object getCaller() {
        try {
            // This is a placeholder. In a real app, you would get this from the current session
            // For now, returning null as we can't directly access the session from a DAO
            return null;
        } catch (Exception e) {
            return null;
        }
    }
}
