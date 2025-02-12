
CREATE DATABASE DonorTrackingSystem;
USE DonorTrackingSystem;

-- Creating Donor Table
CREATE TABLE Donor (
    Donor_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Email_Address VARCHAR(100) UNIQUE NOT NULL,
    Career_Details VARCHAR(100) NULL
);

-- Creating Donor_Phone Table
CREATE TABLE Donor_Phone (
    Donor_ID INT,
    Phone_Number VARCHAR(10) NOT NULL CHECK (LENGTH(Phone_Number) = 10),
    PRIMARY KEY (Donor_ID, Phone_Number),
    FOREIGN KEY (Donor_ID) REFERENCES Donor(Donor_ID) ON DELETE CASCADE
);


-- Creating Event Table
CREATE TABLE Event (
    Event_ID INT PRIMARY KEY AUTO_INCREMENT,
    Event_Name VARCHAR(100) NOT NULL,
    Event_Date DATE NOT NULL,
    Country VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Street_Name VARCHAR(100) NULL,
    Building_Number VARCHAR(10) NULL,
    Type VARCHAR(50) NOT NULL
);

-- Creating Communication_History Table
CREATE TABLE Communication_History (
    Communication_ID INT PRIMARY KEY AUTO_INCREMENT,
    Donor_ID INT,
    Event_ID INT,
    Type_of_Communication VARCHAR(50) NOT NULL,
    Date DATE NOT NULL,
    Notes VARCHAR(255) NULL,
    Follow_Up_Required BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (Donor_ID) REFERENCES Donor(Donor_ID) ON DELETE SET NULL,
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID) ON DELETE SET NULL
);

-- Creating Donation Table
CREATE TABLE Donation (
    Donation_ID INT PRIMARY KEY AUTO_INCREMENT,
    Donor_ID INT,
    Date DATE NOT NULL,
    Amount DECIMAL(10,2) CHECK(Amount > 0) NOT NULL,
    Donation_Type VARCHAR(50) NOT NULL,
    Method_of_Payment VARCHAR(50) NOT NULL,
    FOREIGN KEY (Donor_ID) REFERENCES Donor(Donor_ID) ON DELETE CASCADE
);

-- Creating Donor_Event Table
CREATE TABLE Donor_Event (
    Donor_ID INT,
    Event_ID INT,
    Participation_Role VARCHAR(50) NOT NULL,
    PRIMARY KEY (Donor_ID, Event_ID),
    FOREIGN KEY (Donor_ID) REFERENCES Donor(Donor_ID) ON DELETE CASCADE,
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID) ON DELETE CASCADE
);

-- Creating Donation_Event Table
CREATE TABLE Donation_Event (
    Donation_ID INT,
    Event_ID INT,
    Purpose VARCHAR(255) NOT NULL,
    PRIMARY KEY (Donation_ID, Event_ID),
    FOREIGN KEY (Donation_ID) REFERENCES Donation(Donation_ID) ON DELETE CASCADE,
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID) ON DELETE CASCADE
);



-- Ensuring Referential Integrity via Explicit Constraints
ALTER TABLE Donor_Phone
ADD CONSTRAINT FK_DonorPhone_Donor FOREIGN KEY (Donor_ID) 
REFERENCES Donor(Donor_ID) ON DELETE CASCADE;

ALTER TABLE Communication_History
ADD CONSTRAINT FK_Communication_Donor FOREIGN KEY (Donor_ID) 
REFERENCES Donor(Donor_ID) ON DELETE SET NULL;

ALTER TABLE Communication_History
ADD CONSTRAINT FK_Communication_Event FOREIGN KEY (Event_ID) 
REFERENCES Event(Event_ID) ON DELETE SET NULL;

ALTER TABLE Donation
ADD CONSTRAINT FK_Donation_Donor FOREIGN KEY (Donor_ID) 
REFERENCES Donor(Donor_ID) ON DELETE CASCADE;

ALTER TABLE Donor_Event
ADD CONSTRAINT FK_DonorEvent_Donor FOREIGN KEY (Donor_ID) 
REFERENCES Donor(Donor_ID) ON DELETE CASCADE;

ALTER TABLE Donor_Event
ADD CONSTRAINT FK_DonorEvent_Event FOREIGN KEY (Event_ID) 
REFERENCES Event(Event_ID) ON DELETE CASCADE;

ALTER TABLE Donation_Event
ADD CONSTRAINT FK_DonationEvent_Donation FOREIGN KEY (Donation_ID) 
REFERENCES Donation(Donation_ID) ON DELETE CASCADE;

ALTER TABLE Donation_Event
ADD CONSTRAINT FK_DonationEvent_Event FOREIGN KEY (Event_ID) 
REFERENCES Event(Event_ID) ON DELETE CASCADE;



--  Inserting Meaningful Data


-- Inserting Donors (Ensuring Primary Key Uniqueness for Donors)
INSERT INTO Donor (First_Name, Last_Name, Date_of_Birth, Email_Address, Career_Details)
VALUES
('John', 'Doe', '1985-06-15', 'johndoe@email.com', 'Software Engineer'),
('Jane', 'Smith', '1990-03-22', 'janesmith@email.com', 'Doctor'),
('Robert', 'Brown', '1978-12-10', 'robertbrown@email.com', 'Teacher'),
('Emily', 'Davis', '1995-07-30', 'emilydavis@email.com', 'Marketing Manager'),
('Michael', 'Wilson', '1982-04-05', 'michaelwilson@email.com', 'Business Consultant');

-- Inserting Donor Phone Numbers (Multi-Valued Attribute - Demonstrates 1:M Relationship)
INSERT INTO Donor_Phone (Donor_ID, Phone_Number)
VALUES
(1, '1234567890'), (1, '0987654321'), -- Donor 1 has multiple phone numbers
(2, '2233445566'),
(3, '3344556677'), (3, '7788990011'), -- Donor 3 has multiple phone numbers
(4, '4455667788'),
(5, '5566778899');

-- Inserting Events (Demonstrating Unique Event Occurrences)
INSERT INTO Event (Event_Name, Event_Date, Country, City, Street_Name, Building_Number, Type)
VALUES
('Charity Gala', '2024-05-12', 'USA', 'New York', '5th Avenue', '100', 'Fundraising'),
('Blood Donation Drive', '2024-06-20', 'UK', 'London', 'Main Street', '20', 'Health'),
('Education Awareness Seminar', '2024-07-15', 'Canada', 'Toronto', 'Queen Street', '50', 'Education'),
('Food Distribution Campaign', '2024-08-10', 'India', 'Mumbai', 'Central Road', '30', 'Social Work');

-- Inserting Communication History (Ensuring Logical Donor-Event Interactions, Demonstrating Donor → Communication_History 1:M Relationship)
INSERT INTO Communication_History (Donor_ID, Event_ID, Type_of_Communication, Date, Notes, Follow_Up_Required)
VALUES
(1, 1, 'Email', '2024-04-10', 'Sent invitation for Charity Gala', TRUE),
(2, 2, 'Phone Call', '2024-04-15', 'Confirmed participation in Blood Donation Drive', FALSE),
(2, 3, 'Email', '2024-04-18', 'Received follow-up for Education Awareness Seminar', TRUE),
(2, 4, 'SMS', '2024-04-20', 'Sent reminder for Food Distribution Campaign', FALSE),
(3, 3, 'SMS', '2024-04-18', 'Sent reminders for Education Awareness Seminar', TRUE);

-- Inserting Donations (1:M Relationship between Donors and Donations, Demonstrating Donor → Donation Relationship)
INSERT INTO Donation (Donor_ID, Date, Amount, Donation_Type, Method_of_Payment)
VALUES
(1, '2024-05-15', 500.00, 'Money', 'Credit Card'),
(1, '2024-06-01', 300.00, 'Clothes', 'N/A'),
(1, '2024-07-10', 250.00, 'Books', 'N/A'),
(2, '2024-06-22', 300.00, 'Blood', 'N/A'),
(3, '2024-07-18', 200.00, 'Books', 'N/A'),
(4, '2024-08-12', 700.00, 'Money', 'Bank Transfer'),
(5, '2024-08-15', 1000.00, 'Food', 'Cash');

-- Inserting Donor Participation in Events (M:N Relationship between Donors and Events, Demonstrating Donor_Event Relationship)
INSERT INTO Donor_Event (Donor_ID, Event_ID, Participation_Role)
VALUES
(1, 1, 'Speaker'), -- Donor 1 is speaking at the Charity Gala
(2, 2, 'Volunteer'), -- Donor 2 is volunteering at the Blood Donation Drive
(2, 3, 'Guest'), -- Donor 2 is also attending Education Awareness Seminar
(3, 3, 'Organizer'), -- Donor 3 is organizing the Education Awareness Seminar
(4, 4, 'Donor'), -- Donor 4 is a donor at the Food Distribution Campaign
(5, 1, 'VIP Guest'), -- Donor 5 is a special guest at the Charity Gala
(5, 2, 'Attendee'); -- Donor 5 is attending Blood Donation Drive

-- Inserting Donations Linked to Events (M:N Relationship Demonstrated Between Donations and Events, Demonstrating Donation_Event Relationship)
INSERT INTO Donation_Event (Donation_ID, Event_ID, Purpose)
VALUES
(1, 1, 'Funding the Charity Gala'), -- Donation 1 funds Charity Gala
(1, 2, 'Helping Blood Donation Drive'), -- Same Donation 1 also supports Blood Donation Drive
(2, 2, 'Supporting Blood Donation Drive'), -- Donation 2 supports Blood Donation Drive
(3, 3, 'Providing Educational Materials'), -- Donation 3 provides books for seminar
(4, 4, 'Funding Food Distribution'), -- Donation 4 funds Food Distribution Campaign
(5, 1, 'Additional Event Expenses'), -- Donation 5 is for additional expenses for the Charity Gala
(5, 4, 'Food for Distribution'); -- Same Donation 5 also helps Food Distribution Campaign



-- Creating Meaningful Views


-- View: Donor Contribution Summary
-- Purpose: Shows total contributions made by each donor across all donations.
CREATE VIEW DonorDonationSummary AS
SELECT d.Donor_ID, d.First_Name, d.Last_Name, SUM(dn.Amount) AS Total_Donations
FROM Donor d
JOIN Donation dn ON d.Donor_ID = dn.Donor_ID
GROUP BY d.Donor_ID, d.First_Name, d.Last_Name;

-- Selecting from DonorDonationSummary
SELECT * FROM DonorDonationSummary;

-- View: Donor Participation in Events
-- Purpose: Tracks which donors participated in which events and their roles.
CREATE VIEW DonorParticipation AS
SELECT de.Donor_ID, d.First_Name, d.Last_Name, e.Event_Name, de.Participation_Role
FROM Donor_Event de
JOIN Donor d ON de.Donor_ID = d.Donor_ID
JOIN Event e ON de.Event_ID = e.Event_ID;

-- Selecting from DonorParticipation
SELECT * FROM DonorParticipation;

-- View: Event-Wise Donations
-- Purpose: Displays the donations associated with different events.
CREATE VIEW EventDonations AS
SELECT e.Event_Name, dn.Amount, dn.Donation_Type, d.First_Name, d.Last_Name
FROM Donation dn
JOIN Donation_Event de ON dn.Donation_ID = de.Donation_ID
JOIN Event e ON de.Event_ID = e.Event_ID
JOIN Donor d ON dn.Donor_ID = d.Donor_ID;

-- Selecting from EventDonations
SELECT * FROM EventDonations;

-- View: Communication History Log
-- Purpose: Shows communication records between donors and events.
CREATE VIEW CommunicationLog AS
SELECT ch.Communication_ID, d.First_Name, d.Last_Name, e.Event_Name, 
       ch.Type_of_Communication, ch.Date, ch.Notes, ch.Follow_Up_Required
FROM Communication_History ch
JOIN Donor d ON ch.Donor_ID = d.Donor_ID
JOIN Event e ON ch.Event_ID = e.Event_ID;

-- Selecting from CommunicationLog
SELECT * FROM CommunicationLog;

-- View: Top Donors by Contribution
-- Purpose: Helps identify and recognize top donors based on total contributions.
CREATE VIEW TopDonors AS
SELECT d.Donor_ID, d.First_Name, d.Last_Name, SUM(dn.Amount) AS Total_Donated
FROM Donor d
JOIN Donation dn ON d.Donor_ID = dn.Donor_ID
GROUP BY d.Donor_ID, d.First_Name, d.Last_Name
ORDER BY Total_Donated DESC
LIMIT 10;

-- Selecting from TopDonors
SELECT * FROM TopDonors;






-- Creating Stored Procedures for Data Management

-- Stored Procedure: Insert a New Donor
-- Purpose: Adds a new donor to the database.
DELIMITER $$
CREATE PROCEDURE InsertDonor (
    IN p_First_Name VARCHAR(50),
    IN p_Last_Name VARCHAR(50),
    IN p_Date_of_Birth DATE,
    IN p_Email_Address VARCHAR(100),
    IN p_Career_Details VARCHAR(100)
)
BEGIN
    INSERT INTO Donor (First_Name, Last_Name, Date_of_Birth, Email_Address, Career_Details)
    VALUES (p_First_Name, p_Last_Name, p_Date_of_Birth, p_Email_Address, p_Career_Details);
END$$
DELIMITER ;

-- Stored Procedure: Insert a New Donation
-- Purpose: Adds a new donation linked to a donor.
DELIMITER $$
CREATE PROCEDURE InsertDonation (
    IN p_Donor_ID INT,
    IN p_Date DATE,
    IN p_Amount DECIMAL(10,2),
    IN p_Donation_Type VARCHAR(50),
    IN p_Method_of_Payment VARCHAR(50)
)
BEGIN
    INSERT INTO Donation (Donor_ID, Date, Amount, Donation_Type, Method_of_Payment)
    VALUES (p_Donor_ID, p_Date, p_Amount, p_Donation_Type, p_Method_of_Payment);
END$$
DELIMITER ;

-- Stored Procedure: Insert a New Event
-- Purpose: Adds a new event to the database.
DELIMITER $$
CREATE PROCEDURE InsertEvent (
    IN p_Event_Name VARCHAR(100),
    IN p_Event_Date DATE,
    IN p_Country VARCHAR(50),
    IN p_City VARCHAR(50),
    IN p_Street_Name VARCHAR(100),
    IN p_Building_Number VARCHAR(10),
    IN p_Type VARCHAR(50)
)
BEGIN
    INSERT INTO Event (Event_Name, Event_Date, Country, City, Street_Name, Building_Number, Type)
    VALUES (p_Event_Name, p_Event_Date, p_Country, p_City, p_Street_Name, p_Building_Number, p_Type);
END$$
DELIMITER ;

-- Stored Procedure: Insert Communication History
-- Purpose: Logs a communication interaction between a donor and an event.
DELIMITER $$
CREATE PROCEDURE InsertCommunication (
    IN p_Donor_ID INT,
    IN p_Event_ID INT,
    IN p_Type_of_Communication VARCHAR(50),
    IN p_Date DATE,
    IN p_Notes VARCHAR(255),
    IN p_Follow_Up_Required BOOLEAN
)
BEGIN
    INSERT INTO Communication_History (Donor_ID, Event_ID, Type_of_Communication, Date, Notes, Follow_Up_Required)
    VALUES (p_Donor_ID, p_Event_ID, p_Type_of_Communication, p_Date, p_Notes, p_Follow_Up_Required);
END$$
DELIMITER ;

-- Stored Procedure: Update Donor Information
-- Purpose: Modifies an existing donor's details.
DELIMITER $$
CREATE PROCEDURE UpdateDonor (
    IN p_Donor_ID INT,
    IN p_First_Name VARCHAR(50),
    IN p_Last_Name VARCHAR(50),
    IN p_Email_Address VARCHAR(100),
    IN p_Career_Details VARCHAR(100)
)
BEGIN
    UPDATE Donor
    SET First_Name = p_First_Name,
        Last_Name = p_Last_Name,
        Email_Address = p_Email_Address,
        Career_Details = p_Career_Details
    WHERE Donor_ID = p_Donor_ID;
END$$
DELIMITER ;

-- Stored Procedure: Update a Donation Record
-- Purpose: Modifies details of an existing donation.
DELIMITER $$
CREATE PROCEDURE UpdateDonation (
    IN p_Donation_ID INT,
    IN p_Amount DECIMAL(10,2),
    IN p_Donation_Type VARCHAR(50),
    IN p_Method_of_Payment VARCHAR(50)
)
BEGIN
    UPDATE Donation
    SET Amount = p_Amount,
        Donation_Type = p_Donation_Type,
        Method_of_Payment = p_Method_of_Payment
    WHERE Donation_ID = p_Donation_ID;
END$$
DELIMITER ;

-- Stored Procedure: Delete a Donor
-- Purpose: Removes a donor and all their related records.
DELIMITER $$
CREATE PROCEDURE DeleteDonor (
    IN p_Donor_ID INT
)
BEGIN
    DELETE FROM Donor WHERE Donor_ID = p_Donor_ID;
END$$
DELIMITER ;

-- Stored Procedure: Delete a Donation
-- Purpose: Removes a specific donation record.
DELIMITER $$
CREATE PROCEDURE DeleteDonation (
    IN p_Donation_ID INT
)
BEGIN
    DELETE FROM Donation WHERE Donation_ID = p_Donation_ID;
END$$
DELIMITER ;

-- Stored Procedure: Delete an Event
-- Purpose: Removes an event from the database.
DELIMITER $$
CREATE PROCEDURE DeleteEvent (
    IN p_Event_ID INT
)
BEGIN
    DELETE FROM Event WHERE Event_ID = p_Event_ID;
END$$
DELIMITER ;

-- Stored Procedure: Delete a Communication Record
-- Purpose: Removes a specific communication record from the system.
DELIMITER $$
CREATE PROCEDURE DeleteCommunication (
    IN p_Communication_ID INT
)
BEGIN
    DELETE FROM Communication_History WHERE Communication_ID = p_Communication_ID;
END$$
DELIMITER ;




-- Creating Users
-- Creating an Admin User with Full Privileges
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'adminpassword';
GRANT ALL PRIVILEGES ON DonorTrackingSystem.* TO 'admin_user'@'localhost';

-- Creating a Donor Manager Role with Restricted Privileges
CREATE USER 'donor_manager'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT, INSERT, UPDATE ON Donor TO 'donor_manager'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Donation TO 'donor_manager'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Communication_History TO 'donor_manager'@'localhost';

-- Creating an Event Manager Role with Event-Related Privileges
CREATE USER 'event_manager'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT, INSERT, UPDATE ON Event TO 'event_manager'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Donor_Event TO 'event_manager'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Donation_Event TO 'event_manager'@'localhost';

-- Creating a Read-Only User for Reports
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'readonlypassword';
GRANT SELECT ON DonorDonationSummary TO 'readonly_user'@'localhost';
GRANT SELECT ON DonorParticipation TO 'readonly_user'@'localhost';
GRANT SELECT ON EventDonations TO 'readonly_user'@'localhost';
GRANT SELECT ON CommunicationLog TO 'readonly_user'@'localhost';
GRANT SELECT ON TopDonors TO 'readonly_user'@'localhost';











