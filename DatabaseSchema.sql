--Create the database
CREATE DATABASE eventify;

-- Use the database
USE eventify;

-- Create the User table
CREATE TABLE User (
                        User_id INT AUTO_INCREMENT PRIMARY KEY,
                        User_name VARCHAR(100),
                        Role VARCHAR(50),
                        Email VARCHAR(100),
                        Phone VARCHAR(20),
                        Password VARCHAR(100),
                        CreatedAt DATETIME
);

-- Create the Venue table
CREATE TABLE Venue (
                       Venue_id INT AUTO_INCREMENT PRIMARY KEY,
                       Name VARCHAR(100),
                       Address VARCHAR(255),
                       City VARCHAR(100),
                       Contact_number BIGINT,
                       Capacity INT
);

-- Create the Event table
CREATE TABLE Event (
                       Event_id INT AUTO_INCREMENT PRIMARY KEY,
                       Title VARCHAR(100),
                       Description TEXT,
                       Event_date DATE,
                       Category VARCHAR(50),
                       CreatedAt DATETIME
);

-- Create the Event_Venue junction table
CREATE TABLE Event_Venue (
                             Event_id INT,
                             Venue_id INT,
                             PRIMARY KEY (Event_id, Venue_id),
                             FOREIGN KEY (Event_id) REFERENCES Event(Event_id),
                             FOREIGN KEY (Venue_id) REFERENCES Venue(Venue_id)
);

-- Create the User_Event junction table
CREATE TABLE User_Event (
                            Event_id INT,
                            User_id INT,
                            PRIMARY KEY (Event_id, User_id),
                            FOREIGN KEY (Event_id) REFERENCES Event(Event_id),
                            FOREIGN KEY (User_id) REFERENCES `User`(User_id)
);

-- Create the Feedback table
CREATE TABLE Feedback (
                          Feedback_id INT AUTO_INCREMENT PRIMARY KEY,
                          Subject VARCHAR(255),
                          Message TEXT,
                          SubmittedAt DATETIME
);

-- Create the User_Feedback junction table
CREATE TABLE User_Feedback (
                               Feedback_id INT,
                               Event_id INT,
                               User_id INT,
                               PRIMARY KEY (Feedback_id),
                               FOREIGN KEY (Feedback_id) REFERENCES Feedback(Feedback_id),
                               FOREIGN KEY (Event_id) REFERENCES Event(Event_id),
                               FOREIGN KEY (User_id) REFERENCES User(User_id)
);
