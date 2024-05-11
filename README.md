# Smart-Home-Automation-System

# Introduction

This Git repository contains the codebase for a Smart Home Automation System. The system aims to automate household management tasks and provide users with notifications based on predefined rules and events.
This project is a database management system (DBMS) project that explores various SQL queries and demonstrates their implementation within a relational database management system. The project encompasses the design of a database schema for a smart home automation system, along with the creation of tables, insertion of sample data, and execution of SQL queries to perform data manipulation and retrieval operations.

# Features:

User Management: Users can create accounts and manage their personal information.<br>
House Management: Users can add and manage houses, including details like address and room setup.<br>
Room and Device Management: Users can configure rooms within their houses and add devices to control.<br>
Automation Rules: Users can define rules for automating device actions based on specified conditions.<br>
Event Notifications: Users receive notifications for events such as motion detection or temperature changes.<br>


# ER-Data Requirement
The system's data structure includes entities such as User, House, Room, Device, Automation Rule, Event Notification, and Event Type, each with specific attributes and relationships.

![image](https://github.com/mkarodka/Smart-Home-Automation-System/assets/108047751/e90a4a7a-964f-4422-a36c-03298f50fe5b)


# Conceptual Model
The conceptual model illustrates the entities and their relationships, providing an overview of the system's structure.

![image](https://github.com/mkarodka/Smart-Home-Automation-System/assets/108047751/297c26d6-d69a-4ff6-9498-57c71a70977c)


# Logical Model
The logical model outlines primary keys, foreign keys, and attributes for each entity, facilitating database design and implementation.

![image](https://github.com/mkarodka/Smart-Home-Automation-System/assets/108047751/9e1904db-3e4a-43bd-a4d0-29303962d09f)


# Database Schema
The database schema consists of the following tables:

Users: Stores information about users of the smart home automation system, including their names, contact details, and unique identifiers.<br>
Houses: Contains details about residential properties, such as addresses, location, and ownership.<br>
UserHouses: Represents the relationship between users and houses, indicating the roles of users within specific properties.<br>
DeviceTypes: Defines the types of devices that can be installed in a smart home setup.<br>
Devices: Stores information about individual smart devices, including their types, manufacturers, and purchase details.<br>
DeviceStates: Records the state of each device at different timestamps, capturing data such as temperature, status, or motion detection.<br>
Rooms: Describes the rooms within each house, associated with specific users.<br>
AutomationRules: Contains predefined rules for automating actions based on certain triggers and conditions.<br>
UserAutomationRules: Maps users to automation rules and specifies their permission levels for rule execution.<br>
EventTypes: Defines different types of events that can occur within the system.<br>
EventNotifications: Stores notifications generated by various events, along with timestamps.<br>
UserEventNotifications: Associates users with event notifications and their preferred notification preferences.<br>

# SQL Queries
The project includes a wide range of SQL queries categorized into different types, including:

Data Retrieval Queries: Retrieve information from one or more tables using SELECT statements, often involving joins, filtering, and ordering.<br>
Data Modification Queries: Insert, update, or delete records to modify the database contents, ensuring data integrity and consistency.<br>
Data Aggregation Queries: Perform aggregations and calculations on data sets using functions such as COUNT, SUM, AVG, etc.<br>
Data Manipulation Queries: Utilize built-in functions and operators to transform and manipulate data according to specific requirements.<br>
Transaction Management: Implement transactions to ensure atomicity, consistency, isolation, and durability (ACID properties) when performing multiple database operations.<br>
Stored Procedures and Functions: Define reusable routines for executing complex operations or calculations within the database.<br>
Views: Create virtual tables that abstract and simplify complex data structures, providing a convenient way to query data from multiple tables.<br>
These SQL queries cover various scenarios, including retrieving user and house information, managing smart devices and automation rules, handling event notifications, and implementing transactional operations.<br>

SQL script provided in this repository for this project will give more details.




