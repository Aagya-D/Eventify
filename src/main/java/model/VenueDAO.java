package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VenueDAO {
<<<<<<< HEAD
    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/";
=======
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/";
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
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
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Try to connect to just the server without database to see if server is available
            try {
                DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                System.err.println("MySQL server is available but database '" + DB_NAME + "' may not exist");
            } catch (SQLException e2) {
                System.err.println("MySQL server connection failed. Make sure MySQL is running on port 3306");
                System.err.println("Server connection error: " + e2.getMessage());
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
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
        String query = "CREATE TABLE IF NOT EXISTS Venue (" +
                      "Venue_id INT AUTO_INCREMENT PRIMARY KEY, " +
                      "Name VARCHAR(100) NOT NULL, " +
                      "Address VARCHAR(200) NOT NULL, " +
                      "City VARCHAR(100) NOT NULL, " +
                      "Contact_number VARCHAR(20) NOT NULL, " +
                      "Capacity INT NOT NULL" +
                      ")";
                      
        try (Connection conn = DriverManager.getConnection(JDBC_FULL_URL, JDBC_USER, JDBC_PASSWORD);
             Statement stmt = conn.createStatement()) {
             
            stmt.execute(query);
            System.out.println("Venue table created successfully");
            
            // Check if table is empty and insert sample data if needed
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Venue");
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
        String query = "INSERT INTO Venue (Name, Address, City, Contact_number, Capacity) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DriverManager.getConnection(JDBC_FULL_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            // Sample venues with real data
            insertSampleVenue(ps, "Grand Hall", "123 Main St", "New York", "555-0123", 500);
            insertSampleVenue(ps, "City Center", "456 Park Ave", "Chicago", "555-0124", 300);
            insertSampleVenue(ps, "Riverside Plaza", "789 River Rd", "San Francisco", "555-0125", 250);
            insertSampleVenue(ps, "Mountain View", "321 Summit Dr", "Denver", "555-0126", 180);
            insertSampleVenue(ps, "Ocean Breeze", "654 Beach Blvd", "Miami", "555-0127", 400);
            // Add Aryan Ghar venue
            insertSampleVenue(ps, "Aryan Ghar", "123 Aryan Street", "Mumbai", "555-0128", 150);
            
            System.out.println("Sample venues inserted successfully");
        } catch (SQLException e) {
            System.err.println("Error inserting sample venues: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private static void insertSampleVenue(PreparedStatement ps, String name, String address, 
                                       String city, String contactNumber, int capacity) throws SQLException {
        ps.setString(1, name);
        ps.setString(2, address);
        ps.setString(3, city);
        ps.setString(4, contactNumber);
        ps.setInt(5, capacity);
        
        ps.executeUpdate();
    }

    public VenueDAO() {
        // Constructor
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
        String query = "CREATE TABLE IF NOT EXISTS Venue (" +
                "Venue_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "Name VARCHAR(100) NOT NULL, " +
                "Address VARCHAR(200) NOT NULL, " +
                "City VARCHAR(100) NOT NULL, " +
                "Contact_number VARCHAR(20) NOT NULL, " +
                "Capacity INT NOT NULL" +
                ")";

        try (Connection conn = DriverManager.getConnection(JDBC_FULL_URL, JDBC_USER, JDBC_PASSWORD);
             Statement stmt = conn.createStatement()) {

            stmt.execute(query);
            System.out.println("Venue table created successfully");

            // Check if table is empty and insert sample data if needed
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Venue");
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
        String query = "INSERT INTO Venue (Name, Address, City, Contact_number, Capacity) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(JDBC_FULL_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {

            // Sample venues with real data
            insertSampleVenue(ps, "Grand Hall", "123 Main St", "New York", "555-0123", 500);
            insertSampleVenue(ps, "City Center", "456 Park Ave", "Chicago", "555-0124", 300);
            insertSampleVenue(ps, "Riverside Plaza", "789 River Rd", "San Francisco", "555-0125", 250);
            insertSampleVenue(ps, "Mountain View", "321 Summit Dr", "Denver", "555-0126", 180);
            insertSampleVenue(ps, "Ocean Breeze", "654 Beach Blvd", "Miami", "555-0127", 400);
            // Add Aryan Ghar venue
            insertSampleVenue(ps, "Aryan Ghar", "123 Aryan Street", "Mumbai", "555-0128", 150);

            System.out.println("Sample venues inserted successfully");
        } catch (SQLException e) {
            System.err.println("Error inserting sample venues: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void insertSampleVenue(PreparedStatement ps, String name, String address,
                                          String city, String contactNumber, int capacity) throws SQLException {
        ps.setString(1, name);
        ps.setString(2, address);
        ps.setString(3, city);
        ps.setString(4, contactNumber);
        ps.setInt(5, capacity);

        ps.executeUpdate();
    }

    public VenueDAO() {
        // Constructor
    }

    public List<Venue> getAllVenues() {
        List<Venue> venueList = new ArrayList<>();
        String query = "SELECT * FROM Venue";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
<<<<<<< HEAD

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Venue venue = new Venue(
                        rs.getInt("Venue_id"),
                        rs.getString("Name"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("Contact_number"),
                        rs.getInt("Capacity")
=======
             
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Venue venue = new Venue(
                    rs.getInt("Venue_id"),
                    rs.getString("Name"),
                    rs.getString("Address"),
                    rs.getString("City"),
                    rs.getString("Contact_number"),
                    rs.getInt("Capacity")
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
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
        String query = "SELECT * FROM Venue WHERE Venue_id = ?";
<<<<<<< HEAD

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, venueId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Venue(
                        rs.getInt("Venue_id"),
                        rs.getString("Name"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("Contact_number"),
                        rs.getInt("Capacity")
=======
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, venueId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return new Venue(
                    rs.getInt("Venue_id"),
                    rs.getString("Name"),
                    rs.getString("Address"),
                    rs.getString("City"),
                    rs.getString("Contact_number"),
                    rs.getInt("Capacity")
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                );
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving venue by ID: " + e.getMessage());
            e.printStackTrace();
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        return null;
    }

    public boolean addVenue(Venue venue) {
        String query = "INSERT INTO Venue (Name, Address, City, Contact_number, Capacity) VALUES (?, ?, ?, ?, ?)";
<<<<<<< HEAD

        System.out.println("Connecting to database at: " + JDBC_FULL_URL);

        try (Connection conn = getConnection()) {
            System.out.println("Database connection successful");

=======
        
        System.out.println("Connecting to database at: " + JDBC_FULL_URL);
        
        try (Connection conn = getConnection()) {
            System.out.println("Database connection successful");
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, venue.getName());
                ps.setString(2, venue.getAddress());
                ps.setString(3, venue.getCity());
                ps.setString(4, venue.getContactNumber());
                ps.setInt(5, venue.getCapacity());
<<<<<<< HEAD

                System.out.println("Executing query: " + query);
                System.out.println("With values: " + venue.getName() + ", " + venue.getAddress() + ", " +
                        venue.getCity() + ", " + venue.getContactNumber() + ", " + venue.getCapacity());

=======
                
                System.out.println("Executing query: " + query);
                System.out.println("With values: " + venue.getName() + ", " + venue.getAddress() + ", " + 
                                  venue.getCity() + ", " + venue.getContactNumber() + ", " + venue.getCapacity());
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
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
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        return false;
    }

    public boolean updateVenue(Venue venue) {
        String query = "UPDATE Venue SET Name = ?, Address = ?, City = ?, Contact_number = ?, Capacity = ? WHERE Venue_id = ?";
<<<<<<< HEAD

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

=======
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            ps.setString(1, venue.getName());
            ps.setString(2, venue.getAddress());
            ps.setString(3, venue.getCity());
            ps.setString(4, venue.getContactNumber());
            ps.setInt(5, venue.getCapacity());
            ps.setInt(6, venue.getId());
<<<<<<< HEAD

            int result = ps.executeUpdate();

=======
            
            int result = ps.executeUpdate();
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error updating venue: " + e.getMessage());
            e.printStackTrace();
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        return false;
    }

    public boolean deleteVenue(int venueId) {
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // First check if venue has any associated events
            String checkQuery = "SELECT COUNT(*) FROM Event_Venue WHERE Venue_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(checkQuery)) {
                ps.setInt(1, venueId);
                ResultSet rs = ps.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    // There are associated events, delete them first
                    String deleteEventVenueQuery = "DELETE FROM Event_Venue WHERE Venue_id = ?";
                    try (PreparedStatement eventVenuePs = conn.prepareStatement(deleteEventVenueQuery)) {
                        eventVenuePs.setInt(1, venueId);
                        eventVenuePs.executeUpdate();
                    }
                }
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Now delete the venue
            String query = "DELETE FROM Venue WHERE Venue_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setInt(1, venueId);
                int result = ps.executeUpdate();
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                if (result > 0) {
                    conn.commit();
                    return true;
                } else {
                    conn.rollback();
                    return false;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error deleting venue: " + e.getMessage());
            e.printStackTrace();
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                System.err.println("Error during rollback: " + rollbackEx.getMessage());
                rollbackEx.printStackTrace();
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException closeEx) {
                System.err.println("Error closing connection: " + closeEx.getMessage());
                closeEx.printStackTrace();
            }
        }
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
<<<<<<< HEAD

=======
    
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
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
<<<<<<< HEAD

    // Method to get total venue count for admin dashboard
    public int getVenueCount() {
        String query = "SELECT COUNT(*) AS count FROM Venue";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();

=======
    
    // Method to get total venue count for admin dashboard
    public int getVenueCount() {
        String query = "SELECT COUNT(*) AS count FROM Venue";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ResultSet rs = ps.executeQuery();
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            System.err.println("Error counting venues: " + e.getMessage());
            e.printStackTrace();
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        return 0;
    }

    // Search venues by name
    public List<Venue> searchVenuesByName(String searchTerm) {
        List<Venue> venueList = new ArrayList<>();
        String query = "SELECT * FROM Venue WHERE Name LIKE ?";
<<<<<<< HEAD

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, "%" + searchTerm + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Venue venue = new Venue(
                        rs.getInt("Venue_id"),
                        rs.getString("Name"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("Contact_number"),
                        rs.getInt("Capacity")
                );
                venueList.add(venue);
            }

=======
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setString(1, "%" + searchTerm + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Venue venue = new Venue(
                    rs.getInt("Venue_id"),
                    rs.getString("Name"),
                    rs.getString("Address"),
                    rs.getString("City"),
                    rs.getString("Contact_number"),
                    rs.getInt("Capacity")
                );
                venueList.add(venue);
            }
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            System.out.println("Found " + venueList.size() + " venues matching: " + searchTerm);
        } catch (SQLException e) {
            System.err.println("Error searching venues: " + e.getMessage());
            e.printStackTrace();
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        return venueList;
    }

    // Search venues by multiple fields (name, address, city)
    public List<Venue> searchVenues(String searchQuery) {
        List<Venue> venueList = new ArrayList<>();
        String query = "SELECT * FROM Venue WHERE Name LIKE ? OR Address LIKE ? OR City LIKE ? OR Contact_number LIKE ?";
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // If search query is empty, return all venues
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            return getAllVenues();
        }
<<<<<<< HEAD

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

=======
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            String searchTerm = "%" + searchQuery + "%";
            ps.setString(1, searchTerm);
            ps.setString(2, searchTerm);
            ps.setString(3, searchTerm);
            ps.setString(4, searchTerm);
<<<<<<< HEAD

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Venue venue = new Venue(
                        rs.getInt("Venue_id"),
                        rs.getString("Name"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("Contact_number"),
                        rs.getInt("Capacity")
                );
                venueList.add(venue);
            }

=======
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Venue venue = new Venue(
                    rs.getInt("Venue_id"),
                    rs.getString("Name"),
                    rs.getString("Address"),
                    rs.getString("City"),
                    rs.getString("Contact_number"),
                    rs.getInt("Capacity")
                );
                venueList.add(venue);
            }
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            System.out.println("Search found " + venueList.size() + " venues matching: " + searchQuery);
        } catch (SQLException e) {
            System.err.println("Error searching venues: " + e.getMessage());
            e.printStackTrace();
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        return venueList;
    }
}
