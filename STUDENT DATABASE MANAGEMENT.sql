CREATE DATABASE student_database_mangement;
USE student_database_mangement;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender CHAR(1),
    enrollment_date DATE NOT NULL
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT,
    credits INT NOT NULL
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Students (student_id, first_name, last_name, date_of_birth, gender, enrollment_date)
VALUES 
    (1, 'John', 'Doe', '2000-01-01', 'M', '2018-09-01'),
    (2, 'Jane', 'Smith', '2001-02-15', 'F', '2019-09-01'),
    (3, 'Alice', 'Johnson', '1999-03-20', 'F', '2017-09-01'),
    (4, 'Bob', 'Brown', '2002-04-25', 'M', '2020-09-01'),
    (5, 'Charlie', 'Davis', '2001-05-30', 'M', '2019-09-01');

INSERT INTO Courses (course_id, course_name, course_description, credits)
VALUES (1, 'Introduction to Computer Science', 'Basics of computer science', 4),
    (2, 'Calculus I', 'Introduction to calculus', 3),
    (3, 'English Literature', 'Study of English literature', 3),
    (4, 'Physics I', 'Introduction to physics', 4),
    (5, 'Chemistry I', 'Introduction to chemistry', 4);

INSERT INTO Enrollments (enrollment_id, student_id, course_id, grade)
VALUES (1, 1, 1, 'A'),
    (2, 1, 2, 'B'),
    (3, 2, 1, 'B'),
    (4, 2, 3, 'A'),
    (5, 3, 1, 'C'),
    (6, 3, 4, 'A'),
    (7, 4, 2, 'B'),
    (8, 4, 5, 'C'),
    (9, 5, 3, 'B'),
    (10, 5, 4, 'B');

-- List all students with their courses and grades
SELECT s.student_id, s.first_name, s.last_name, c.course_name, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- Find the total number of students enrolled in each course
SELECT c.course_name, COUNT(e.student_id) AS num_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Calculate the average grade for each course
SELECT c.course_name, AVG(CASE 
                          WHEN e.grade = 'A' THEN 4.0
                          WHEN e.grade = 'B' THEN 3.0
                          WHEN e.grade = 'C' THEN 2.0
                          WHEN e.grade = 'D' THEN 1.0
                          ELSE 0.0
                         END) AS avg_grade
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Update the grade for a student in a specific course
UPDATE Enrollments
SET grade = 'A'
WHERE student_id = 2 AND course_id = 1;

-- Delete a student and their enrollments
DELETE FROM Students
WHERE student_id = 5;

DELETE FROM Enrollments
WHERE student_id = 5;

SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;