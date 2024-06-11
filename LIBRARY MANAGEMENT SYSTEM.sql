CREATE DATABASE library;
USE library;

CREATE TABLE books (
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
genre VARCHAR(64) NOT NULL,
year_publish YEAR,
copies_avilable INT CHECK(copies_avilable >= 0) DEFAULT 0
);

CREATE TABLE MEMBERS (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(64) NOT NULL,
last_name VARCHAR(64) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
phone_number VARCHAR(12) NOT NULL,
membership_date DATE 
);

CREATE TABLE transactions (
id INT PRIMARY KEY AUTO_INCREMENT,
book_id INT NOT NULL,
member_id INT NOT NULL,
borrow_date DATE,
return_date DATE,
status ENUM('borrowed','returned'),
FOREIGN KEY (book_id) REFERENCES books(id),
FOREIGN KEY (member_id) REFERENCES members(id)
);



