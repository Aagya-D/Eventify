package model;

import java.sql.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class UserDAO {
    //Instance variables for database connection
    private static final String URL = "jdbc:mysql://localhost:3308/eventify";
    private static final String USER = "root";
    private static final String PASS = "";

    static{
        //Calling the driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
    //Method for database connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
    //Method for storing user into database
    // Method to Add User to Database
    public static int addUser(User user) {
        String query = "INSERT INTO user (User_name, Role, Email, Password, CreatedAt) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getUserName());
            ps.setString(2, user.getRole());
            ps.setString(3, user.getEmail());
            ps.setString(4, hashPassword(user.getPassword())); // Hash password before storing
            ps.setTimestamp(5, new Timestamp(user.getCreatedAt().getTime()));

            // Execute Update
            int affectedRows = ps.executeUpdate();

            // Retrieve Auto-Generated User ID
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Return the new user ID
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in addUser: " + e.getMessage());
            if (e.getSQLState().equals("23000")) {
                System.err.println("Duplicate entry - user with this username or email already exists");
            }
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("General Error in addUser: " + e.getMessage());
            e.printStackTrace();
        }
        return -1; // Return -1 if insertion fails
    }

    // Method to authenticate user
    public static User getUserByEmailOrUsername(String emailOrUsername, String password) {
        String query = "SELECT * FROM user WHERE (Email = ? OR User_name = ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, emailOrUsername);
            ps.setString(2, emailOrUsername);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("Password");

                // Use the new verification method
                if (verifyPassword(password, storedPassword)) {
                    User user = new User(
                            rs.getInt("User_id"),
                            rs.getString("User_name"),
                            rs.getString("Role"),
                            rs.getString("Email"),
                            rs.getString("Phone"),
                            storedPassword, // Store the hashed password
                            rs.getTimestamp("CreatedAt")
                    );
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getUserByEmailOrUsername: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if authentication fails
    }
    // Method to update user details
    public static boolean updateUser(User user) {
        String query = "UPDATE user SET Password = ?, Phone = ? WHERE User_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, hashPassword(user.getPassword())); // Hash password before storing
            ps.setString(2, user.getPhone());
            ps.setInt(3, user.getUserId());

            // Execute update and check if successful
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0; // Returns true if update was successful

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return false; // Return false if update fails
    }

    // Method to update user password
    public static boolean updatePassword(int userId, String currentPassword, String newPassword) {
        // First verify the current password
        String verifyQuery = "SELECT Password FROM user WHERE User_id = ?";
        String updateQuery = "UPDATE user SET Password = ? WHERE User_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement psVerify = conn.prepareStatement(verifyQuery);
             PreparedStatement psUpdate = conn.prepareStatement(updateQuery)) {

            // Verify current password
            psVerify.setInt(1, userId);
            ResultSet rs = psVerify.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("Password");
                String hashedCurrentPassword = hashPassword(currentPassword);

                // If current password matches, update to new password
                if (storedPassword.equals(hashedCurrentPassword)) {
                    psUpdate.setString(1, hashPassword(newPassword)); // Hash the new password
                    psUpdate.setInt(2, userId);

                    int affectedRows = psUpdate.executeUpdate();
                    return affectedRows > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }

        return false; // Return false if password update fails
    }

    // Method to delete user by username/email and password
    public static boolean deleteUser(String emailOrUsername, String password) {
        String queryCheck = "SELECT User_id, Password FROM user WHERE (Email = ? OR User_name = ?)";
        String queryDelete = "DELETE FROM user WHERE User_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement psCheck = conn.prepareStatement(queryCheck);
             PreparedStatement psDelete = conn.prepareStatement(queryDelete)) {

            // Step 1: Check if the username/email and password match
            psCheck.setString(1, emailOrUsername);
            psCheck.setString(2, emailOrUsername);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("User_id");
                String storedPassword = rs.getString("Password");
                String hashedPassword = hashPassword(password);

                if (!storedPassword.equals(hashedPassword)) { // Compare passwords
                    System.out.println("Incorrect password. User deletion failed.");
                    return false;
                }

                // Step 2: If password matches, delete the user
                psDelete.setInt(1, userId);
                int affectedRows = psDelete.executeUpdate();
                return affectedRows > 0; // Returns true if deletion was successful
            } else {
                System.out.println("User not found with that username/email.");
                return false;
            }

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return false; // Return false if deletion fails
    }

    // Hash password using SHA-256 with salt
    private static String hashPassword(String password) {
        try {
            // Generate a random salt for each password
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);

            // Use PBKDF2WithHmacSHA256 for more secure hashing with salt
            KeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 65536, 128);
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

            byte[] hash = factory.generateSecret(spec).getEncoded();

            // Combine salt and hash together
            byte[] combined = new byte[salt.length + hash.length];
            System.arraycopy(salt, 0, combined, 0, salt.length);
            System.arraycopy(hash, 0, combined, salt.length, hash.length);

            // Convert to Base64 for storage
            return Base64.getEncoder().encodeToString(combined);
        } catch (Exception e) {
            System.err.println("Error hashing password: " + e.getMessage());
            e.printStackTrace();
            // Fallback to simple hashing if PBKDF2 fails
            return simpleHash(password);
        }
    }

    // Verify password against stored hash
    private static boolean verifyPassword(String password, String storedHash) {
        try {
            // Decode from Base64
            byte[] combined = Base64.getDecoder().decode(storedHash);

            // Extract salt (first 16 bytes)
            byte[] salt = new byte[16];
            System.arraycopy(combined, 0, salt, 0, salt.length);

            // Hash the provided password with the same salt
            KeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 65536, 128);
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            byte[] hash = factory.generateSecret(spec).getEncoded();

            // Check if the hash matches
            int hashOffset = salt.length;
            for (int i = 0; i < hash.length; i++) {
                if (hash[i] != combined[i + hashOffset]) {
                    return false;
                }
            }
            return true;
        } catch (Exception e) {
            System.err.println("Error verifying password: " + e.getMessage());
            e.printStackTrace();
            // Fallback to simple hash verification
            return storedHash.equals(simpleHash(password));
        }
    }

    // Fallback simple hashing using SHA-256 (for backward compatibility)
    private static String simpleHash(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedhash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedhash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            System.err.println("Error hashing password: " + e.getMessage());
            return null;
        }
    }

    // Method to get total user count for admin dashboard
    public static int getUserCount() {
        String query = "SELECT COUNT(*) AS count FROM user";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            System.err.println("Error counting users: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    // Method to get all users for admin dashboard
    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM user ORDER BY User_id";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User(
                        rs.getInt("User_id"),
                        rs.getString("User_name"),
                        rs.getString("Role"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("Password"),
                        rs.getTimestamp("CreatedAt")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all users: " + e.getMessage());
            e.printStackTrace();
        }

        return users;
    }

    // Method to get a user by ID
    public static User getUserById(int userId) {
        String query = "SELECT * FROM user WHERE User_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User(
                        rs.getInt("User_id"),
                        rs.getString("User_name"),
                        rs.getString("Role"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("Password"),
                        rs.getTimestamp("CreatedAt")
                );
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    // Method for admin to update user details
    public static boolean updateUserByAdmin(User user) {
        String query = "UPDATE user SET User_name = ?, Role = ?, Email = ? WHERE User_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user.getUserName());
            ps.setString(2, user.getRole());
            ps.setString(3, user.getEmail());
            ps.setInt(4, user.getUserId());

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user by admin: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    // Method to delete a user by ID
    public static boolean deleteUserById(int userId) {
        String query = "DELETE FROM user WHERE User_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting user by ID: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }
}
