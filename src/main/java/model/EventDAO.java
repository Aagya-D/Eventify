package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class EventDAO {
    // Database connection parameters
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
                System.out.println("Database connection successful!");
            } catch (SQLException e) {
                System.err.println("Database connection test failed: " + e.getMessage());
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
        String query = "SELECT * FROM event ORDER BY event_date DESC";
        
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
                    event.setId(rs.getInt("event_id"));
                    event.setName(rs.getString("title"));
                    event.setDateTime(rs.getTimestamp("event_date"));
                    
                    // Calculate days until event
                    Calendar eventDate = Calendar.getInstance();
                    eventDate.setTime(rs.getTimestamp("event_date"));
                    Calendar today = Calendar.getInstance();
                    long diffMillis = eventDate.getTimeInMillis() - today.getTimeInMillis();
                    int diffDays = (int) (diffMillis / (24 * 60 * 60 * 1000));
                    event.setDaysUntilEvent(diffDays);
                    
                    // Get related data
                    event.setVenue(rs.getString("venue"));
                    event.setDescription(rs.getString("description"));
                    event.setManager(rs.getString("manager"));
                    event.setApproved(rs.getBoolean("approved"));
                    event.setAttendees(rs.getInt("attendees"));
                    
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
        String query = "SELECT * FROM event WHERE event_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("event_id"));
                event.setName(rs.getString("title"));
                event.setDateTime(rs.getTimestamp("event_date"));
                
                // Calculate days until event
                Calendar eventDate = Calendar.getInstance();
                eventDate.setTime(rs.getTimestamp("event_date"));
                Calendar today = Calendar.getInstance();
                long diffMillis = eventDate.getTimeInMillis() - today.getTimeInMillis();
                int diffDays = (int) (diffMillis / (24 * 60 * 60 * 1000));
                event.setDaysUntilEvent(diffDays);
                
                // Get related data
                event.setVenue(rs.getString("venue"));
                event.setDescription(rs.getString("description"));
                event.setManager(rs.getString("manager"));
                event.setApproved(rs.getBoolean("approved"));
                event.setAttendees(rs.getInt("attendees"));
                
                return event;
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving event: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean addEvent(Event event) {
        String query = "INSERT INTO event (title, event_date, venue, description, manager, approved, attendees) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setString(1, event.getName());
            ps.setTimestamp(2, new Timestamp(event.getDateTime().getTime()));
            ps.setString(3, event.getVenue());
            ps.setString(4, event.getDescription());
            ps.setString(5, event.getManager());
            ps.setBoolean(6, event.isApproved());
            ps.setInt(7, event.getAttendees());
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                // Log the activity
                User user = (User) getCaller();
                if (user != null) {
                    ActivityLogDAO.logActivity(user.getUserId(), "ADD_EVENT", "Added event '" + event.getName() + "'");
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error adding event: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    public boolean updateEvent(Event event) {
        String query = "UPDATE event SET title = ?, event_date = ?, venue = ?, description = ?, " +
                      "manager = ?, approved = ?, attendees = ? WHERE event_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setString(1, event.getName());
            ps.setTimestamp(2, new Timestamp(event.getDateTime().getTime()));
            ps.setString(3, event.getVenue());
            ps.setString(4, event.getDescription());
            ps.setString(5, event.getManager());
            ps.setBoolean(6, event.isApproved());
            ps.setInt(7, event.getAttendees());
            ps.setInt(8, event.getId());
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                // Log the activity
                User user = (User) getCaller();
                if (user != null) {
                    ActivityLogDAO.logActivity(user.getUserId(), "UPDATE_EVENT", "Updated event '" + event.getName() + "'");
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error updating event: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    public boolean deleteEvent(int eventId) {
        // First get the event name for logging
        Event event = getEventById(eventId);
        if (event == null) return false;
        
        String query = "DELETE FROM event WHERE event_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, eventId);
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                // Log the activity
                User user = (User) getCaller();
                if (user != null) {
                    ActivityLogDAO.logActivity(user.getUserId(), "DELETE_EVENT", "Deleted event '" + event.getName() + "'");
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error deleting event: " + e.getMessage());
            e.printStackTrace();
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
        String query = "SELECT COUNT(*) AS count FROM event";
        
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
    
    // Method to get count of approved events
    public int getApprovedEventCount() {
        String query = "SELECT COUNT(*) AS count FROM event WHERE approved = true";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            System.err.println("Error counting approved events: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Method to get recent events for dashboard
    public List<Event> getRecentEvents(int limit) {
        List<Event> events = new ArrayList<>();
        String query = "SELECT * FROM event ORDER BY event_date DESC LIMIT ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("event_id"));
                event.setName(rs.getString("title"));
                event.setDateTime(rs.getTimestamp("event_date"));
                event.setVenue(rs.getString("venue"));
                event.setDescription(rs.getString("description"));
                event.setManager(rs.getString("manager"));
                event.setApproved(rs.getBoolean("approved"));
                event.setAttendees(rs.getInt("attendees"));
                events.add(event);
            }
        } catch (SQLException e) {
            System.err.println("Error getting recent events: " + e.getMessage());
            e.printStackTrace();
        }
        
        return events;
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