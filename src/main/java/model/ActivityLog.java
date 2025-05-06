package model;

import java.util.Date;

/**
 * Class representing an activity log entry in the system
 */
public class ActivityLog {
    private int id;
    private int userId;
    private String userName;
    private String action;
    private String description;
    private Date timestamp;
    
    // Constructors
    public ActivityLog() {
    }
    
    public ActivityLog(int id, int userId, String userName, String action, String description, Date timestamp) {
        this.id = id;
        this.userId = userId;
        this.userName = userName;
        this.action = action;
        this.description = description;
        this.timestamp = timestamp;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
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
    
    public String getAction() {
        return action;
    }
    
    public void setAction(String action) {
        this.action = action;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Date getTimestamp() {
        return timestamp;
    }
    
    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }
} 