package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VenueDAO {
    private Connection connection;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/eventify";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "password";

    public VenueDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Venue> getAllVenues() {
        List<Venue> venueList = new ArrayList<>();

        try {
            // In a real application, you would fetch this from a database
            // For now, we'll create sample venues
            venueList.add(createSampleVenue(1, "Grand Hall", "123 Main St", "12345", "555-0123", "www.grandhall.com", "info@grandhall.com"));
            venueList.add(createSampleVenue(2, "City Center", "456 Park Ave", "67890", "555-0124", "www.citycenter.com", "info@citycenter.com"));
            venueList.add(createSampleVenue(3, "Riverside Plaza", "789 River Rd", "13579", "555-0125", "www.riverside.com", "info@riverside.com"));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return venueList;
    }

    private Venue createSampleVenue(int id, String name, String address, String zipCode, String phone, String web, String email) {
        return new Venue(id, name, address, zipCode, phone, web, email);
    }

    public Venue getVenueById(int venueId) {
        for (Venue venue : getAllVenues()) {
            if (venue.getId() == venueId) {
                return venue;
            }
        }
        return null;
    }

    public boolean addVenue(Venue venue) {
        // In a real application, you would add this to a database
        // For now, we'll just return true
        return true;
    }

    public boolean updateVenue(Venue venue) {
        // In a real application, you would update this in a database
        // For now, we'll just return true
        return true;
    }

    public boolean deleteVenue(int venueId) {
        // In a real application, you would delete this from a database
        // For now, we'll just return true
        return true;
    }

    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
 }
}
}
