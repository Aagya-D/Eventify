package model;

public class Venue {
    private int id;
    private String name;
    private String address;
    private String city;
    private String contactNumber;
    private int capacity;

    // Constructors
    public Venue() {
    }

    public Venue(int id, String name, String address, String city, String contactNumber, int capacity) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.city = city;
        this.contactNumber = contactNumber;
        this.capacity = capacity;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }
}
