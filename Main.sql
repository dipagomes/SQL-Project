CREATE DATABASE High_School_Enrollment_System;

USE High_School_Enrollment_System;

DROP TABLE Student;
DROP TABLE Student_Details;
DROP TABLE Requirments;
DROP TABLE School_Year;
DROP TABLE Employee;
DROP TABLE Transactions;
DROP TABLE Cost;


---------------------------------------------- TABLE CREATION -------------------------------

CREATE TABLE Student(
                     Stu_ID                int(11) NOT NULL Auto_INCREMENT,
                     First_name            varchar(50),
                     Last_name             varchar(50),
                     Age                   int(11),
                     Gender                enum ('MALE','FEMALE') DEFAULT NULL,
                     Address               varchar(50),
                     Birthday              date,
                     Nationality           char (50),
                     Blood_Group           varchar(5),
                     Stu_phoneNum          int,
                     PRIMARY KEY(Stu_ID));

CREATE TABLE Student_Details(
                             Detail_ID             int (11) NOT NULL,
                             Stu_ID                int,
                             Fathers_Name          varchar(50),
                             Fathers_Occupation    varchar(50),
                             Mothers_Name          varchar(50),
                             Mothers_Occupation    varchar(50),
                             Guardians_Name        varchar(50),
                             Guardians_Occupation  varchar(50),
                             Parent_PhoneNum       int(11),
                             PRIMARY KEY(Detail_ID),
                             FOREIGN KEY (Stu_ID) REFERENCES Student(Stu_ID) ON DELETE CASCADE);

CREATE  TABLE Requirments(
                         Requirment_ID              int(11) NOT NULL,
                         Stu_ID                     int ,
                         Entrance_Exam_Result       varchar(50),
                         Certificate_of_Transfer    BOOLEAN,
                         PRIMARY KEY (Requirment_ID),
                         FOREIGN KEY (Stu_ID) REFERENCES Student(Stu_ID) ON DELETE CASCADE);

CREATE TABLE School_Year(
                         Stu_ID        int,
                         Year          int(11),
                         Batch         int(11),
                         FOREIGN KEY (Stu_ID) REFERENCES Student(Stu_ID) ON DELETE CASCADE);

CREATE TABLE Employee (
                       Stu_ID           int,
                       Employee_ID      int(11) NOT NULL,
                       First_Name       varchar(50),
                       Last_Name        varchar(50)
                       FOREIGN KEY(Stu_ID) REFERENCES Student(Stu_ID) ON DELETE CASCADE);


ALTER TABLE Employee ADD PRIMARY KEY (Employee_ID);


CREATE TABLE Transactions(
                        Trans_ID          int(11) NOT NULL,
                        Stu_ID            int,
                        Employee_ID       int,
                        Amount_Paid       varchar(50),
                        Balance           varchar(50),
                        Payment_date      datetime NOT NULL DEFAULT CURRENT_TIMESTAMP);


ALTER TABLE Transactions ADD CONSTRAINT pk_transaction PRIMARY KEY(Trans_ID);

ALTER TABLE Transactions ADD FOREIGN KEY (Employee_ID) REFERENCES employee(Employee_ID) ON DELETE CASCADE;

ALTER TABLE Transactions ADD FOREIGN KEY (Stu_ID) REFERENCES Student(Stu_ID) ON DELETE CASCADE;



CREATE TABLE Cost(
                   Project_Making_Cost         double NOT NULL,
                   Project_Maintainance_Cost   double NOT NULL);



DESCRIBE  Student;
DESCRIBE  Student_Details;
DESCRIBE  Requirments;
DESCRIBE  School_Year;


DELETE FROM Student;
DELETE FROM Student_Details;
DELETE FROM Requirments;
DELETE FROM School_Year;
DELETE FROM Employee;
DELETE FROM Transactions;
DELETE FROM Cost;


------------------------- DATA INSERTION ------------------------------

INSERT INTO student 
VALUES 
(NULL,'Abir','Ahmed',18,'MALE','Dhaka','11-04-04','Bangladeshi','A+',235678),
(NULL,'Samina','Khan',17,'FEMALE','Barishal','01-07-05','Bangladeshi','AB+',215785),
(NULL,'Rumana','Ferdaus',18,'FEMALE','Dhaka','26-12-04','Bangladeshi','B+',213490),
(NULL,'Aiden','Rosario',19,'MALE','Rajshahi','13-02-03','Bangladeshi','O+',201289),
(NULL,'Salman','Shikder',18,'MALE','Thakurgaon','07-09-04','Bangladeshi','A-',228565);




INSERT INTO student_details
VALUES
(101,1,'Farhan Ahmed','Doctor','Rumana Sheikh','Housewife','Farhan Ahmed','Doctor',01246485010),
(201,2,'Ahsanullah Khan','Businessman','Purbita Chowdhury','Nurse','Monir Khan','Sevice Holder',01345713510),
(301,3,'Sazzad Alam','CA','Rubaiya Tasnim','Housewife','Sazzad Alam','CA',01678485010),
(401,4,'Jacob Rosairio','Teacher','Ana Costa','Teacher',NULL,NULL,01239810542),
(501,5,'Ali Shikder','Banker','Humaira Tasmim','Lecturer','Mahmudullah','Banker',01237842901);



INSERT INTO requirments
VALUES
(121,1,'Passed',True),
(221,2,'Passed',False),
(321,3,'Passed',True),
(421,4,'Passed',True),
(521,5,'Passed',False);


INSERT INTO school_year
VALUES
(1,2019,68),
(2,2019,68),
(3,2019,68),
(4,2018,67),
(5,2019,68);


INSERT INTO employee
VALUES
(301200,'Mahabub','Alam',1),
(301345,'Bindu','Roy',2),
(301245,'Solaiman','Shikder',3),
(301546,'Progga','Chowdhury',4),
(301295,'Niloy','Ahmed',5);

INSERT INTO transactions
VALUES
(525,1,301200,25000,NULL,NULL),
(124,2,301345,23000,2000,NULL),
(895,3,301245,20000,5000,NULL),
(333,4,301546,25000,NULL,NULL),
(721,5,301295,25000,NULL,NULL);


---------------------------------- TRIGGER -----------------------------------
DELIMITER $$
CREATE TRIGGER Making_Cost_Constrains
BEFORE INSERT ON cost
FOR EACH ROW
BEGIN
IF NEW.Project_Making_Cost>150000 THEN SET NEW.Project_Making_Cost = 150000;
END IF;
END;
$$

DELIMITER $$
CREATE TRIGGER Maintainance_Cost_Constrains
BEFORE INSERT ON cost
FOR EACH ROW
BEGIN
IF NEW.Project_Maintainance_Cost >50000 THEN SET NEW.Project_Maintainance_Cost = 50000;
END IF;
END;
$$


INSERT INTO cost
VALUES (200000,100000);



SELECT* FROM Student;
SELECT* FROM Student_Details;
SELECT* FROM Requirments;
SELECT* FROM School_Year;
SELECT* FROM Employee;
SELECT* FROM Transactions;
SELECT* FROM Cost;



--------------------- ALTER -----------------------------------

ALTER TABLE student
ADD COLUMN Mail_Address int(15);

ALTER TABLE student
MODIFY COLUMN Mail_Address varchar(20);

ALTER TABLE student
CHANGE COLUMN Mail_Address Email varchar(20);

ALTER TABLE student
DROP COLUMN Email;



-------------------- SELECT OPERATION --------------------------

SELECT Stu_ID,Fathers_Name,Mothers_Name,Parent_PhoneNum
FROM student_details;


SELECT DISTINCT First_Name,Last_Name
FROM student;

SELECT  Stu_ID 
FROM requirments
WHERE Entrance_Exam_Result = 'Passed';

SELECT * 
FROM student
WHERE First_Name = 'Abir' AND Last_Name = 'Ahmed';


SELECT * 
FROM student
WHERE First_Name = 'Rumana' OR Last_Name = 'Shikder';

SELECT Trans_ID
FROM transactions
WHERE Employee_ID = 301345 AND Balance <= 10000;

SELECT Trans_ID
FROM transactions
WHERE Employee_ID = 301345 OR Balance >= 2000;


-------------------- NULL OPERATION -------------------

SELECT Stu_ID
FROM transactions
WHERE Balance IS NULL;

SELECT Detail_ID
FROM student_details
WHERE Guardians_Name IS NOT NULL;


------------------ UPDATE OPERATION---------------------

UPDATE transactions
SET Amount_Paid = 22000, Balance = 3000
WHERE Stu_ID = 1;


------------------- LIMIT --------------------------------
SELECT First_Name,Last_Name
FROM student
LIMIT 2,4


SELECT *
FROM student_details
WHERE Stu_ID BETWEEN 1 AND 3;


SELECT First_Name,Last_Name
FROM student
WHERE Age IN(17,19);

SELECT First_Name,Last_Name
FROM student
WHERE Age NOT IN(17,19);

SELECT Stu_ID
FROM transactions
WHERE Amount_Paid BETWEEN 20000 AND 25000;

SELECT Stu_ID
FROM transactions
WHERE Amount_Paid NOT BETWEEN 20000 AND 23000;


-----------Cartesian Product-----------------------
SELECT *
FROM student,student_details
WHERE student.Stu_ID = student_details.Stu_ID AND First_Name = 'Abir';


-------------RENAME---------------------------------
SELECT DISTINCT S.First_Name
FROM student as S , student_details as D
WHERE S.Stu_ID = D.Stu_ID;

-------------STRING OPERATION------------------------

SELECT First_name,Last_name
FROM student
WHERE First_name LIKE '%na%';


SELECT First_name,Last_name
FROM student
WHERE First_name LIKE '%n';

SELECT First_name,Last_name
FROM student
WHERE First_name LIKE 'S%';

SELECT *
FROM student
WHERE First_name LIKE '____';


------------AGGREGATE FUNCTION--------------------------


SELECT COUNT(DISTINCT Stu_ID)
FROM student
WHERE Age = 18;

SELECT COUNT(*)
FROM student_details


SELECT AVG(Amount_Paid) AS avg_amount_paid 
FROM transactions;

SELECT MAX(Amount_Paid) Max_Amount FROM transactions;

SELECT MIN(Amount_Paid) Min_Amount FROM transactions;

SELECT SUM(Balance)
FROM transactions;

SELECT*
FROM student
ORDER BY First_name DESC;


SELECT First_name,Last_name,AVG(Age)
FROM student
GROUP BY Address
HAVING AVG(Age)>17;


--------------------- SET OPERATION --------------------------

SELECT First_name,Stu_phoneNum FROM student WHERE Gender = 'MALE' AND Blood_Group='A+'
UNION
SELECT First_name,Stu_phoneNum FROM student WHERE Gender = 'FEMALE' AND Blood_Group='AB+';


SELECT First_name,Stu_phoneNum FROM student WHERE Gender = 'MALE' AND Blood_Group='A+'
INTERSECT
SELECT First_name,Stu_phoneNum FROM student WHERE Gender = 'FEMALE' AND Blood_Group='AB+';


SELECT First_name,Stu_phoneNum FROM student WHERE Gender = 'MALE' AND Blood_Group='A+'
EXCEPT
SELECT First_name,Stu_phoneNum FROM student WHERE Gender = 'FEMALE' AND Blood_Group='AB+';






------------------JOIN OPERATION--------------------
SELECT *
FROM student
INNER JOIN student_details
ON student.Stu_ID = student_details.Stu_ID;

SELECT *
FROM student
LEFT JOIN transactions
ON student.Stu_ID = transactions.Stu_ID;

SELECT First_name,Last_name,Amount_Paid,Balance
FROM student
RIGHT JOIN transactions
ON student.Stu_ID = transactions.Stu_ID;

SELECT First_name,Last_name,Amount_Paid,Balance
FROM student
CROSS JOIN transactions
WHERE student.Stu_ID = transactions.Stu_ID;



