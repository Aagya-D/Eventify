package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class EventDAO {
    // Database connection parameters - updated to be consistent with other DAOs
    private static final String URL = "jdbc:mysql://localhost:3308/eventify";
    private static final String USER = "root";
    private static final String PASS = "";

    static {
        // Load the JDBC driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver loaded successfully");

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

    // Insert sample events into the database if it's empty
    private static void insertSampleEvents() {
        String query = "INSERT INTO event (title, event_date, venue, description, manager, approved, attendees) VALUES " +
                "(?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(query)) {

            // Sample events with real data
            insertSampleEvent(ps, "New Year Eve", 10, "Grand Hall", "New Year celebration event", "Admin", true, 150);
            insertSampleEvent(ps, "Rice Pudding Ceremony", 15, "City Center", "Traditional ceremony with rice pudding", "John Doe", true, 75);
            insertSampleEvent(ps, "Graduation Ceremony", 30, "University Auditorium", "Annual graduation ceremony", "Jane Smith", true, 300);
            insertSampleEvent(ps, "Beauty Pageant", 45, "Convention Center", "Annual beauty contest", "Michael Brown", false, 200);
            insertSampleEvent(ps, "Baby Shower", 7, "Community Hall", "Baby shower celebration", "Sarah Johnson", true, 50);
            insertSampleEvent(ps, "Press Conference", 3, "Media Center", "Product launch announcement", "David Williams", true, 100);
            insertSampleEvent(ps, "Christmas Party", 90, "Winter Garden", "Annual Christmas celebration", "Jessica Miller", false, 250);

            System.out.println("Sample events inserted successfully");
        } catch (SQLException e) {
            System.err.println("Error inserting sample events: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void insertSampleEvent(PreparedStatement ps, String title, int daysAhead,
                                          String venue, String description, String manager,
                                          boolean approved, int attendees) throws SQLException {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, daysAhead);

        ps.setString(1, title);
        ps.setTimestamp(2, new Timestamp(calendar.getTimeInMillis()));
        ps.setString(3, venue);
        ps.setString(4, description);
        ps.setString(5, manager);
        ps.setBoolean(6, approved);
        ps.setInt(7, attendees);

        ps.executeUpdate();
    }

    public List<Event> getAllEvents() {
        List<Event> eventList = new ArrayList<>();
        String query = "SELECT * FROM Event ORDER BY Event_date DESC";

        try (Connection conn = getConnection()) {
            if (conn == null) {
                System.err.println("Unable to get connection in getAllEvents");
                return eventList;
            }

            try (PreparedStatement ps = conn.prepareStatement(query);
                 ResultSet rs = ps.executeQuery()) {

                System.out.println("Executing event query: " + query);

                while (rs.next()) {
                    Event event = new Event();
                    event.setId(rs.getInt("Event_id"));
                    event.setName(rs.getString("Title"));

                    // Convert java.sql.Date to java.util.Date
                    java.sql.Date sqlDate = rs.getDate("Event_date");
                    if (sqlDate != null) {
                        event.setDateTime(new Date(sqlDate.getTime()));
                    }

                    // Calculate days until event
                    if (event.getDateTime() != null) {
                        Calendar eventDate = Calendar.getInstance();
                        eventDate.setTime(event.getDateTime());
                        Calendar today = Calendar.getInstance();
                        long diffMillis = eventDate.getTimeInMillis() - today.getTimeInMillis();
                        int diffDays = (int) (diffMillis / (24 * 60 * 60 * 1000));
                        event.setDaysUntilEvent(diffDays);
                    }

                    // Get related data
                    event.setDescription(rs.getString("Description"));

                    // Get venue information from Event_Venue join
                    VenueDAO venueDAO = new VenueDAO();
                    String venueQuery = "SELECT v.Name FROM Venue v " +
                            "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                            "WHERE ev.Event_id = ?";
                    try (PreparedStatement venuePs = conn.prepareStatement(venueQuery)) {
                        venuePs.setInt(1, event.getId());
                        ResultSet venueRs = venuePs.executeQuery();
                        if (venueRs.next()) {
                            event.setVenue(venueRs.getString("Name"));
                        }
                    }

                    // Set other fields with default values since they don't exist in the database
                    event.setManager("Not specified");
                    event.setApproved(true); // Default to approved
                    event.setAttendees(0);   // Default to 0 attendees

                    eventList.add(event);
                    System.out.println("Retrieved event: " + event.getName());
                }

                System.out.println("Total events retrieved: " + eventList.size());
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving events: " + e.getMessage());
            e.printStackTrace();
        }

        return eventList;
    }

    public Event getEventById(int eventId) {
        String query = "SELECT * FROM Event WHERE Event_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("Event_id"));
                event.setName(rs.getString("Title"));

                // Convert java.sql.Date to java.util.Date
                java.sql.Date sqlDate = rs.getDate("Event_date");
                if (sqlDate != null) {
                    event.setDateTime(new Date(sqlDate.getTime()));
                }

                // Calculate days until event
                if (event.getDateTime() != null) {
                    Calendar eventDate = Calendar.getInstance();
                    eventDate.setTime(event.getDateTime());
                    Calendar today = Calendar.getInstance();
                    long diffMillis = eventDate.getTimeInMillis() - today.getTimeInMillis();
                    int diffDays = (int) (diffMillis / (24 * 60 * 60 * 1000));
                    event.setDaysUntilEvent(diffDays);
                }

                // Get related data
                event.setDescription(rs.getString("Description"));

                // Get venue information from Event_Venue join
                VenueDAO venueDAO = new VenueDAO();
                String venueQuery = "SELECT v.Name FROM Venue v " +
                        "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                        "WHERE ev.Event_id = ?";
                try (PreparedStatement venuePs = conn.prepareStatement(venueQuery)) {
                    venuePs.setInt(1, event.getId());
                    ResultSet venueRs = venuePs.executeQuery();
                    if (venueRs.next()) {
                        event.setVenue(venueRs.getString("Name"));
                    }
                }

                // Set other fields with default values
                event.setManager("Not specified");
                event.setApproved(true);
                event.setAttendees(0);

                return event;
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving event: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    public boolean addEvent(Event event) {
        // We need to use transactions since we're inserting into multiple tables
        Connection conn = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            System.out.println("Attempting to add event: " + event.getName());

            // 1. Insert into Event table
            String eventQuery = "INSERT INTO Event (Title, Description, Event_date, Category, CreatedAt) " +
                    "VALUES (?, ?, ?, ?, NOW())";

            int eventId;
            try (PreparedStatement ps = conn.prepareStatement(eventQuery, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, event.getName());
                ps.setString(2, event.getDescription());
                ps.setDate(3, new java.sql.Date(event.getDateTime().getTime()));
                ps.setString(4, "General"); // Default category

                int result = ps.executeUpdate();

                if (result <= 0) {
                    System.err.println("No rows affected when adding event");
                    conn.rollback();
                    return false;
                }

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

            // 3. Insert into Event_Venue junction table
            String junctionQuery = "INSERT INTO Event_Venue (Event_id, Venue_id) VALUES (?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(junctionQuery)) {
                ps.setInt(1, eventId);
                ps.setInt(2, venueId);

                int result = ps.executeUpdate();

                if (result <= 0) {
                    System.err.println("No rows affected when adding event-venue relationship");
                    conn.rollback();
                    return false;
                }
            }

            // If we've reached this point, commit the transaction
            conn.commit();
            System.out.println("Event successfully added to database with ID: " + eventId);

            // Log activity
            try {
                ActivityLogDAO.logActivity(0, "ADD_EVENT", "Added event '" + event.getName() + "'");
            } catch (Exception e) {
                System.err.println("Warning: Failed to log activity: " + e.getMessage());
                // Don't rollback for logging failures
            }

            return true;

        } catch (SQLException e) {
            System.err.println("Error adding event: " + e.getMessage());
            e.printStackTrace();

            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                System.err.println("Error during rollback: " + rollbackEx.getMessage());
                rollbackEx.printStackTrace();
            }

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

        System.err.println("Failed to add event");
        return false;
    }

    public boolean updateEvent(Event event) {
        // Similar to addEvent, we need transactions
        Connection conn = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // 1. Update Event table
            String eventQuery = "UPDATE Event SET Title = ?, Description = ?, Event_date = ? WHERE Event_id = ?";

            try (PreparedStatement ps = conn.prepareStatement(eventQuery)) {
                ps.setString(1, event.getName());
                ps.setString(2, event.getDescription());
                ps.setDate(3, new java.sql.Date(event.getDateTime().getTime()));
                ps.setInt(4, event.getId());

                int result = ps.executeUpdate();

                if (result <= 0) {
                    System.err.println("No rows affected when updating event");
                    conn.rollback();
                    return false;
                }
            }

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

            // 3. Update Event_Venue junction table
            // First delete existing relationship
            String deleteQuery = "DELETE FROM Event_Venue WHERE Event_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(deleteQuery)) {
                ps.setInt(1, event.getId());
                ps.executeUpdate();
            }

            // Then insert new relationship
            String insertQuery = "INSERT INTO Event_Venue (Event_id, Venue_id) VALUES (?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertQuery)) {
                ps.setInt(1, event.getId());
                ps.setInt(2, venueId);

                int result = ps.executeUpdate();

                if (result <= 0) {
                    System.err.println("No rows affected when updating event-venue relationship");
                    conn.rollback();
                    return false;
                }
            }

            // Commit the transaction
            conn.commit();

            // Log activity
            try {
                ActivityLogDAO.logActivity(0, "UPDATE_EVENT", "Updated event '" + event.getName() + "'");
            } catch (Exception e) {
                System.err.println("Warning: Failed to log activity: " + e.getMessage());
            }

            return true;

        } catch (SQLException e) {
            System.err.println("Error updating event: " + e.getMessage());
            e.printStackTrace();

            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                System.err.println("Error during rollback: " + rollbackEx.getMessage());
                rollbackEx.printStackTrace();
            }

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

        return false;
    }

    public boolean deleteEvent(int eventId) {
        // We need transactions for delete as well
        Connection conn = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

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

            // 1. Delete from Event_Venue junction table
            String junctionQuery = "DELETE FROM Event_Venue WHERE Event_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(junctionQuery)) {
                ps.setInt(1, eventId);
                ps.executeUpdate();
            }

            // 2. Delete from User_Event junction table if it exists
            String userEventQuery = "DELETE FROM User_Event WHERE Event_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(userEventQuery)) {
                ps.setInt(1, eventId);
                ps.executeUpdate();
            }

            // 3. Delete from Event table
            String eventQuery = "DELETE FROM Event WHERE Event_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(eventQuery)) {
                ps.setInt(1, eventId);

                int result = ps.executeUpdate();

                if (result <= 0) {
                    System.err.println("No rows affected when deleting event");
                    conn.rollback();
                    return false;
                }
            }

            // Commit the transaction
            conn.commit();

            // Log activity
            try {
                ActivityLogDAO.logActivity(0, "DELETE_EVENT", "Deleted event '" + eventName + "'");
            } catch (Exception e) {
                System.err.println("Warning: Failed to log activity: " + e.getMessage());
            }

            return true;

        } catch (SQLException e) {
            System.err.println("Error deleting event: " + e.getMessage());
            e.printStackTrace();

            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                System.err.println("Error during rollback: " + rollbackEx.getMessage());
                rollbackEx.printStackTrace();
            }

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

                // Convert java.sql.Date to java.util.Date
                java.sql.Date sqlDate = rs.getDate("Event_date");
                if (sqlDate != null) {
                    event.setDateTime(new Date(sqlDate.getTime()));
                }

                event.setDescription(rs.getString("Description"));

                // Get venue information from Event_Venue join
                String venueQuery = "SELECT v.Name FROM Venue v " +
                        "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                        "WHERE ev.Event_id = ?";
                try (PreparedStatement venuePs = conn.prepareStatement(venueQuery)) {
                    venuePs.setInt(1, event.getId());
                    ResultSet venueRs = venuePs.executeQuery();
                    if (venueRs.next()) {
                        event.setVenue(venueRs.getString("Name"));
                    }
                }

                // Set default values for fields not in database
                event.setManager("Not specified");
                event.setApproved(true);
                event.setAttendees(0);

                events.add(event);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving recent events: " + e.getMessage());
            e.printStackTrace();
        }

        return events;
    }

    // Method to search events by title
    public List<Event> searchEventsByTitle(String searchTerm) {
        List<Event> eventList = new ArrayList<>();
        String query = "SELECT * FROM Event WHERE Title LIKE ? ORDER BY Event_date DESC";

        try (Connection conn = getConnection()) {
            if (conn == null) {
                System.err.println("Unable to get connection in searchEventsByTitle");
                return eventList;
            }

            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, "%" + searchTerm + "%");

                System.out.println("Executing event search query: " + query + " with term: " + searchTerm);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Event event = new Event();
                        event.setId(rs.getInt("Event_id"));
                        event.setName(rs.getString("Title"));

                        // Convert java.sql.Date to java.util.Date
                        java.sql.Date sqlDate = rs.getDate("Event_date");
                        if (sqlDate != null) {
                            event.setDateTime(new Date(sqlDate.getTime()));
                        }

                        event.setDescription(rs.getString("Description"));

                        // Get venue information from Event_Venue join
                        String venueQuery = "SELECT v.Name FROM Venue v " +
                                "JOIN Event_Venue ev ON v.Venue_id = ev.Venue_id " +
                                "WHERE ev.Event_id = ?";
                        try (PreparedStatement venuePs = conn.prepareStatement(venueQuery)) {
                            venuePs.setInt(1, event.getId());
                            ResultSet venueRs = venuePs.executeQuery();
                            if (venueRs.next()) {
                                event.setVenue(venueRs.getString("Name"));
                            }
                        }

                        // Set default values for fields not in database
                        event.setManager("Not specified");
                        event.setApproved(true);
                        event.setAttendees(0);

                        eventList.add(event);
                    }
                }

                System.out.println("Found " + eventList.size() + " events matching: " + searchTerm);
            }
        } catch (SQLException e) {
            System.err.println("Error searching events: " + e.getMessage());
            e.printStackTrace();
        }

        return eventList;
    }

    // Method to search events across multiple fields
    public List<Event> searchEvents(String searchQuery) {
        List<Event> eventList = new ArrayList<>();

        // If search query is empty, return all events
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            return getAllEvents();
        }

        String query = "SELECT * FROM Event WHERE Title LIKE ? OR Description LIKE ? OR venue LIKE ? ORDER BY Event_date DESC";

        try (Connection conn = getConnection()) {
            if (conn == null) {
                System.err.println("Unable to get connection in searchEvents");
                return eventList;
            }

            try (PreparedStatement ps = conn.prepareStatement(query)) {
                String searchTerm = "%" + searchQuery + "%";
                ps.setString(1, searchTerm);
                ps.setString(2, searchTerm);
                ps.setString(3, searchTerm);

                System.out.println("Executing event search query: " + query + " with term: " + searchQuery);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Event event = new Event();
                        event.setId(rs.getInt("Event_id"));
                        event.setName(rs.getString("Title"));

                        // Convert java.sql.Date to java.util.Date
                        java.sql.Date sqlDate = rs.getDate("Event_date");
                        if (sqlDate != null) {
                            event.setDateTime(new Date(sqlDate.getTime()));
                        }

                        // Calculate days until event
                        if (event.getDateTime() != null) {
                            Calendar eventDate = Calendar.getInstance();
                            eventDate.setTime(event.getDateTime());
                            Calendar today = Calendar.getInstance();
                            long diffMillis = eventDate.getTimeInMillis() - today.getTimeInMillis();
                            int diffDays = (int) (diffMillis / (24 * 60 * 60 * 1000));
                            event.setDaysUntilEvent(diffDays);
                        }

                        // Get related data
                        event.setDescription(rs.getString("Description"));
                        event.setVenue(rs.getString("venue"));

                        // Set default values for fields not in database
                        event.setManager(rs.getString("manager") != null ? rs.getString("manager") : "Not specified");
                        event.setApproved(rs.getBoolean("approved"));
                        event.setAttendees(rs.getInt("attendees"));

                        eventList.add(event);
                    }
                }

                System.out.println("Found " + eventList.size() + " events matching: " + searchQuery);
            }
        } catch (SQLException e) {
            System.err.println("Error searching events: " + e.getMessage());
            e.printStackTrace();
        }

        return eventList;
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