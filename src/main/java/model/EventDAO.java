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
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    // Get database connection
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    public List<Event> getAllEvents() {
        List<Event> eventList = new ArrayList<>();
        
        try {
            // In a real application, you would fetch this from a database
            // For now, we'll create sample events
            eventList.add(createSampleEvent(1, "New Year Eve", 10));
            eventList.add(createSampleEvent(2, "Rice Pudding Ceremony", 15));
            eventList.add(createSampleEvent(3, "Graduation Ceremony", 30));
            eventList.add(createSampleEvent(4, "Beauty Pageant", 45));
            eventList.add(createSampleEvent(5, "Baby Shower", 7));
            eventList.add(createSampleEvent(6, "Press Conference", 3));
            eventList.add(createSampleEvent(7, "Christmas Party", 90));
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return eventList;
    }
    
    private Event createSampleEvent(int id, String name, int daysAhead) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, daysAhead);
        Date eventDate = calendar.getTime();
        
        String venue = "Venue " + id;
        String description = "Description for " + name;
        String manager = "Manager " + id;
        boolean approved = true;
        int attendees = 50 + (id * 10);
        
        return new Event(id, name, eventDate, daysAhead, venue, description, manager, approved, attendees);
    }
    
    public Event getEventById(int eventId) {
        for (Event event : getAllEvents()) {
            if (event.getId() == eventId) {
                return event;
            }
        }
        return null;
    }
    
    public boolean addEvent(Event event) {
        // In a real application, you would add this to a database
        // For now, we'll just return true
        return true;
    }
    
    public boolean updateEvent(Event event) {
        // In a real application, you would update this in a database
        // For now, we'll just return true
        return true;
    }
    
    public boolean deleteEvent(int eventId) {
        // In a real application, you would delete this from a database
        // For now, we'll just return true
        return true;
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
    
    // Method to get count of approved events
    public int getApprovedEventCount() {
        String query = "SELECT COUNT(*) AS count FROM Event WHERE Approved = true";
        
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
        String query = "SELECT * FROM Event ORDER BY Event_date DESC LIMIT ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("Event_id"));
                event.setName(rs.getString("Title"));
                event.setDateTime(rs.getTimestamp("Event_date"));
                event.setVenue(rs.getString("Category")); // Using category as venue temporarily
                event.setDescription(rs.getString("Description"));
                event.setApproved(rs.getBoolean("Approved"));
                events.add(event);
            }
        } catch (SQLException e) {
            System.err.println("Error getting recent events: " + e.getMessage());
            e.printStackTrace();
        }
        
        return events;
    }
}