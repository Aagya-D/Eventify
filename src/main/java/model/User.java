package model;

import java.util.Date;

public class User {
    // Instance variables that match the database schema
    private int userId;
    private String userName;
    private String role;
    private String email;
    private String phone;
    private String password;
    private Date createdAt;
    private String fullName; // Added for compatibility

    // Constructors
    public User() {
    }

    public User(String userName, String email, String password) {
        this.userName = userName;
        this.fullName = userName; // Use username as fullName for backwards compatibility
        this.email = email;
        this.password = password;
        this.role = "USER"; // Default role
        this.createdAt = new Date(); // Current date/time
    }

    public User(int userId, String userName, String role, String email, String phone, String password, Date createdAt) {
        this.userId = userId;
        this.userName = userName;
        this.fullName = userName; // Use username as fullName for backwards compatibility
        this.role = role;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.createdAt = createdAt;
    }

    // Getters and setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    // For backward compatibility (these methods help transition from old code)
    public int getId() {
        return getUserId();
    }
    
    public void setId(int id) {
        setUserId(id);
    }
    
    public String getUsername() {
        return getUserName();
    }
    
    public void setUsername(String username) {
        setUserName(username);
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
}
