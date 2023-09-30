/*    
1. Table Students:
	student_id (primary key)
	student_name (student's full name)
	student_age (student's age)

2. Table Courses:
	course_id (primary key)
	course_name (course name)
	instructor_id (foreign key referencing Instructors table)

3. Table Instructors:
	instructor_id (primary key)
	instructor_name (instructor's full name)

4. Table Enrollments:
	enrollment_id (primary key)
	student_id (foreign key referencing Students table)
	course_id (foreign key referencing Courses table)
	grade (grade received by the student in the course)

Tasks:

1. Find the average age of students enrolled in each course.
2. Select courses with at least 5 enrolled students.
3. Find instructors who teach more than 2 courses.
4. Calculate the average grade for each course but select only those courses with an average grade above 3.5.
5. Select students who are not enrolled in any course.
6. Find courses where all students received a grade higher than 4.0.
7. Find the instructor who teaches courses with the lowest average grade.
8. Find students with an average grade higher than 4.0 in at least 2 courses.
9. Select the top 5 students (highest average grades) and display their first and last names.
10. Calculate the age difference between the oldest and youngest student in each course.
*/

-- Create tables 
DROP SCHEMA IF EXISTS courses_students;
CREATE SCHEMA courses_students;
USE courses_students;


CREATE TABLE students (
	student_id INT AUTO_INCREMENT,
    student_name VARCHAR(50) NOT NULL,
    student_age INT NOT NULL,
    PRIMARY KEY (student_id)
);

CREATE TABLE instructors (
	instructor_id INT AUTO_INCREMENT,
	instructor_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (instructor_id)
);

CREATE TABLE courses (
	course_id INT AUTO_INCREMENT,
    course_name VARCHAR(50) NOT NULL,
    instructor_id INT NOT NULL,
    PRIMARY KEY (course_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors (instructor_id)
);

CREATE TABLE enrollments (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade INT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

-- Make insertions
-- Insert 10 instructors
INSERT INTO instructors (instructor_name) VALUES
    ('Professor Smith'),
    ('Professor Johnson'),
    ('Professor Davis'),
    ('Professor Wilson'),
    ('Professor Brown'),
    ('Professor Miller'),
    ('Professor Taylor'),
    ('Professor Clark'),
    ('Professor Turner'),
    ('Professor Martinez');

-- Insert 50 students
INSERT INTO students (student_name, student_age) VALUES
    ('Alice Johnson', 20),
    ('Bob Smith', 21),
    ('Carol Davis', 22),
    ('David Wilson', 23),
    ('Emily Brown', 24),
    ('Frank Miller', 25),
    ('Grace Taylor', 26),
    ('Henry Clark', 27),
    ('Isabella Turner', 28),
    ('Jack White', 29),
    ('Lily Harris', 20),
    ('Michael Lee', 21),
    ('Olivia Moore', 22),
    ('Peter Hall', 23),
    ('Quinn Martin', 24),
    ('Rachel Anderson', 25),
    ('Samuel Young', 26),
    ('Sophia King', 27),
    ('Thomas Adams', 28),
    ('Victoria Martinez', 29),
    ('William Scott', 20),
    ('Zoey Parker', 21),
    ('Ethan Murphy', 22),
    ('Chloe Wright', 23),
    ('Ava Lewis', 24),
    ('Noah Green', 25),
    ('Mia Carter', 26),
    ('James Martinez', 27),
    ('Harper Robinson', 28),
    ('Benjamin Turner', 29),
    ('Ella Brown', 20),
    ('Liam Davis', 21),
    ('Abigail Hall', 22),
    ('Daniel Jackson', 23),
    ('Sophia Harris', 24),
    ('Logan Turner', 25),
    ('Emma Lewis', 26),
    ('Alexander Martin', 27),
    ('Grace Smith', 28),
    ('Samuel Parker', 29),
    ('Charlotte Davis', 20),
    ('Jackson Wilson', 21),
    ('Avery Clark', 22),
    ('Nicholas Moore', 23),
    ('Grace Robinson', 24),
    ('Elijah Adams', 25),
    ('Mia Mitchell', 26),
    ('Andrew White', 27),
    ('Madison Johnson', 28),
    ('Oliver Carter', 29),
    ('Oskar Szysiak', 21);

-- Insert 50 courses with unique names and foreign keys to instructors 1 to 10
INSERT INTO courses (course_name, instructor_id) VALUES
    ('Biology 101', 3),
    ('Chemistry 101', 4),
    ('Physics 101', 5),
    ('English 101', 6),
    ('Computer Science 101', 7),
    ('Art 101', 8),
    ('Psychology 101', 9),
    ('Music 101', 10),
    ('Algebra 1', 1),
    ('World History', 2),
    ('Anatomy and Physiology', 3),
    ('Organic Chemistry', 4),
    ('Astronomy', 5),
    ('Literature and Composition', 6),
    ('Introduction to Programming', 7),
    ('Introduction to Fine Arts', 8),
    ('Introduction to Psychology', 9),
    ('Music Theory', 10),
    ('Calculus 1', 1),
    ('US History', 2),
    ('Genetics', 3),
    ('Inorganic Chemistry', 4),
    ('Cosmology', 5),
    ('Shakespearean Literature', 6),
    ('Database Management', 7),
    ('How to make pizza', 3),
    ('How to make fries', 3);




INSERT INTO enrollments (student_id, course_id, grade) VALUES
    (4, 9, 2),
	(47, 7, 6),
	(27, 4, 1),
	(17, 3, 6),
	(22, 17, 2),
	(47, 16, 2),
	(14, 13, 3),
	(3, 22, 5),
	(48, 8, 4),
	(6, 2, 2),
	(46, 20, 5),
	(18, 1, 6),
	(24, 17, 5),
	(26, 23, 2),
	(45, 12, 1),
	(30, 2, 2),
	(45, 21, 3),
	(3, 24, 3),
	(4, 23, 3),
	(48, 1, 4),
	(35, 1, 4),
	(43, 14, 5),
	(24, 10, 6),
	(15, 7, 2),
	(40, 6, 3),
	(49, 9, 4),
	(10, 20, 5),
	(18, 12, 2),
	(7, 21, 2),
	(37, 1, 1),
	(27, 8, 3),
	(14, 8, 4),
	(8, 4, 2),
	(9, 3, 3),
	(33, 6, 5),
	(24, 12, 5),
	(8, 25, 1),
	(7, 5, 1),
	(13, 21, 4),
	(26, 18, 4),
	(35, 21, 2),
	(18, 23, 3),
	(22, 5, 3),
	(47, 4, 4),
	(20, 8, 1),
	(47, 13, 2),
	(23, 13, 4),
	(5, 7, 1),
	(34, 25, 6),
	(21, 25, 1),
	(3, 19, 3),
	(28, 18, 1),
	(4, 18, 2),
	(41, 12, 1),
	(27, 22, 3),
	(1, 3, 3),
	(32, 18, 5),
	(42, 20, 2),
	(43, 18, 5),
	(1, 12, 3),
	(26, 11, 2),
	(25, 4, 6),
	(13, 23, 2),
	(39, 5, 1),
	(35, 24, 6),
	(36, 6, 6),
	(23, 6, 6),
	(3, 3, 5),
	(37, 5, 2),
	(22, 16, 3),
	(12, 15, 1),
	(5, 18, 2),
	(50, 17, 2),
	(1, 5, 1),
	(27, 24, 2),
	(43, 20, 3),
	(30, 20, 4),
	(25, 6, 5),
	(35, 16, 5),
	(32, 20, 2),
	(45, 2, 3),
	(20, 12, 4),
	(12, 8, 6),
	(28, 4, 3),
	(22, 18, 1),
	(5, 11, 6),
	(50, 10, 1),
	(41, 7, 6),
	(43, 4, 2),
	(19, 13, 5),
	(10, 10, 5),
	(41, 25, 5),
	(28, 25, 2),
	(17, 25, 5),
	(33, 21, 2),
	(2, 6, 4),
	(11, 18, 4),
	(46, 15, 4),
	(40, 8, 4),
	(31, 5, 5),
	(34, 4, 2),
	(20, 5, 6),
	(12, 1, 2),
	(45, 13, 3),
	(12, 10, 2),
	(37, 9, 4),
	(5, 4, 6),
	(4, 6, 3),
	(21, 22, 5),
	(9, 2, 5),
	(23, 10, 3),
	(27, 10, 4),
	(50, 21, 3),
	(8, 15, 6),
	(10, 12, 1),
	(44, 14, 4),
	(1, 9, 5),
	(2, 8, 5),
	(30, 24, 4),
	(8, 24, 1),
	(18, 4, 6),
	(38, 13, 4),
	(6, 8, 4),
	(3, 9, 2),
	(23, 21, 2),
	(41, 2, 1),
	(42, 1, 3),
	(42, 10, 1),
	(30, 8, 1),
	(2, 1, 2),
	(28, 20, 5),
	(42, 19, 2),
	(35, 13, 3),
	(25, 3, 6),
	(2, 10, 1),
	(48, 7, 2),
	(38, 6, 1),
	(49, 15, 2),
	(12, 5, 6),
	(3, 2, 6),
	(12, 14, 6),
	(12, 23, 4),
	(50, 7, 2),
	(45, 20, 2),
	(27, 23, 5),
	(16, 2, 3),
	(10, 16, 2),
	(8, 19, 4),
	(9, 18, 3),
	(10, 25, 3),
	(49, 8, 6),
	(43, 22, 3),
	(15, 24, 1),
	(12, 7, 2),
	(8, 3, 2),
	(47, 19, 1),
	(8, 12, 4),
	(10, 9, 2),
	(48, 2, 1),
	(43, 15, 1),
	(31, 4, 2),
	(21, 3, 5),
	(38, 19, 4),
	(31, 13, 4),
	(18, 13, 5),
	(14, 6, 4),
	(40, 25, 5),
	(50, 2, 2),
	(17, 8, 2),
	(42, 7, 1),
	(8, 14, 1),
	(19, 23, 1),
	(46, 7, 2),
	(11, 19, 5),
	(46, 16, 1),
	(24, 13, 5),
	(31, 6, 5),
	(26, 19, 4),
	(40, 18, 2),
	(4, 7, 5),
	(45, 8, 7),
	(27, 11, 5),
	(19, 7, 6),
	(10, 4, 3),
	(9, 15, 4),
	(46, 18, 6),
	(15, 12, 6),
    (11, 26, 6),
    (12, 26, 6),
	(21, 7, 1),
    (51, 26, 6),
    (51, 21, 6);
    
    
-- 1. Find the average age of students enrolled in each course.
SELECT c.course_id ,c.course_name AS 'course name', ROUND(AVG(s.student_age), 0) as 'average age'
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
JOIN courses c ON c.course_id = e.course_id
GROUP BY c.course_id;

-- 2. Select courses with at least 5 enrolled students.
SELECT c.course_id ,c.course_name AS 'course name' ,  COUNT(s.student_id) as 'students enrolled'
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
JOIN courses c ON c.course_id = e.course_id
GROUP BY c.course_id
HAVING COUNT(s.student_id) > 5;


-- 3. Find instructors who teach more than 2 courses.
SELECT i.instructor_id, i.instructor_name, COUNT(course_id) as 'courses count'
FROM instructors i 
JOIN courses c ON c.instructor_id = i.instructor_id
GROUP BY c.instructor_id
HAVING COUNT(course_id) > 2;

-- 4. Calculate the average grade for each course but select only those courses with an average grade above 3.5.
SELECT c.course_id, c.course_name, AVG(e.grade) AS 'average grade'
FROM courses c 
JOIN enrollments e ON e.course_id = c.course_id
GROUP BY c.course_id 
HAVING AVG(e.grade) > 3.5;

-- 5. Select students who are not enrolled in any course.
SELECT s.student_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- 6. Find courses where all students received a grade higher than 4.0.
SELECT c.course_id, c.course_name
FROM courses c
WHERE 
c.course_id NOT IN (
  SELECT e.course_id
  FROM enrollments e
  WHERE e.grade <= 4.0
) 
AND 
c.course_id NOT IN (
	SELECT c.course_id
	FROM courses c
	LEFT JOIN enrollments e ON c.course_id = e.course_id
	WHERE e.grade IS NULL
);

-- 7. Find the instructor who teaches courses with the lowest average grade.
SELECT c.instructor_id, i.instructor_name, AVG(e.grade)
FROM instructors i
JOIN courses c ON i.instructor_id = c.instructor_id
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.instructor_id
HAVING AVG(e.grade) = 
(
	SELECT MIN(avg_grade)
    FROM (
		SELECT c.instructor_id, AVG(e.grade) AS avg_grade
		FROM instructors i
		JOIN courses c ON i.instructor_id = c.instructor_id
		JOIN enrollments e ON c.course_id = e.course_id
		GROUP BY c.instructor_id
	) AS avg_grades
);


-- 8. Find students with an average grade higher than 4.0 in at least 2 courses.
SELECT s.student_id, s.student_name 
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
GROUP BY s.student_id
HAVING COUNT(DISTINCT e.course_id) >= 0 AND AVG(e.grade) > 4.0;


-- 9. Select the top 5 students (highest average grades) and display their first and last names.
SELECT s.student_id, s.student_name, AVG(e.grade) 
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
GROUP BY s.student_id
ORDER BY AVG(e.grade) DESC
LIMIT 5;


-- 10. Calculate the age difference between the oldest and youngest student in each course.
SELECT c.course_id, c.course_name, MAX(s.student_age) - MIN(s.student_age) AS 'max - min age diffrence'
FROM courses c
JOIN enrollments e ON e.course_id = c.course_id
JOIN students s ON s.student_id = e.student_id
GROUP BY c.course_id