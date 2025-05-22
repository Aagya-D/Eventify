package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

/**
 * Data Access Object for ActivityLog operations
 */
public class ActivityLogDAO {
<<<<<<< HEAD
    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/eventify";
=======
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/eventify";
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Create activity log table if it doesn't exist
            createActivityLogTable();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Get database connection
    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }
<<<<<<< HEAD

=======
    
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
    /**
     * Create the activity_log table if it doesn't exist
     */
    private static void createActivityLogTable() {
        String query = "CREATE TABLE IF NOT EXISTS activity_log (" +
<<<<<<< HEAD
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "user_id INT NOT NULL, " +
                "username VARCHAR(50) NOT NULL, " +
                "action VARCHAR(50) NOT NULL, " +
                "description VARCHAR(255) NOT NULL, " +
                "timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                "FOREIGN KEY (user_id) REFERENCES user(User_id) ON DELETE CASCADE" +
                ")";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {

            stmt.execute(query);
            System.out.println("Activity log table created successfully");

=======
                      "id INT AUTO_INCREMENT PRIMARY KEY, " +
                      "user_id INT NOT NULL, " +
                      "username VARCHAR(50) NOT NULL, " +
                      "action VARCHAR(50) NOT NULL, " +
                      "description VARCHAR(255) NOT NULL, " +
                      "timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                      "FOREIGN KEY (user_id) REFERENCES user(User_id) ON DELETE CASCADE" +
                      ")";
                      
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
             
            stmt.execute(query);
            System.out.println("Activity log table created successfully");
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Check if table is empty and populate it with sample data if needed
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM activity_log");
            if (rs.next() && rs.getInt(1) == 0) {
                insertSampleActivityLogs();
            }
        } catch (SQLException e) {
            System.err.println("Error creating activity log table: " + e.getMessage());
            e.printStackTrace();
        }
    }
<<<<<<< HEAD

=======
    
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
    /**
     * Insert sample activity logs if the table is empty
     */
    private static void insertSampleActivityLogs() {
        String query = "INSERT INTO activity_log (user_id, username, action, description, timestamp) VALUES (?, ?, ?, ?, ?)";
<<<<<<< HEAD

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

=======
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Try to get some real user IDs
            List<User> users = UserDAO.getAllUsers();
            int adminId = 1;
            int userId1 = 2;
            int userId2 = 3;
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Use real user IDs if available
            if (!users.isEmpty()) {
                for (User user : users) {
                    if ("ADMIN".equals(user.getRole())) {
                        adminId = user.getUserId();
                    } else if (userId1 == 2) {
                        userId1 = user.getUserId();
                    } else if (userId2 == 3) {
                        userId2 = user.getUserId();
                    }
                }
            }
<<<<<<< HEAD

            // Sample activities with timestamps
            Date now = new Date();

=======
             
            // Sample activities with timestamps
            Date now = new Date();
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Admin activities
            insertActivityLog(ps, adminId, "admin", "ADD_EVENT", "Added event 'Summer Conference'", new Timestamp(now.getTime() - 3600000));
            insertActivityLog(ps, adminId, "admin", "ADD_VENUE", "Added venue 'Grand Hall'", new Timestamp(now.getTime() - 10800000));
            insertActivityLog(ps, adminId, "admin", "APPROVE_USER", "Approved user 'michael_brown'", new Timestamp(now.getTime() - 18000000));
<<<<<<< HEAD

            // User activities
            insertActivityLog(ps, userId1, "john_doe", "REGISTER", "Registered a new account", new Timestamp(now.getTime() - 7200000));
            insertActivityLog(ps, userId2, "sarah_smith", "BOOK_EVENT", "Booked event 'Tech Conference 2023'", new Timestamp(now.getTime() - 14400000));

=======
            
            // User activities
            insertActivityLog(ps, userId1, "john_doe", "REGISTER", "Registered a new account", new Timestamp(now.getTime() - 7200000));
            insertActivityLog(ps, userId2, "sarah_smith", "BOOK_EVENT", "Booked event 'Tech Conference 2023'", new Timestamp(now.getTime() - 14400000));
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            System.out.println("Sample activity logs inserted successfully");
        } catch (SQLException e) {
            System.err.println("Error inserting sample activity logs: " + e.getMessage());
            e.printStackTrace();
        }
    }
<<<<<<< HEAD

    private static void insertActivityLog(PreparedStatement ps, int userId, String username,
=======
    
    private static void insertActivityLog(PreparedStatement ps, int userId, String username, 
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                                          String action, String description, Timestamp timestamp) throws SQLException {
        ps.setInt(1, userId);
        ps.setString(2, username);
        ps.setString(3, action);
        ps.setString(4, description);
        ps.setTimestamp(5, timestamp);
        ps.executeUpdate();
    }

    /**
     * Log a new activity
     * @param userId ID of the user performing the action
     * @param action Type of action performed
     * @param description Description of the activity
     * @return true if logging successful, false otherwise
     */
    public static boolean logActivity(int userId, String action, String description) {
        try {
            // For system-generated logs (userId=0), use a default username
            String username = "System";
<<<<<<< HEAD

=======
            
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
            // Only try to get username if userId > 0
            if (userId > 0) {
                User user = UserDAO.getUserById(userId);
                if (user != null) {
                    username = user.getUserName();
                }
            }
<<<<<<< HEAD

            String query = "INSERT INTO activity_log (user_id, username, action, description, timestamp) VALUES (?, ?, ?, ?, ?)";

            try (Connection conn = getConnection();
                 PreparedStatement ps = conn.prepareStatement(query)) {

=======
            
            String query = "INSERT INTO activity_log (user_id, username, action, description, timestamp) VALUES (?, ?, ?, ?, ?)";
            
            try (Connection conn = getConnection();
                 PreparedStatement ps = conn.prepareStatement(query)) {
                 
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                ps.setInt(1, userId);
                ps.setString(2, username);
                ps.setString(3, action);
                ps.setString(4, description);
                ps.setTimestamp(5, new Timestamp(new Date().getTime()));
<<<<<<< HEAD

=======
                
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                int result = ps.executeUpdate();
                return result > 0;
            } catch (SQLException e) {
                // Just log the error and continue - don't let activity logging failure break the application
                System.err.println("Error logging activity: " + e.getMessage());
                e.printStackTrace();
            }
        } catch (Exception e) {
            System.err.println("Error in logActivity: " + e.getMessage());
            e.printStackTrace();
        }
        // Return true even if logging failed - we don't want this to affect the main functionality
        return true;
    }

    /**
     * Get recent activities for the admin dashboard
     * @param limit Number of activities to retrieve
     * @return List of recent activities
     */
    public static List<ActivityLog> getRecentActivities(int limit) {
        List<ActivityLog> activities = new ArrayList<>();
        String query = "SELECT * FROM activity_log ORDER BY timestamp DESC LIMIT ?";
<<<<<<< HEAD

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ActivityLog log = new ActivityLog(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("action"),
                        rs.getString("description"),
                        new Date(rs.getTimestamp("timestamp").getTime())
=======
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ActivityLog log = new ActivityLog(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("action"),
                    rs.getString("description"),
                    new Date(rs.getTimestamp("timestamp").getTime())
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
                );
                activities.add(log);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving activities: " + e.getMessage());
            e.printStackTrace();
        }
<<<<<<< HEAD

=======
        
>>>>>>> aef66794032f4b8c01fedecd54e356dd30662ecc
        return activities;
    }
} 