CREATE DATABASE IF NOT EXISTS employee_db;
USE employee_db

CREATE TABLE Employee (
	emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    city VARCHAR(50),
    designation VARCHAR(50),
    Date_of_Joining Date,
    Age INT
);
