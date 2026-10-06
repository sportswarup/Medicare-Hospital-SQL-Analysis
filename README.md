# Medicare Hospital SQL Analysis

## Project Overview

The Medicare Hospital SQL Analysis project is a MySQL-based data analysis project designed to analyze hospital management data and generate meaningful insights using SQL.

The project covers patient information, doctors, departments, hospitals, appointments, treatments, medicines, prescriptions, and billing information.

## Project Objective

The main objective of this project is to use SQL to analyze hospital operations and answer business-related questions involving:

* Patients
* Doctors
* Hospitals
* Departments
* Appointments
* Treatments
* Medicines
* Prescriptions
* Billing and revenue

## Tools & Technologies

* MySQL
* SQL
* GitHub
* MySQL Workbench

## SQL Concepts Used

This project demonstrates the following SQL concepts:

* SELECT statements
* WHERE conditions
* ORDER BY
* GROUP BY
* HAVING
* Aggregate functions
* INNER JOIN
* LEFT JOIN
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* RANK()
* DENSE_RANK()
* LAG()
* Running totals
* Rolling calculations
* Views
* Stored Procedures
* Triggers
* Date functions
* CASE/conditional analysis

## Key Analysis Performed

The project contains 50 SQL analysis questions covering different levels of SQL.

Some of the analysis includes:

* Finding the total number of patients
* Identifying highly paid doctors
* Calculating average doctor salary
* Department-wise doctor count
* Hospital-wise patient analysis
* Monthly appointments
* Pending and completed appointments
* Top spending patients
* Revenue by hospital
* Revenue by department
* Most prescribed medicines
* Patients without appointments
* Doctors hired after 2022
* Monthly billing
* Doctor salary ranking
* Running total of bills
* Duplicate patient names
* Patients from specific cities
* Treatments above average cost
* Latest appointment per patient
* Second-highest salary
* Patient summary view
* Stored procedure for bill lookup
* Trigger for bill logging
* Monthly revenue using CTE
* Hospital revenue ranking
* Top medicine by department
* Patients visiting multiple doctors
* Revenue growth year over year
* Rolling 3-month revenue
* Inactive patients and doctors
* Average billing by city
* Highest bill per hospital
* Final hospital dashboard query

## Project Structure

```text
Medicare-Hospital-SQL-Analysis/
│
├── README.md
│
├── Medicare_HMS_questions.sql
│
└── Medicare_HMS_solutions.sql
```

## How to Run the Project

### Step 1: Install MySQL

Install MySQL and MySQL Workbench.

### Step 2: Create the Database

Create or select the Medicare Hospital Management database.

```sql
CREATE DATABASE MediCare_Hospital;
USE MediCare_Hospital;
```

### Step 3: Create the Required Tables

Create the hospital management tables required by the SQL queries.

### Step 4: Insert the Data

Insert the project dataset into the required tables.

### Step 5: Run the SQL Queries

Open:

```text
Medicare_HMS_solutions.sql
```

and execute the queries in MySQL Workbench.

## Advanced SQL Features

The project also demonstrates practical advanced SQL concepts such as:

### Window Functions

Doctor salary ranking and revenue analysis are performed using window functions.

### CTE

Common Table Expressions are used for monthly revenue analysis and other analytical queries.

### Views

A patient summary view is created to combine appointment and billing information.

### Stored Procedure

A stored procedure is created to retrieve bill details using a bill ID.

### Trigger

A trigger is implemented to automatically log newly inserted bills.

## Learning Outcomes

Through this project, I practiced:

* Writing SQL queries for real-world business problems
* Working with relational databases
* Joining multiple tables
* Performing aggregations
* Analyzing hospital revenue
* Using window functions
* Working with CTEs
* Creating views
* Creating stored procedures
* Creating triggers
* Performing business-oriented data analysis

## Author

**Swarup Jadhav**

Aspiring Data Analyst
