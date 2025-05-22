package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class EventDAO {
    // Database connection parameters - updated to be consistent with other DAOs
<<<<<<< HEAD
    private static final String URL = "jdbc:mysql://localhost:3308/eventify";
=======
    private static final String URL = "jdbc:mysql://localhost:3306/eventify";
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
    private static final String USER = "root";
    private static final String PASS = "";

    static {
        // Load the JDBC driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver loaded successfully");
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Test connection
            try (Connection testConn = DriverManager.getConnection(URL, USER, PASS)) {
                System.out.println("Event DAO - Database connection successful!");
            } catch (SQLException e) {
                System.err.println("Event DAO - Database connection test failed: " + e.getMessage());
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            System.err.println("Error loading MySQL JDBC Driver: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to load MySQL JDBC driver", e);
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // Create event table if it doesn't exist
        createEventTableIfNotExists();
    }

    // Get database connection
    private Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            if (conn == null) {
                System.err.println("Warning: DriverManager.getConnection() returned null");
            }
            return conn;
        } catch (SQLException e) {
            System.err.println("Error getting database connection: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
<<<<<<< HEAD

    // Create event table if it doesn't exist
    private static void createEventTableIfNotExists() {
        String query = "CREATE TABLE IF NOT EXISTS event (" +
                "event_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "title VARCHAR(100) NOT NULL, " +
                "event_date TIMESTAMP NOT NULL, " +
                "venue VARCHAR(100) NOT NULL, " +
                "description TEXT, " +
                "manager VARCHAR(100), " +
                "approved BOOLEAN DEFAULT FALSE, " +
                "attendees INT DEFAULT 0" +
                ")";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             Statement stmt = conn.createStatement()) {

            stmt.execute(query);
            System.out.println("Event table created successfully");

=======
    
    // Create event table if it doesn't exist
    private static void createEventTableIfNotExists() {
        String query = "CREATE TABLE IF NOT EXISTS event (" +
                      "event_id INT AUTO_INCREMENT PRIMARY KEY, " +
                      "title VARCHAR(100) NOT NULL, " +
                      "event_date TIMESTAMP NOT NULL, " +
                      "venue VARCHAR(100) NOT NULL, " +
                      "description TEXT, " +
                      "manager VARCHAR(100), " +
                      "approved BOOLEAN DEFAULT FALSE, " +
                      "attendees INT DEFAULT 0" +
                      ")";
                      
        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             Statement stmt = conn.createStatement()) {
             
            stmt.execute(query);
            System.out.println("Event table created successfully");
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Check if table is empty and insert sample data if needed
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM event");
            if (rs.next() && rs.getInt(1) == 0) {
                insertSampleEvents();
            } else {
                System.out.println("Event table already has data. Count: " + rs.getInt(1));
            }
        } catch (SQLException e) {
            System.err.println("Error creating event table: " + e.getMessage());
            e.printStackTrace();
        }
    }
<<<<<<< HEAD

    // Insert sample events into the database if it's empty
    private static void insertSampleEvents() {
        String query = "INSERT INTO event (title, event_date, venue, description, manager, approved, attendees) VALUES " +
                "(?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(query)) {

=======
    
    // Insert sample events into the database if it's empty
    private static void insertSampleEvents() {
        String query = "INSERT INTO event (title, event_date, venue, description, manager, approved, attendees) VALUES " +
                      "(?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(query)) {
             
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Sample events with real data
            insertSampleEvent(ps, "New Year Eve", 10, "Grand Hall", "New Year celebration event", "Admin", true, 150);
            insertSampleEvent(ps, "Rice Pudding Ceremony", 15, "City Center", "Traditional ceremony with rice pudding", "John Doe", true, 75);
            insertSampleEvent(ps, "Graduation Ceremony", 30, "University Auditorium", "Annual graduation ceremony", "Jane Smith", true, 300);
            insertSampleEvent(ps, "Beauty Pageant", 45, "Convention Center", "Annual beauty contest", "Michael Brown", false, 200);
            insertSampleEvent(ps, "Baby Shower", 7, "Community Hall", "Baby shower celebration", "Sarah Johnson", true, 50);
            insertSampleEvent(ps, "Press Conference", 3, "Media Center", "Product launch announcement", "David Williams", true, 100);
            insertSampleEvent(ps, "Christmas Party", 90, "Winter Garden", "Annual Christmas celebration", "Jessica Miller", false, 250);
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            System.out.println("Sample events inserted successfully");
        } catch (SQLException e) {
            System.err.println("Error inserting sample events: " + e.getMessage());
            e.printStackTrace();
        }
    }
<<<<<<< HEAD

    private static void insertSampleEvent(PreparedStatement ps, String title, int daysAhead,
                                          String venue, String description, String manager,
                                          boolean approved, int attendees) throws SQLException {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, daysAhead);

=======
    
    private static void insertSampleEvent(PreparedStatement ps, String title, int daysAhead, 
                                        String venue, String description, String manager, 
                                        boolean approved, int attendees) throws SQLException {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, daysAhead);
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        ps.setString(1, title);
        ps.setTimestamp(2, new Timestamp(calendar.getTimeInMillis()));
        ps.setString(3, venue);
        ps.setString(4, description);
        ps.setString(5, manager);
        ps.setBoolean(6, approved);
        ps.setInt(7, attendees);
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        ps.executeUpdate();
    }

    public List<Event> getAllEvents() {
        List<Event> eventList = new ArrayList<>();
        String query = "SELECT * FROM Event ORDER BY Event_date DESC";
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        try (Connection conn = getConnection()) {
            if (conn == null) {
                System.err.println("Unable to get connection in getAllEvents");
                return eventList;
            }
<<<<<<< HEAD

            try (PreparedStatement ps = conn.prepareStatement(query);
                 ResultSet rs = ps.executeQuery()) {

                System.out.println("Executing event query: " + query);

=======
            
            try (PreparedStatement ps = conn.prepareStatement(query);
                 ResultSet rs = ps.executeQuery()) {
                
                System.out.println("Executing event query: " + query);
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                while (rs.next()) {
                    Event event = new Event();
                    event.setId(rs.getInt("Event_id"));
                    event.setName(rs.getString("Title"));
<<<<<<< HEAD

=======
                    
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                    // Convert java.sql.Date to java.util.Date
                    java.sql.Date sqlDate = rs.getDate("Event_date");
                    if (sqlDate != null) {
                        event.setDateTime(new Date(sqlDate.getTime()));
                    }
<<<<<<< HEAD

=======
                    
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                    // Calculate days until event
                    if (event.getDateTime() != null) {
                        Calendar eventDate = Calendar.getInstance();
                        eventDate.setTime(event.getDateTime());
                        Calendar today = Calendar.getInstance();
                        long diffMillis = eventDate.getTimeInMillis() - today.getTimeInMillis();
                        int diffDays = (int) (diffMillis / (24 * 60 * 60 * 1000));
                        event.setDaysUntilEvent(diffDays);
                    }
<<<<<<< HEAD

                    // Get related data
                    event.setDescription(rs.getString("Description"));

                    // Get venue information from Event_Venue join
                    VenueDAO venueDAO = new VenueDAO();
                    String venueQuery = "SELECT v.Name FROM Venue v " +
                            "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                            "WHERE ev.Event_id = ?";
=======
                    
                    // Get related data
                    event.setDescription(rs.getString("Description"));
                    
                    // Get venue information from Event_Venue join
                    VenueDAO venueDAO = new VenueDAO();
                    String venueQuery = "SELECT v.Name FROM Venue v " +
                                        "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                                        "WHERE ev.Event_id = ?";
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                    try (PreparedStatement venuePs = conn.prepareStatement(venueQuery)) {
                        venuePs.setInt(1, event.getId());
                        ResultSet venueRs = venuePs.executeQuery();
                        if (venueRs.next()) {
                            event.setVenue(venueRs.getString("Name"));
                        }
                    }
<<<<<<< HEAD

=======
                    
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                    // Set other fields with default values since they don't exist in the database
                    event.setManager("Not specified");
                    event.setApproved(true); // Default to approved
                    event.setAttendees(0);   // Default to 0 attendees
<<<<<<< HEAD

                    eventList.add(event);
                    System.out.println("Retrieved event: " + event.getName());
                }

=======
                    
                    eventList.add(event);
                    System.out.println("Retrieved event: " + event.getName());
                }
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                System.out.println("Total events retrieved: " + eventList.size());
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving events: " + e.getMessage());
            e.printStackTrace();
        }

        return eventList;
    }
<<<<<<< HEAD

    public Event getEventById(int eventId) {
        String query = "SELECT * FROM Event WHERE Event_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();

=======
    
    public Event getEventById(int eventId) {
        String query = "SELECT * FROM Event WHERE Event_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            if (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("Event_id"));
                event.setName(rs.getString("Title"));
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                // Convert java.sql.Date to java.util.Date
                java.sql.Date sqlDate = rs.getDate("Event_date");
                if (sqlDate != null) {
                    event.setDateTime(new Date(sqlDate.getTime()));
                }
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                // Calculate days until event
                if (event.getDateTime() != null) {
                    Calendar eventDate = Calendar.getInstance();
                    eventDate.setTime(event.getDateTime());
                    Calendar today = Calendar.getInstance();
                    long diffMillis = eventDate.getTimeInMillis() - today.getTimeInMillis();
                    int diffDays = (int) (diffMillis / (24 * 60 * 60 * 1000));
                    event.setDaysUntilEvent(diffDays);
                }
<<<<<<< HEAD

                // Get related data
                event.setDescription(rs.getString("Description"));

                // Get venue information from Event_Venue join
                VenueDAO venueDAO = new VenueDAO();
                String venueQuery = "SELECT v.Name FROM Venue v " +
                        "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                        "WHERE ev.Event_id = ?";
=======
                
                // Get related data
                event.setDescription(rs.getString("Description"));
                
                // Get venue information from Event_Venue join
                VenueDAO venueDAO = new VenueDAO();
                String venueQuery = "SELECT v.Name FROM Venue v " +
                                    "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                                    "WHERE ev.Event_id = ?";
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                try (PreparedStatement venuePs = conn.prepareStatement(venueQuery)) {
                    venuePs.setInt(1, event.getId());
                    ResultSet venueRs = venuePs.executeQuery();
                    if (venueRs.next()) {
                        event.setVenue(venueRs.getString("Name"));
                    }
                }
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                // Set other fields with default values
                event.setManager("Not specified");
                event.setApproved(true);
                event.setAttendees(0);
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                return event;
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving event: " + e.getMessage());
            e.printStackTrace();
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        return null;
    }

    public boolean addEvent(Event event) {
        // We need to use transactions since we're inserting into multiple tables
        Connection conn = null;
<<<<<<< HEAD

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            System.out.println("Attempting to add event: " + event.getName());

            // 1. Insert into Event table
            String eventQuery = "INSERT INTO Event (Title, Description, Event_date, Category, CreatedAt) " +
                    "VALUES (?, ?, ?, ?, NOW())";

=======
        
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            
            System.out.println("Attempting to add event: " + event.getName());
            
            // 1. Insert into Event table
            String eventQuery = "INSERT INTO Event (Title, Description, Event_date, Category, CreatedAt) " +
                                "VALUES (?, ?, ?, ?, NOW())";
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            int eventId;
            try (PreparedStatement ps = conn.prepareStatement(eventQuery, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, event.getName());
                ps.setString(2, event.getDescription());
                ps.setDate(3, new java.sql.Date(event.getDateTime().getTime()));
                ps.setString(4, "General"); // Default category
<<<<<<< HEAD

                int result = ps.executeUpdate();

=======
                
                int result = ps.executeUpdate();
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                if (result <= 0) {
                    System.err.println("No rows affected when adding event");
                    conn.rollback();
                    return false;
                }
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                // Get generated event ID
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    eventId = generatedKeys.getInt(1);
                } else {
                    System.err.println("Failed to get generated event ID");
                    conn.rollback();
                    return false;
                }
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // 2. Find venue ID for the given venue name
            int venueId = -1;
            String venueQuery = "SELECT Venue_id FROM Venue WHERE Name = ?";
            try (PreparedStatement ps = conn.prepareStatement(venueQuery)) {
                ps.setString(1, event.getVenue());
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    venueId = rs.getInt("Venue_id");
                } else {
                    System.err.println("Venue not found: " + event.getVenue());
                    conn.rollback();
                    return false;
                }
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // 3. Insert into Event_Venue junction table
            String junctionQuery = "INSERT INTO Event_Venue (Event_id, Venue_id) VALUES (?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(junctionQuery)) {
                ps.setInt(1, eventId);
                ps.setInt(2, venueId);
<<<<<<< HEAD

                int result = ps.executeUpdate();

=======
                
                int result = ps.executeUpdate();
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                if (result <= 0) {
                    System.err.println("No rows affected when adding event-venue relationship");
                    conn.rollback();
                    return false;
                }
            }
<<<<<<< HEAD

            // If we've reached this point, commit the transaction
            conn.commit();
            System.out.println("Event successfully added to database with ID: " + eventId);

=======
            
            // If we've reached this point, commit the transaction
            conn.commit();
            System.out.println("Event successfully added to database with ID: " + eventId);
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Log activity
            try {
                ActivityLogDAO.logActivity(0, "ADD_EVENT", "Added event '" + event.getName() + "'");
            } catch (Exception e) {
                System.err.println("Warning: Failed to log activity: " + e.getMessage());
                // Don't rollback for logging failures
            }
<<<<<<< HEAD

            return true;

        } catch (SQLException e) {
            System.err.println("Error adding event: " + e.getMessage());
            e.printStackTrace();

=======
            
            return true;
            
        } catch (SQLException e) {
            System.err.println("Error adding event: " + e.getMessage());
            e.printStackTrace();
            
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
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        System.err.println("Failed to add event");
        return false;
    }

    public boolean updateEvent(Event event) {
        // Similar to addEvent, we need transactions
        Connection conn = null;
<<<<<<< HEAD

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // 1. Update Event table
            String eventQuery = "UPDATE Event SET Title = ?, Description = ?, Event_date = ? WHERE Event_id = ?";

=======
        
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            
            // 1. Update Event table
            String eventQuery = "UPDATE Event SET Title = ?, Description = ?, Event_date = ? WHERE Event_id = ?";
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            try (PreparedStatement ps = conn.prepareStatement(eventQuery)) {
                ps.setString(1, event.getName());
                ps.setString(2, event.getDescription());
                ps.setDate(3, new java.sql.Date(event.getDateTime().getTime()));
                ps.setInt(4, event.getId());
<<<<<<< HEAD

                int result = ps.executeUpdate();

=======
                
                int result = ps.executeUpdate();
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                if (result <= 0) {
                    System.err.println("No rows affected when updating event");
                    conn.rollback();
                    return false;
                }
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // 2. Find venue ID for the given venue name
            int venueId = -1;
            String venueQuery = "SELECT Venue_id FROM Venue WHERE Name = ?";
            try (PreparedStatement ps = conn.prepareStatement(venueQuery)) {
                ps.setString(1, event.getVenue());
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    venueId = rs.getInt("Venue_id");
                } else {
                    System.err.println("Venue not found: " + event.getVenue());
                    conn.rollback();
                    return false;
                }
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // 3. Update Event_Venue junction table
            // First delete existing relationship
            String deleteQuery = "DELETE FROM Event_Venue WHERE Event_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(deleteQuery)) {
                ps.setInt(1, event.getId());
                ps.executeUpdate();
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Then insert new relationship
            String insertQuery = "INSERT INTO Event_Venue (Event_id, Venue_id) VALUES (?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertQuery)) {
                ps.setInt(1, event.getId());
                ps.setInt(2, venueId);
<<<<<<< HEAD

                int result = ps.executeUpdate();

=======
                
                int result = ps.executeUpdate();
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                if (result <= 0) {
                    System.err.println("No rows affected when updating event-venue relationship");
                    conn.rollback();
                    return false;
                }
            }
<<<<<<< HEAD

            // Commit the transaction
            conn.commit();

=======
            
            // Commit the transaction
            conn.commit();
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Log activity
            try {
                ActivityLogDAO.logActivity(0, "UPDATE_EVENT", "Updated event '" + event.getName() + "'");
            } catch (Exception e) {
                System.err.println("Warning: Failed to log activity: " + e.getMessage());
            }
<<<<<<< HEAD

            return true;

        } catch (SQLException e) {
            System.err.println("Error updating event: " + e.getMessage());
            e.printStackTrace();

=======
            
            return true;
            
        } catch (SQLException e) {
            System.err.println("Error updating event: " + e.getMessage());
            e.printStackTrace();
            
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
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        return false;
    }

    public boolean deleteEvent(int eventId) {
        // We need transactions for delete as well
        Connection conn = null;
<<<<<<< HEAD

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

=======
        
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Get event name for logging
            String eventName = "";
            String nameQuery = "SELECT Title FROM Event WHERE Event_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(nameQuery)) {
                ps.setInt(1, eventId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    eventName = rs.getString("Title");
                }
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // 1. Delete from Event_Venue junction table
            String junctionQuery = "DELETE FROM Event_Venue WHERE Event_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(junctionQuery)) {
                ps.setInt(1, eventId);
                ps.executeUpdate();
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // 2. Delete from User_Event junction table if it exists
            String userEventQuery = "DELETE FROM User_Event WHERE Event_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(userEventQuery)) {
                ps.setInt(1, eventId);
                ps.executeUpdate();
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // 3. Delete from Event table
            String eventQuery = "DELETE FROM Event WHERE Event_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(eventQuery)) {
                ps.setInt(1, eventId);
<<<<<<< HEAD

                int result = ps.executeUpdate();

=======
                
                int result = ps.executeUpdate();
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                if (result <= 0) {
                    System.err.println("No rows affected when deleting event");
                    conn.rollback();
                    return false;
                }
            }
<<<<<<< HEAD

            // Commit the transaction
            conn.commit();

=======
            
            // Commit the transaction
            conn.commit();
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Log activity
            try {
                ActivityLogDAO.logActivity(0, "DELETE_EVENT", "Deleted event '" + eventName + "'");
            } catch (Exception e) {
                System.err.println("Warning: Failed to log activity: " + e.getMessage());
            }
<<<<<<< HEAD

            return true;

        } catch (SQLException e) {
            System.err.println("Error deleting event: " + e.getMessage());
            e.printStackTrace();

=======
            
            return true;
            
        } catch (SQLException e) {
            System.err.println("Error deleting event: " + e.getMessage());
            e.printStackTrace();
            
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
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        return false;
    }

    public void closeConnection() {
        try {
            if (getConnection() != null && !getConnection().isClosed()) {
                getConnection().close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to get total event count for admin dashboard
    public int getEventCount() {
        String query = "SELECT COUNT(*) AS count FROM Event";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            System.err.println("Error counting events: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }
<<<<<<< HEAD

=======
    
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
    // Since we don't have 'approved' column, return all events as approved
    public int getApprovedEventCount() {
        return getEventCount();
    }

    // Method to get recent events for dashboard
    public List<Event> getRecentEvents(int limit) {
        List<Event> events = new ArrayList<>();
        String query = "SELECT * FROM Event ORDER BY Event_date DESC LIMIT ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("Event_id"));
                event.setName(rs.getString("Title"));
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                // Convert java.sql.Date to java.util.Date
                java.sql.Date sqlDate = rs.getDate("Event_date");
                if (sqlDate != null) {
                    event.setDateTime(new Date(sqlDate.getTime()));
                }
<<<<<<< HEAD

                event.setDescription(rs.getString("Description"));

                // Get venue information from Event_Venue join
                String venueQuery = "SELECT v.Name FROM Venue v " +
                        "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                        "WHERE ev.Event_id = ?";
=======
                
                event.setDescription(rs.getString("Description"));
                
                // Get venue information from Event_Venue join
                String venueQuery = "SELECT v.Name FROM Venue v " +
                                    "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                                    "WHERE ev.Event_id = ?";
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                try (PreparedStatement venuePs = conn.prepareStatement(venueQuery)) {
                    venuePs.setInt(1, event.getId());
                    ResultSet venueRs = venuePs.executeQuery();
                    if (venueRs.next()) {
                        event.setVenue(venueRs.getString("Name"));
                    }
                }
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                // Set default values for fields not in database
                event.setManager("Not specified");
                event.setApproved(true);
                event.setAttendees(0);
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                events.add(event);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving recent events: " + e.getMessage());
            e.printStackTrace();
        }

        return events;
    }
<<<<<<< HEAD

=======
    
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
    // Method to search events by title
    public List<Event> searchEventsByTitle(String searchTerm) {
        List<Event> eventList = new ArrayList<>();
        String query = "SELECT * FROM Event WHERE Title LIKE ? ORDER BY Event_date DESC";
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        try (Connection conn = getConnection()) {
            if (conn == null) {
                System.err.println("Unable to get connection in searchEventsByTitle");
                return eventList;
            }
<<<<<<< HEAD

            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, "%" + searchTerm + "%");

                System.out.println("Executing event search query: " + query + " with term: " + searchTerm);

=======
            
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, "%" + searchTerm + "%");
                
                System.out.println("Executing event search query: " + query + " with term: " + searchTerm);
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Event event = new Event();
                        event.setId(rs.getInt("Event_id"));
                        event.setName(rs.getString("Title"));
<<<<<<< HEAD

=======
                        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                        // Convert java.sql.Date to java.util.Date
                        java.sql.Date sqlDate = rs.getDate("Event_date");
                        if (sqlDate != null) {
                            event.setDateTime(new Date(sqlDate.getTime()));
                        }
<<<<<<< HEAD

                        event.setDescription(rs.getString("Description"));

                        // Get venue information from Event_Venue join
                        String venueQuery = "SELECT v.Name FROM Venue v " +
                                "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                                "WHERE ev.Event_id = ?";
=======
                        
                        event.setDescription(rs.getString("Description"));
                        
                        // Get venue information from Event_Venue join
                        String venueQuery = "SELECT v.Name FROM Venue v " +
                                           "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                                           "WHERE ev.Event_id = ?";
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                        try (PreparedStatement venuePs = conn.prepareStatement(venueQuery)) {
                            venuePs.setInt(1, event.getId());
                            ResultSet venueRs = venuePs.executeQuery();
                            if (venueRs.next()) {
                                event.setVenue(venueRs.getString("Name"));
                            }
                        }
<<<<<<< HEAD

=======
                        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                        // Set default values for fields not in database
                        event.setManager("Not specified");
                        event.setApproved(true);
                        event.setAttendees(0);
<<<<<<< HEAD

                        eventList.add(event);
                    }
                }

=======
                        
                        eventList.add(event);
                    }
                }
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                System.out.println("Found " + eventList.size() + " events matching: " + searchTerm);
            }
        } catch (SQLException e) {
            System.err.println("Error searching events: " + e.getMessage());
            e.printStackTrace();
        }
<<<<<<< HEAD

        return eventList;
    }

    // Method to search events across multiple fields
    public List<Event> searchEvents(String searchQuery) {
        List<Event> eventList = new ArrayList<>();

=======
        
        return eventList;
    }
    
    // Method to search events across multiple fields
    public List<Event> searchEvents(String searchQuery) {
        List<Event> eventList = new ArrayList<>();
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        // If search query is empty, return all events
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            return getAllEvents();
        }
<<<<<<< HEAD

        String query = "SELECT * FROM Event WHERE Title LIKE ? OR Description LIKE ? OR venue LIKE ? ORDER BY Event_date DESC";

=======
        
        String query = "SELECT * FROM Event WHERE Title LIKE ? OR Description LIKE ? OR venue LIKE ? ORDER BY Event_date DESC";
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        try (Connection conn = getConnection()) {
            if (conn == null) {
                System.err.println("Unable to get connection in searchEvents");
                return eventList;
            }
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                String searchTerm = "%" + searchQuery + "%";
                ps.setString(1, searchTerm);
                ps.setString(2, searchTerm);
                ps.setString(3, searchTerm);
<<<<<<< HEAD

                System.out.println("Executing event search query: " + query + " with term: " + searchQuery);

=======
                
                System.out.println("Executing event search query: " + query + " with term: " + searchQuery);
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Event event = new Event();
                        event.setId(rs.getInt("Event_id"));
                        event.setName(rs.getString("Title"));
<<<<<<< HEAD

=======
                        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                        // Convert java.sql.Date to java.util.Date
                        java.sql.Date sqlDate = rs.getDate("Event_date");
                        if (sqlDate != null) {
                            event.setDateTime(new Date(sqlDate.getTime()));
                        }
<<<<<<< HEAD

=======
                        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                        // Calculate days until event
                        if (event.getDateTime() != null) {
                            Calendar eventDate = Calendar.getInstance();
                            eventDate.setTime(event.getDateTime());
                            Calendar today = Calendar.getInstance();
                            long diffMillis = eventDate.getTimeInMillis() - today.getTimeInMillis();
                            int diffDays = (int) (diffMillis / (24 * 60 * 60 * 1000));
                            event.setDaysUntilEvent(diffDays);
                        }
<<<<<<< HEAD

                        // Get related data
                        event.setDescription(rs.getString("Description"));
                        event.setVenue(rs.getString("venue"));

=======
                        
                        // Get related data
                        event.setDescription(rs.getString("Description"));
                        event.setVenue(rs.getString("venue"));
                        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                        // Set default values for fields not in database
                        event.setManager(rs.getString("manager") != null ? rs.getString("manager") : "Not specified");
                        event.setApproved(rs.getBoolean("approved"));
                        event.setAttendees(rs.getInt("attendees"));
<<<<<<< HEAD

                        eventList.add(event);
                    }
                }

=======
                        
                        eventList.add(event);
                    }
                }
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                System.out.println("Found " + eventList.size() + " events matching: " + searchQuery);
            }
        } catch (SQLException e) {
            System.err.println("Error searching events: " + e.getMessage());
            e.printStackTrace();
        }
<<<<<<< HEAD

        return eventList;
    }

=======
        
        return eventList;
    }
    
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
=======
    
    public boolean registerUserForEvent(int eventId, int userId) {
        System.out.println("DEBUG: EventDAO: registerUserForEvent called for eventId " + eventId + " and userId " + userId);
        Connection conn = null;
        boolean success = false;
        
        try {
            conn = getConnection();
            
            // Check if user is already registered
            String checkQuery = "SELECT COUNT(*) FROM User_Event WHERE Event_id = ? AND User_id = ?";
            System.out.println("DEBUG: EventDAO: Checking if user is already registered with query: " + checkQuery);
            try (PreparedStatement psCheck = conn.prepareStatement(checkQuery)) {
                psCheck.setInt(1, eventId);
                psCheck.setInt(2, userId);
                ResultSet rs = psCheck.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    System.out.println("DEBUG: EventDAO: User " + userId + " is already registered for event " + eventId);
                    return false; // User is already registered
                }
            }
            System.out.println("DEBUG: EventDAO: User " + userId + " is not yet registered for event " + eventId);
            
            // If not registered, insert into User_Event table
            String insertQuery = "INSERT INTO User_Event (Event_id, User_id) VALUES (?, ?)";
            System.out.println("DEBUG: EventDAO: Inserting registration record with query: " + insertQuery);
            try (PreparedStatement psInsert = conn.prepareStatement(insertQuery)) {
                psInsert.setInt(1, eventId);
                psInsert.setInt(2, userId);
                
                int rowsAffected = psInsert.executeUpdate();
                System.out.println("DEBUG: EventDAO: Inserted " + rowsAffected + " rows into User_Event");
                if (rowsAffected > 0) {
                    System.out.println("DEBUG: EventDAO: User " + userId + " successfully registered for event " + eventId);
                    success = true;
                    
                    // Increment attendees count in the Event table
                    String updateAttendeesQuery = "UPDATE Event SET attendees = attendees + 1 WHERE Event_id = ?";
                    System.out.println("DEBUG: EventDAO: Updating attendees count with query: " + updateAttendeesQuery);
                    try (PreparedStatement psUpdateAttendees = conn.prepareStatement(updateAttendeesQuery)) {
                        psUpdateAttendees.setInt(1, eventId);
                        int updatedRows = psUpdateAttendees.executeUpdate();
                        System.out.println("DEBUG: EventDAO: Updated " + updatedRows + " rows in Event table for attendees count");
                    }
                    
                } else {
                    System.err.println("DEBUG: EventDAO: Failed to insert registration record for user " + userId + " and event " + eventId);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("DEBUG: EventDAO: Error registering user for event: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException closeEx) {
                System.err.println("DEBUG: EventDAO: Error closing connection: " + closeEx.getMessage());
                closeEx.printStackTrace();
            }
        }
        
        return success;
    }
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
}