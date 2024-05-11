--CREATE TABLES
--user table
--down
drop table if exists users 
--up metadata
create table users(user_id int identity not null,
user_firstname varchar(50) not null,
user_lastname varchar(50) not null,
user_email varchar(50) not null,
user_phone_no varchar(50) not null
constraint pk_users_user_id primary key(user_id),
constraint u_users_user_email unique(user_email))

--houses table 
--down
drop table if exists houses 
--up metadata
create table houses(house_id int identity not null,
house_name varchar(50) not null,
house_primary_street varchar(100) not null,
house_secondary_street varchar(100),
house_city varchar(50) not null,
house_region varchar(50) not null,
house_postal_code varchar(50) not null,
house_country_code varchar(50) not null
constraint pk_houses_house_id primary key(house_id))

--userhouses table 
--down
drop table if exists userhouses 
--up metadata
CREATE TABLE userhouses (
    userhouse_user_id INT,
    userhouse_house_id INT,
    userhouse_user_role VARCHAR(255) not null,
    PRIMARY KEY (userhouse_user_id, userhouse_house_id),
    FOREIGN KEY (userhouse_user_id) REFERENCES Users(user_id),
    FOREIGN KEY (userhouse_house_id) REFERENCES Houses(house_id)
)

--devicetypes table
--lookup table
--down
drop table if exists devicetypes
--up metadata
create table devicetypes(device_type_id int identity not null,
device_type_name varchar(100) not null,
constraint pk_devicetypes_device_type_id primary key(device_type_id),
constraint u_devicetypes_device_type_name unique(device_type_name))

--devices table
--lookup table
--down
drop table if exists devices
--up metadata
CREATE TABLE devices (
    device_id INT not null,
    device_type_id INT not null,
    device_name varchar(100),
    device_manufacturer varchar(100),
    device_model varchar(100),
    device_serial_no varchar(100),
    device_purchase_date date,
    device_firmware_no varchar(100),
    primary key(device_id),
    foreign key(device_type_id) references devicetypes(device_type_id)
)

--devicestate table 
--down
drop table if exists devicestates
--up metadata
create table devicestates(device_state_id int identity not null,
devicestate_device_id INT not null,
devicestate_timestamp varchar(100) not null,
devicestate_data varchar(500) not null,
constraint pk_devicestates_device_state_id primary key(device_state_id))

alter table devicestates add constraint fk_devicestate_device_id foreign key (devicestate_device_id) references 
devices(device_id)

--rooms table
--down
drop table if exists rooms 
--up metadata
CREATE TABLE rooms (
    room_id INT,
    room_user_id INT not null,
    room_name VARCHAR(50),
    --room_device_id INT,
    --room_device_state_id INT,
    primary key(room_id, room_user_id),
    foreign key(room_user_id) references users(user_id),
)
--automation_rules table
--down
drop table if exists automation_rules 
--up metadata
create table automation_rules(automation_rule_id int identity not null,
automation_rule_name varchar(50) not null,  --add unique
automation_rule_trigger_condition varchar(50) not null,
automation_rule_action_command varchar(50) not null,
automation_rule_enabled BIT DEFAULT 1,
constraint pk_automation_rules_automation_rule_id primary key(automation_rule_id),
constraint u_automation_rule_name unique(automation_rule_name))

--user_automation_rules
--down
drop table if exists user_automation_rules 
--up metadata
create table user_automation_rules(
automation_rule_id int not null,
user_id int not null,
user_automation_rule_permission_level varchar(50) not null,
primary key(automation_rule_id, user_id),
foreign key(automation_rule_id) references automation_rules(automation_rule_id),
foreign key(user_id) references users(user_id))

--event_types table
--lookup table
--down
drop table if exists event_types
--up metadata
create table event_types(event_type_id int identity not null,
event_type_name varchar(50) not null
constraint pk_event_types_event_type_id primary key(event_type_id))

--event_notifications table
--down
drop table if exists event_notifications
--up metadata
create table event_notifications(event_notification_id int not null,
event_notification_type_id int not null,
event_notification_timestamp varchar(50) not null,
primary key(event_notification_id))

alter table event_notifications add constraint fk_event_notification_type_id foreign key (event_notification_type_id) references 
event_types(event_type_id)

--user_event_notifications table
--down
drop table if exists user_event_notifications;
--up metadata
create table user_event_notifications (
    event_notification_id int not null,
    user_id int not null,
    notification_preference varchar(50) not null,
    primary key (event_notification_id, user_id),
    foreign key (event_notification_id) references event_notifications (event_notification_id),
    foreign key (user_id) references users (user_id)
)
-----------------------------------------------------------------------------------------------------
--INSERT DATA INTO TABLES
--up data

--Insert data into users table
INSERT INTO users (user_firstname, user_lastname, user_email, user_phone_no)
VALUES 
  ('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
  ('Alice', 'Smith', 'alice.smith@example.com', '987-654-3210'),
  ('Bob', 'Johnson', 'bob.johnson@example.com', '555-123-4567');
INSERT INTO users (user_firstname, user_lastname, user_email, user_phone_no)
VALUES 
  ('Eva', 'Williams', 'eva.williams@example.com', '111-222-3333'),
  ('Michael', 'Anderson', 'michael.anderson@example.com', '444-555-6666'),
  ('Sophia', 'Brown', 'sophia.brown@example.com', '777-888-9999'); 

--Insert data into houses table
INSERT INTO houses (house_name, house_primary_street, house_secondary_street, house_city, house_region, house_postal_code, house_country_code)
VALUES 
  ('House 1', '123 Main St', NULL, 'City A', 'Region A', '12345', 'US'),
  ('House 2', '456 Oak St', 'Apt 2B', 'City B', 'Region B', '67890', 'UK'),
  ('House 3', '789 Pine St', 'Unit 3C', 'City C', 'Region C', '54321', 'CA');
INSERT INTO houses (house_name, house_primary_street, house_secondary_street, house_city, house_region, house_postal_code, house_country_code)
VALUES 
  ('House 4', '321 Elm St', 'Suite 4D', 'City D', 'Region D', '13579', 'AU'),
  ('House 5', '567 Maple St', 'Apt 5E', 'City E', 'Region E', '24680', 'DE'),
  ('House 6', '890 Birch St', NULL, 'City F', 'Region F', '98765', 'FR');

--Insert data into userhouses table
INSERT INTO userhouses (userhouse_user_id, userhouse_house_id, userhouse_user_role)
VALUES 
  (1, 1, 'Owner'),
  (2, 1, 'Resident'),
  (2, 2, 'Owner'),
  (3, 3, 'Resident'); 
INSERT INTO userhouses (userhouse_user_id, userhouse_house_id, userhouse_user_role)
VALUES 
  (1, 2, 'Resident'),
  (3, 1, 'Owner'),
  (3, 2, 'Resident'),
  (1, 3, 'Owner');  

 -- Insert data into devicetypes table
INSERT INTO devicetypes (device_type_name)
VALUES 
  ('Thermostat'),
  ('Light Switch'),
  ('Smart Lock');
INSERT INTO devicetypes (device_type_name)
VALUES 
  ('Camera'),
  ('Smart Speaker'),
  ('Motion Sensor'); 

-- Insert data into devices table
INSERT INTO devices (device_id, device_type_id, device_name, device_manufacturer, device_model, device_serial_no, device_purchase_date, device_firmware_no)
VALUES 
  (1, 1, 'Thermostat A', 'ABC Inc.', 'Model X', '123456789', '2022-01-01', '1.0'),
  (2, 2, 'Light Switch 1', 'XYZ Corp.', 'Model Y', '987654321', '2022-02-01', '2.0'),
  (3, 3, 'Smart Lock Z', 'DEF Ltd.', 'Model Z', '456789012', '2022-03-01', '3.0');
INSERT INTO devices (device_id, device_type_id, device_name, device_manufacturer, device_model, device_serial_no, device_purchase_date, device_firmware_no)
VALUES 
  (4, 1, 'Security Camera A', 'SEC Inc.', 'Model S', '654321098', '2022-04-01', '4.0'),
  (5, 2, 'Smart Speaker 1', 'ABC Corp.', 'Model SS', '789012345', '2022-05-01', '5.0'),
  (6, 3, 'Motion Sensor M', 'XYZ Ltd.', 'Model MS', '9876543210', '2022-06-01', '6.0');  

-- Insert data into devicestates table
INSERT INTO devicestates (devicestate_device_id, devicestate_timestamp, devicestate_data)
VALUES 
  (1, '2022-01-05', '{"temperature": 72}'),
  (2, '2022-02-10', '{"state": "On"}'),
  (3, '2022-03-15', '{"status": "Locked"}');
INSERT INTO devicestates (devicestate_device_id, devicestate_timestamp, devicestate_data)
VALUES 
  (4, '2022-04-05', '{"status": "Active"}'),
  (5, '2022-05-10', '{"volume": 50}'),
  (6, '2022-06-15', '{"motion": "Detected"}');  

-- Insert data into rooms table
INSERT INTO rooms (room_id, room_user_id, room_name)
VALUES 
  (1, 1, 'Living Room'),
  (2, 2, 'Bedroom'),
  (3, 3, 'Kitchen');
INSERT INTO rooms (room_id, room_user_id, room_name)
VALUES 
  (4, 2, 'Home Office'),
  (5, 3, 'Dining Room'),
  (6, 1, 'Guest Room');  

-- Insert data into automation_rules table
INSERT INTO automation_rules (automation_rule_name, automation_rule_trigger_condition, automation_rule_action_command)
VALUES 
  ('Rule 1', 'Temperature > 75', 'Turn on AC'),
  ('Rule 2', 'Light Sensor < 50', 'Turn off Lights'),
  ('Rule 3', 'Door Locked', 'Send Notification');
INSERT INTO automation_rules (automation_rule_name, automation_rule_trigger_condition, automation_rule_action_command)
VALUES 
  ('Rule 4', 'Camera Status = Active', 'Send Alert'),
  ('Rule 5', 'Motion Detected', 'Turn on Lights'),
  ('Rule 6', 'Temperature < 68', 'Turn on Heater');  

-- Insert data into user_automation_rules table
INSERT INTO user_automation_rules (automation_rule_id, user_id, user_automation_rule_permission_level)
VALUES 
  (1, 1, 'Read and Execute'),
  (2, 2, 'Read'),
  (3, 3, 'Read and Execute');
INSERT INTO user_automation_rules (automation_rule_id, user_id, user_automation_rule_permission_level)
VALUES 
  (4, 1, 'Read and Execute'),
  (5, 2, 'Read'),
  (6, 3, 'Read and Execute');

-- Insert data into event_types table
INSERT INTO event_types (event_type_name)
VALUES 
  ('Temperature Event'),
  ('Light Event'),
  ('Door Event');
INSERT INTO event_types (event_type_name)
VALUES 
  ('Camera Event'),
  ('Speaker Event'),
  ('Motion Event'); 

-- Insert data into event_notifications table
INSERT INTO event_notifications (event_notification_id, event_notification_type_id, event_notification_timestamp)
VALUES 
  (1, 1, '2022-01-15 12:00:00'),
  (2, 2, '2022-02-20 18:30:00'),
  (3, 3, '2022-03-25 08:45:00');
INSERT INTO event_notifications (event_notification_id, event_notification_type_id, event_notification_timestamp)
VALUES 
  (4, 1, '2022-04-15 12:00:00'),
  (5, 2, '2022-05-20 18:30:00'),
  (6, 3, '2022-06-25 08:45:00');

-- Insert data into user_event_notifications table
INSERT INTO user_event_notifications (event_notification_id, user_id, notification_preference)
VALUES 
  (1, 1, 'Email and SMS'),
  (2, 2, 'Email'),
  (3, 3, 'Push Notification');
INSERT INTO user_event_notifications (event_notification_id, user_id, notification_preference)
VALUES 
  (4, 1, 'Email and SMS'),
  (5, 2, 'Email'),
  (6, 3, 'Push Notification');
 -----------------------------------------------------------------------------------------------------
 --VERIFY
 select * from users
 select * from houses
 select * from userhouses
 select * from devicetypes
 select * from devices
 select * from devicestates
 select * from rooms
 select * from automation_rules
 select * from user_automation_rules
 select * from event_types
 select * from event_notifications
 select * from user_event_notifications
-----------------------------------------------------------------------------------------------------
--INFORMATION SCHEMA
--INFORMATION SCHEMA COULMNS
select * from information_schema.columns where table_name = 'users' 
select * from information_schema.columns where table_name = 'houses' 
select * from information_schema.columns where table_name = 'userhouses' 
select * from information_schema.columns where table_name = 'devicetypes' 
select * from information_schema.columns where table_name = 'devices' 
select * from information_schema.columns where table_name = 'devicestates' 
select * from information_schema.columns where table_name = 'rooms'
select * from information_schema.columns where table_name = 'automation_rules' 
select * from information_schema.columns where table_name = 'user_automation_rules' 
select * from information_schema.columns where table_name = 'event_types' 
select * from information_schema.columns where table_name = 'event_notifications' 
select * from information_schema.columns where table_name = 'user_event_notifications' 

---INFORMATION SCHEMA TABLE_CONSTRAINTS
select * from information_schema.table_constraints where table_name = 'users' 
select * from information_schema.table_constraints where table_name = 'houses' 
select * from information_schema.table_constraints where table_name = 'userhouses' 
select * from information_schema.table_constraints where table_name = 'devicetypes' 
select * from information_schema.table_constraints where table_name = 'devices' 
select * from information_schema.table_constraints where table_name = 'devicestates' 
select * from information_schema.table_constraints where table_name = 'rooms' 
select * from information_schema.table_constraints where table_name = 'automation_rules' 
select * from information_schema.table_constraints where table_name = 'user_automation_rules' 
select * from information_schema.table_constraints where table_name = 'event_types' 
select * from information_schema.table_constraints where table_name = 'event_notifications' 
select * from information_schema.table_constraints where table_name = 'user_event_notifications' 

---INFORMATION SCHEMA VIEWS
SELECT * FROM information_schema.views;

-----------------------------------------------------------------------------------------------------
 -- JOINS: Retrieve user information along with their houses
SELECT u.user_firstname, u.user_lastname, u.user_email, u.user_phone_no,
       uh.userhouse_user_role,
       h.house_name, h.house_primary_street, h.house_city, h.house_country_code
FROM users u
INNER JOIN userhouses uh ON u.user_id = uh.userhouse_user_id
INNER JOIN houses h ON uh.userhouse_house_id = h.house_id;

-----------------------------------------------------------------------------------------------------
-- CASE: Classify users based on their notification preferences
SELECT uen.user_id, u.user_firstname, u.user_lastname,
       CASE
           WHEN e.notification_preference = 'Email and SMS' THEN 'Email and SMS'
           WHEN e.notification_preference = 'Email' THEN 'Email'
           ELSE 'Other'
       END AS notification_category
FROM user_event_notifications uen
JOIN users u ON uen.user_id = u.user_id
JOIN event_notifications e ON uen.event_notification_id = e.event_notification_id;
-----------------------------------------------------------------------------------------------------
-- DISTINCT: Retrieve distinct device types
SELECT DISTINCT device_type_name
FROM devicetypes;
-----------------------------------------------------------------------------------------------------
-- ORDER BY: Retrieve houses ordered by region
SELECT house_id, house_name, house_primary_street, house_city, house_region, house_country_code
FROM houses
ORDER BY house_region;

-----------------------------------------------------------------------------------------------------
-- TOP: Retrieve top 5 automation rules
SELECT TOP 5 automation_rule_name, automation_rule_trigger_condition, automation_rule_action_command
FROM automation_rules;
-----------------------------------------------------------------------------------------------------
-- GROUP BY, HAVING: Retrieve houses with more than one resident
SELECT h.house_name, COUNT(uh.userhouse_user_id) AS resident_count
FROM houses h
JOIN userhouses uh ON h.house_id = uh.userhouse_house_id
GROUP BY h.house_name
HAVING COUNT(uh.userhouse_user_id) > 1;
-----------------------------------------------------------------------------------------------------
-- WITH: Retrieve users and their automation rules
WITH UserAutomationInfo AS (
    SELECT u.user_id, u.user_firstname, u.user_lastname,
           uar.automation_rule_id, uar.user_automation_rule_permission_level
    FROM users u
    JOIN user_automation_rules uar ON u.user_id = uar.user_id
)
SELECT * FROM UserAutomationInfo;
-----------------------------------------------------------------------------------------------------
-- WINDOW FUNCTION: Rank users based on the number of automation rules they have
WITH UserAutomationCount AS (
    SELECT u.user_id, u.user_firstname, u.user_lastname,
           COUNT(uar.automation_rule_id) AS rule_count,
           RANK() OVER (ORDER BY COUNT(uar.automation_rule_id) DESC) AS rule_rank
    FROM users u
    LEFT JOIN user_automation_rules uar ON u.user_id = uar.user_id
    GROUP BY u.user_id, u.user_firstname, u.user_lastname
)
SELECT * FROM UserAutomationCount;
-----------------------------------------------------------------------------------------------------
--USER DEFINED FUNCTIONS
USE demo;
GO

-- Create a function to get the count of automation rules for a user
CREATE FUNCTION dbo.GetUserAutomationRuleCount(@userId INT)
RETURNS INT
AS
BEGIN
    DECLARE @ruleCount INT;

    SELECT @ruleCount = COUNT(uar.automation_rule_id)
    FROM user_automation_rules uar
    WHERE uar.user_id = @userId;

    RETURN @ruleCount;
END;
GO

-- Demo: Test the created function
DECLARE @userIdToTest INT = 1;
DECLARE @automationRuleCount INT;

-- Call the function
SET @automationRuleCount = dbo.GetUserAutomationRuleCount(@userIdToTest);

-- Display the result
PRINT 'User ' + CAST(@userIdToTest AS VARCHAR) + ' has ' + CAST(@automationRuleCount AS VARCHAR) + ' automation rule(s).';

-----------------------------------------------------------------------------------------------------
--TRIGGER
-- Drop the trigger if it exists
DROP TRIGGER IF EXISTS tr_AfterInsertUsers;

-- Create an AFTER INSERT trigger for the users table

use demo
go

CREATE TRIGGER tr_AfterInsertUsers
ON users
AFTER INSERT
AS
BEGIN
    -- Insert a default notification preference for the newly inserted user
    INSERT INTO user_event_notifications (event_notification_id, user_id, notification_preference)
    SELECT event_notification_id, inserted.user_id, 'Default Preference'
    FROM inserted
    CROSS JOIN (SELECT TOP 1 event_notification_id FROM event_notifications ORDER BY event_notification_id) AS en; 
END;

-- Insert a new row into the users table
INSERT INTO users (user_firstname, user_lastname, user_email, user_phone_no)
VALUES ('Test', 'User', 'test.user@example.com', '555-123-4567');

-- Verify the result
SELECT * FROM user_event_notifications;
select * from users

-----------------------------------------------------------------------------------------------------
--BUILT IN FUNCTIONS
-- Fetch the latest device state for each device
SELECT
    d.device_id,
    d.device_name,
    dt.device_type_name,
    ds.devicestate_timestamp,
    ds.devicestate_data
FROM
    devices d
JOIN
    devicestates ds ON d.device_id = ds.devicestate_device_id
JOIN
    devicetypes dt ON d.device_type_id = dt.device_type_id
WHERE
    ds.device_state_id = (SELECT MAX(device_state_id) FROM devicestates WHERE devicestate_device_id = d.device_id);

-- Count the number of houses each user owns
SELECT
    u.user_id,
    u.user_firstname,
    u.user_lastname,
    COUNT(uh.userhouse_house_id) AS house_count
FROM
    users u
LEFT JOIN
    userhouses uh ON u.user_id = uh.userhouse_user_id
GROUP BY
    u.user_id, u.user_firstname, u.user_lastname;

-- Find the average temperature from temperature events
SELECT
    AVG(CAST(JSON_VALUE(ds.devicestate_data, '$.temperature') AS INT)) AS average_temperature
FROM
    devicestates ds
JOIN
    devices d ON ds.devicestate_device_id = d.device_id
JOIN
    devicetypes dt ON d.device_type_id = dt.device_type_id
WHERE
    dt.device_type_name = 'Thermostat';
-----------------------------------------------------------------------------------------------------

--PROCEDURE
GO
-- Create a stored procedure to get the latest device state
CREATE PROCEDURE GetLatestDeviceState
    @device_id INT
AS
BEGIN
    SELECT
        d.device_id,
        d.device_name,
        dt.device_type_name,
        ds.devicestate_timestamp,
        ds.devicestate_data
    FROM
        devices d
    JOIN
        devicestates ds ON d.device_id = ds.devicestate_device_id
    JOIN
        devicetypes dt ON d.device_type_id = dt.device_type_id
    WHERE
        ds.device_state_id = (SELECT MAX(device_state_id) FROM devicestates WHERE devicestate_device_id = @device_id);
END;
--test procedure
EXEC GetLatestDeviceState @device_id = 1;

-----------------------------------------------------------------------------------------------------
--TRANSACTION

BEGIN TRANSACTION;

--Insert data into users table
--up data
BEGIN TRY
    INSERT INTO users (user_firstname, user_lastname, user_email, user_phone_no)
    VALUES 
      ('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
      ('Alice', 'Smith', 'alice.smith@example.com', '987-654-3210'),
      ('Bob', 'Johnson', 'bob.johnson@example.com', '555-123-4567');
    INSERT INTO users (user_firstname, user_lastname, user_email, user_phone_no)
    VALUES 
      ('Eva', 'Williams', 'eva.williams@example.com', '111-222-3333'),
      ('Michael', 'Anderson', 'michael.anderson@example.com', '444-555-6666'),
      ('Sophia', 'Brown', 'sophia.brown@example.com', '777-888-9999'); 
    -- Commit the transaction if everything is successful
    COMMIT;
END TRY
BEGIN CATCH
    -- Rollback the transaction if there's an error
    ROLLBACK;
    PRINT 'An error occurred. Transaction rolled back.';
END CATCH;

-- Demo test: Intentionally cause a duplicate entry error
BEGIN TRANSACTION;

-- Simulate an error (inserting a duplicate entry)
BEGIN TRY
    INSERT INTO users (user_firstname, user_lastname, user_email, user_phone_no)
    VALUES ('John', 'Doe', 'john.doe@example.com', '123-456-7890');
    -- Commit the transaction if everything is successful
    COMMIT;
END TRY
BEGIN CATCH
    -- Rollback the transaction if there's an error
    ROLLBACK;
    PRINT 'Demo test: An error occurred. Transaction rolled back.';
END CATCH;
-----------------------------------------------------------------------------------------------------
--VIEWS
-- Create a view to show user and house information
go
CREATE VIEW UserHouseView AS
SELECT
    u.user_id,
    u.user_firstname,
    u.user_lastname,
    u.user_email,
    u.user_phone_no,
    uh.userhouse_user_role,
    h.house_id,
    h.house_name,
    h.house_primary_street,
    h.house_secondary_street,
    h.house_city,
    h.house_region,
    h.house_postal_code,
    h.house_country_code
FROM
    users u
JOIN
    userhouses uh ON u.user_id = uh.userhouse_user_id
JOIN
    houses h ON uh.userhouse_house_id = h.house_id;

go
-- Test view UserHouseView
SELECT * FROM UserHouseView;

















 









