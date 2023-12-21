--TASK 1: DATABASE DESIGN
CREATE DATABASE SISDB;
USE SISDB;

--TASK 2: DATA DEFINITION LANGUAGE(DDL)

CREATE TABLE STUDENTS(
student_id INT PRIMARY KEY,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
date_of_birth DATE,
email VARCHAR(30),
 phone_number VARCHAR(20)
);

CREATE TABLE TEACHER(
teacher_id INT PRIMARY KEY,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email VARCHAR(30)

);


CREATE TABLE COURSES(
course_id INT PRIMARY KEY,
course_name VARCHAR(20) NOT NULL,
credits VARCHAR(30),
teacher_id INT REFERENCES TEACHER(teacher_id) ON DELETE CASCADE

);

CREATE TABLE ENROLLMENTS(
enrollment_id INT PRIMARY KEY,
student_id INT REFERENCES STUDENTS(student_id) ON DELETE CASCADE,
course_id INT REFERENCES COURSES(course_id) ON DELETE CASCADE,
enrollment_date DATE


);

CREATE TABLE PAYMENTS(
payment_id INT PRIMARY KEY,
student_id INT REFERENCES STUDENTS(student_id) ON DELETE CASCADE,
amount INT NOT NULL,
payment_date DATE


);

--TASK 3: DATA MANIPULATION LANGUAGE(DML)
--3.A ADD 10 RECORDS

-- Students table
-- Students table

INSERT INTO  STUDENTS(student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES (1,'Pratik','Kumar','2002-03-10','pw@email.com','1234345'), (2,'Aanya','Sharma','2000-08-22','as@email.com','54565678'),
  (3,'Advait','Patel','1998-05-01','ap@email.com','5679876'), (4,'Ananya','Mishra','2003-11-18','am@email.com','5434321'),
  (5,'Arjun','Gupta','1997-07-04','ag@email.com','5548765'),(6,'Ayesha','Singh','1999-09-30','as@email.com','5672345'),
  (7,'Divya','Verma','1999-02-15','dv@email.com','6556789'),(8,'Hrithik','Reddy','1992-12-08','hr@email.com','56553456'),
  (9,'Ishaan','Joshi','2001-06-25','ij@email.com','1057890'),(10,'Kavya','Rao','1990-04-03','kr@email.com','65431234');


SELECT * FROM STUDENTS;


INSERT INTO TEACHER (teacher_id, first_name, last_name, email)
VALUES (1,'Anmol','Gupta','prof.gupta@email.com'), (2,'Anjali','Sharma','dr.sharma@email.com'), (3,'Pratik','Singh','ms.singh@email.com'),
(4,'Chetan','Joshi','mr.joshi@email.com'), (5,'Rajaram','Rao','dr.rao@email.com'),(6,'Ashish','Gupta','prof.gupta@email.com'), 
(7,'Manohar','Shantilal','dr.shantilal@email.com'), (8,'Manoj','Singh','ms.singh@email.com'),
(9,'Ish','Joshi','mr.joshi@email.com'), (10,'Darshan','Raut','dr.raut@email.com');

SELECT * FROM TEACHER;

INSERT INTO COURSES (course_id, course_name, credits, teacher_id)
VALUES (101,'Computer Science',3,1),(102,'History',4,2), (103,'Mathematics',3,3),(104,'English',4,4),
(105,'Chemistry',3,5),(106,'Psychology',4,6),(107,'Economics',3,7),
(108,'Physics',4,8),(109,'Political Science',3,9),(110,'Music',4,10);

SELECT * FROM COURSES;




INSERT INTO ENROLLMENTS (enrollment_id, student_id, course_id, enrollment_date)
VALUES(1001,1,101,'2023-01-10'),(1002,2,102,'2023-01-12'),(1003,3,103,'2023-01-15'),(1004,4,104,'2023-01-20'),
  (1005,5,105,'2023-01-25'),(1006,6,106,'2023-02-01'),(1007,7,107,'2023-02-05'),(1008,8,108,'2023-02-10'),
  (1009,9,109,'2023-02-15'),(1010,10,110,'2023-02-20');

SELECT * FROM ENROLLMENTS;

INSERT INTO Payments (payment_id, student_id, amount, payment_date)
VALUES(5001,1,5500,'2023-02-01'),(5002,2,5600,'2023-02-03'),(5003,3,5550,'2023-02-05'),(5004,4,5700,'2023-02-07'),
  (5005,5,5450,'2023-02-09'),(5006,6,5800,'2023-02-11'),(5007,7,5600,'2023-02-13'),(5008,8,5750,'2023-02-15'),
  (5009,9,5500,'2023-02-17'),(5010,10,5650,'2023-02-19');


SELECT * FROM PAYMENTS;

--TASK 3.B BASIC QUERIES
--1)
INSERT INTO  STUDENTS(student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES (11,'John','Doe','1995-08-15','john.doe@example.com','1234567890')

--2)
INSERT INTO ENROLLMENTS (enrollment_id, student_id, course_id, enrollment_date)
VALUES(1011,1,102,'2023-01-13');

--3)
UPDATE TEACHER SET email='anmolgupta@emil.com'
WHERE teacher_id=1;

--4)
--THE ROW WHICH ADDED IN 2ND QUERY IS DELETED HERE

DELETE FROM ENROLLMENTS WHERE student_id=1 AND course_id=102; 

--5)
UPDATE COURSES SET teacher_id=8 WHERE course_id=105;

--6)
/* HERE I USED ON DELETE CASCADE SO THE RECORD OF STUDENT WITH ID 6 
WILL BE DELETED FROM OTHER TABLES AUTOMATICALLY SO REFERENTIAL 
INTEGRITY WILL MAINTAIN*/

DELETE FROM STUDENTS WHERE student_id=9;
SELECT * FROM ENROLLMENTS;

--7)
UPDATE PAYMENTS SET amount=3000 WHERE payment_id=5005;

--TASK 4: JOINS
--1)
SELECT STUDENTS.first_name,STUDENTS.last_name,COUNT(*) AS TOTAL_NO_PAYMENTS
FROM STUDENTS INNER JOIN  PAYMENTS ON
STUDENTS.student_id=PAYMENTS.student_id
GROUP BY STUDENTS.first_name,STUDENTS.last_name;

--2)

SELECT COURSES.course_name,COUNT(*) AS TOTAL_STUDENTS
FROM COURSES INNER JOIN ENROLLMENTS ON
COURSES.course_id=ENROLLMENTS.course_id
GROUP BY COURSES.course_name;

--3)
SELECT STUDENTS.first_name,STUDENTS.last_name FROM
STUDENTS LEFT JOIN ENROLLMENTS ON
STUDENTS.student_id=ENROLLMENTS.student_id WHERE enrollment_id IS NULL;

--4)
SELECT STUDENTS.first_name,STUDENTS.last_name,COURSES.course_name FROM
STUDENTS INNER JOIN ENROLLMENTS ON
STUDENTS.student_id=ENROLLMENTS.student_id 
INNER JOIN COURSES ON
COURSES.course_id=ENROLLMENTS.course_id;

--5)
SELECT TEACHER.first_name,TEACHER.last_name, COURSES.course_name AS TOTAL_STUDENTS
FROM COURSES INNER JOIN TEACHER ON
COURSES.teacher_id=TEACHER.teacher_id;

--6)
SELECT STUDENTS.first_name,STUDENTS.last_name,COURSES.course_name,ENROLLMENTS.enrollment_date FROM
STUDENTS INNER JOIN ENROLLMENTS ON
STUDENTS.student_id=ENROLLMENTS.student_id 
INNER JOIN COURSES ON
COURSES.course_id=ENROLLMENTS.course_id;

--7)
SELECT STUDENTS.first_name,STUDENTS.last_name FROM
STUDENTS LEFT JOIN PAYMENTS ON
STUDENTS.student_id=PAYMENTS.student_id WHERE payment_id IS NULL;


--8)
SELECT COURSES.course_name FROM
COURSES LEFT JOIN ENROLLMENTS ON
COURSES.course_id=ENROLLMENTS.course_id WHERE enrollment_id IS NULL;

--9)
SELECT ENROLLMENTS.student_id FROM ENROLLMENTS
SELF JOIN ENROLLMENTS ON
ENROLLMENTS.student_id=ENROLLMENTS.student_id
GROUP BY ENROLLMENTS.student_id HAVING COUNT(*)>1;

--10)
INSERT INTO TEACHER (teacher_id, first_name, last_name, email)
VALUES (12,'Prakash','Chaudhari','pc@email.com');
SELECT TEACHER.*,TEACHER.first_name,TEACHER.last_name FROM
TEACHER LEFT JOIN COURSES ON
TEACHER.teacher_id=COURSES.teacher_id WHERE COURSES.course_id IS NULL;

--TASK 5

--1)


--2)
select first_name, last_name from STUDENTS
where student_id in 
( select student_id from PAYMENTS where payment_id 
in( select max(payment_id) from PAYMENTS))

--3)
SELECT * FROM ENROLLMENTS;

INSERT INTO ENROLLMENTS (enrollment_id, student_id, course_id, enrollment_date)
VALUES(1011,4,101,'2023-01-12')

SELECT COURSES.course_name FROM COURSES WHERE 
course_id = ( SELECT TOP(1) course_id FROM ENROLLMENTS GROUP BY course_id ORDER BY COUNT(*) DESC);

--4)

SELECT COURSES.course_name,TEACHER.first_name,SUM(PAYMENTS.amount) FROM
TEACHER INNER JOIN COURSES ON
TEACHER.teacher_id=COURSES.teacher_id
INNER JOIN ENROLLMENTS ON
COURSES.course_id=ENROLLMENTS.course_id
INNER JOIN STUDENTS ON STUDENTS.student_id=ENROLLMENTS.student_id
INNER JOIN PAYMENTS ON PAYMENTS.student_id=STUDENTS.student_id
GROUP BY COURSES.course_name,TEACHER.first_name;

--5)
SELECT ENROLLMENTS.student_id FROM ENROLLMENTS
GROUP BY student_id HAVING COUNT(*)> (SELECT COUNT(*) FROM COURSES);

--6)
SELECT TEACHER.first_name FROM TEACHER 
WHERE teacher_id NOT IN ( SELECT teacher_id FROM COURSES);

--7)
SELECT AVG(TEMP.AGE) FROM ( SELECT DATEDIFF(YEAR,date_of_birth,GETDATE())  AS AGE FROM STUDENTS)AS TEMP;

--8)
SELECT ENROLLMENTS.course_id FROM ENROLLMENTS WHERE course_id 
NOT IN(SELECT course_id FROM COURSES);

--9) 
SELECT STUDENTS.first_name,PAYMENTS.student_id,SUM(PAYMENTS.amount) AS TOTAL_PAYMENT_DONE FROM
PAYMENTS INNER JOIN STUDENTS ON
PAYMENTS.student_id=STUDENTS.student_id
GROUP BY PAYMENTS.student_id,STUDENTS.first_name;

--10)
SELECT student_id, CONCAT(first_name, ' ', last_name) as student_name
FROM Students
WHERE student_id IN (SELECT student_id FROM Payments GROUP BY [student_id]  HAVING COUNT(payment_id) > 1);


 --11)
SELECT s.student_id, CONCAT(s.first_name, ' ', s.last_name) as student_name, ISNULL(SUM(p.amount), 0) as total_payments
FROM Students s LEFT JOIN Payments p
ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name;


--12)
SELECT c.course_id, c.course_name, ISNULL(COUNT(e.student_id), 0) as TotalEnrollments
FROM Courses c LEFT JOIN Enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

--13)
SELECT s.student_id, CONCAT(s.first_name, ' ', s.last_name) as student_name, 
ISNULL(AVG(p.amount), 0) as AveragePaymentAmount
FROM Students s LEFT JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name;