-- create library database
CREATE DATABASE library_management_system;
USE library_management_system;

-- create books table
CREATE TABLE books (
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
genre VARCHAR(64) NOT NULL,
year_published INT CHECK(year_published > 0),
copies_available INT CHECK(copies_available >= 0) DEFAULT 0
);

-- create members table
CREATE TABLE MEMBERS (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(64) NOT NULL,
last_name VARCHAR(64) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
phone_number VARCHAR(12) NOT NULL,
membership_date DATE 
);

-- create transactions table
CREATE TABLE transactions (
id INT PRIMARY KEY AUTO_INCREMENT,
book_id INT NOT NULL,
member_id INT NOT NULL,
borrow_date DATE,
return_date DATE,
status ENUM('borrowed','returned'),
FOREIGN KEY (book_id) REFERENCES books(id)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (member_id) REFERENCES members(id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
