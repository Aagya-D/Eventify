package model;

import java.util.Date;

public class Event {
    private int id;
    private String name;
    private Date dateTime;
    private int daysUntilEvent;
    private String venue;
    private String description;
    private String manager;
    private boolean approved;
    private int attendees;

    // Constructors
    public Event() {
    }

    public Event(int id, String name, Date dateTime, int daysUntilEvent, String venue,
                 String description, String manager, boolean approved, int attendees) {
        this.id = id;
        this.name = name;
        this.dateTime = dateTime;
        this.daysUntilEvent = daysUntilEvent;
        this.venue = venue;
        this.description = description;
        this.manager = manager;
        this.approved = approved;
        this.attendees = attendees;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDateTime() {
        return dateTime;
    }

    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }

    public int getDaysUntilEvent() {
        return daysUntilEvent;
    }

    public void setDaysUntilEvent(int daysUntilEvent) {
        this.daysUntilEvent = daysUntilEvent;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public boolean isApproved() {
        return approved;
    }

    public void setApproved(boolean approved) {
        this.approved = approved;
    }

    public int getAttendees() {
        return attendees;
    }

    public void setAttendees(int attendees) {
        this.attendees = attendees;
    }
}