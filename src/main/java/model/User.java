package model;

import java.util.Date;
import java.util.regex.Pattern;

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

    // Validation patterns
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\+?[1-9]\\d{1,14}$");
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_]{3,20}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$");

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

    // Validation methods
    public boolean isValidEmail() {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    public boolean isValidPhone() {
        return phone == null || phone.isEmpty() || PHONE_PATTERN.matcher(phone).matches();
    }

    public boolean isValidUsername() {
        return userName != null && USERNAME_PATTERN.matcher(userName).matches();
    }

    public boolean isValidPassword() {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }

    public boolean isValid() {
        return isValidUsername() && isValidEmail() && isValidPassword() && isValidPhone();
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
        if (userName != null && USERNAME_PATTERN.matcher(userName).matches()) {
            this.userName = userName;
        } else {
            throw new IllegalArgumentException("Invalid username format");
        }
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
        if (email != null && EMAIL_PATTERN.matcher(email).matches()) {
            this.email = email;
        } else {
            throw new IllegalArgumentException("Invalid email format");
        }
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        if (phone == null || phone.isEmpty() || PHONE_PATTERN.matcher(phone).matches()) {
            this.phone = phone;
        } else {
            throw new IllegalArgumentException("Invalid phone number format");
        }
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        if (password != null && PASSWORD_PATTERN.matcher(password).matches()) {
            this.password = password;
        } else {
            throw new IllegalArgumentException("Invalid password format");
        }
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
