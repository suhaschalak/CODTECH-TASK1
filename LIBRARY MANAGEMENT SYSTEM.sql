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

-- insert data into books table
INSERT INTO Books (title, author, genre,year_published,copies_available) 
VALUES 
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 3),
('1984', 'George Orwell', 'Dystopian', 1949, 4),
('Moby Dick', 'Herman Melville', 'Adventure', 1851, 2),
('Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 5),
('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 1951, 3);

-- insert data into members table
INSERT INTO Members (first_name, last_name, email, phone_number, membership_date) 
VALUES 
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '2023-05-15'),
('Alice', 'Johnson', 'alice.johnson@example.com', '345-678-9012', '2023-04-20'),
('Bob', 'Brown', 'bob.brown@example.com', '456-789-0123', '2023-03-25'),
('Charlie', 'Davis', 'charlie.davis@example.com', '567-890-1234', '2023-02-10'),
('Eve', 'Wilson', 'eve.wilson@example.com', '678-901-2345', '2023-01-05');

-- insert data into transactions table
INSERT INTO Transactions (book_id, member_id, borrow_date, return_date, Status) 
VALUES 
(2, 2, '2024-06-11', NULL, 'Borrowed'),  -- Book borrowed, not yet returned
(3, 3, '2024-06-12', NULL, 'Borrowed'),  -- Book borrowed, not yet returned
(4, 4, '2024-06-13', '2024-06-20', 'Returned'),  -- Book borrowed and returned
(5, 5, '2024-06-14', NULL, 'Borrowed'),  -- Book borrowed, not yet returned
(1, 2, '2024-06-10', '2024-06-15', 'Returned');  -- Book borrowed and returned

-- Update the number of copies available for a book
UPDATE books
SET copies_available = copies_available-1
WHERE id=1 AND copies_available > 0;

-- Update a member's email
UPDATE members
SET email = 'johnson.alice@example.com'
WHERE id =2;

-- Mark a book as returned
UPDATE transactions
SET return_date = '2024-06-24' ,status='returned'
WHERE id=4;

-- Delete a book
DELETE 
FROM books
WHERE title ='Moby Dick';

-- Delete a member
DELETE 
FROM members
WHERE id=3;

-- Delete a transaction
DELETE 
FROM transactions
WHERE id=1;

-- Retrieve all books
SELECT * FROM books;

-- Retrieve all members
SELECT * FROM members;

-- Retrieve all transactions
SELECT * FROM transactions;

--  retrieve data from the books, members, and transactions tables to get information about the books currently borrowed by members.
SELECT b.id AS book_id,
       b.title AS book_title,
       m.id AS member_id,
       m.first_name,
       m.last_name,
       t.status
FROM transactions t
JOIN books b ON t.book_id = b.id
JOIN members m ON t.member_id = m.id;
