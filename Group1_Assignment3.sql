/*
============================================
Author:  Oghenemaro David Oroh    
Student Number: 200492343
Creation date: 28/03/22
Description: Assignment 3
============================================
*/

-- Part one --
##Step 1
CREATE DATABASE Assignment3;
USE Assignment3;
##Used data import wizard

##Step 2
INSERT INTO `my_contacts` (`last_name`,`first_name`,`email`,`gender`,`birthday`,`profession`,`postal_code`,`status`,`attributes`,`friends`)
VALUES('Oroh','Maro','ogh@gmail.com','M','2000-06-14','Greek Soldier','L6M 5I5','committed relationsh','Smart;Dependable;Cheerful','Tejiri Phido'),
('Agih', 'Chi', 'chi@gmail.com', 'M', '2001-02-14', 'Baker', 'L6M 5e5', 'committed relationsh','Annoying;Dependable;Cheerful', 'Jacob Sartorius'),
('Matt', 'Gut', 'gut@gmail.com', 'F', '1995-03-17', 'Field Marshall', 'Y6M 4I5', 'married','Funny;Intellectual;Cheerful', 'Lucy Willa'),
('Katy', 'Akoto', 'akt@gmail.com', 'F', '1987-01-12', 'Accountant', 'U1D 2B(', 'single','Empathetic;Well-Mannered;Resourceful', 'Joel Schneider'),
('Gharius', 'Patrick', 'gha@gmail.com', 'M', '2002-11-28', 'Student', 'P1K 4X9', 'committed relationsh','Energetic;Sly;Quick-Witted', 'James Julius'),
('Julius', 'James', 'jul@gmail.com', 'M', '2005-06-14', 'Student', 'L1Y 2H8', 'single','Resourceful;Intelligent;Genius', 'Gabby Martinez'),
('Martinez', 'Gabby', 'mar@gmail.com', 'F', '1999-12-03', 'Barista', 'Y2M 8R4', 'single','Smart;Dependable;Cheerful', 'Gerry Rogers'),
('Rogers', 'Gerry', 'rog@gmail.com', 'F', '1992-03-14', 'Software Engineer', 'P6L 8I8', 'married','Smart;Quick-Witted;Meticulous', 'Lisa Terry'),
('Terry', 'Lisa', 'ter@gmail.com', 'F', '1998-07-21', 'Dancer', 'J1P 3O2', 'committed relationsh','Empathic;Leader;Hard Working', 'Tejiri Phido'),
('Phido', 'Tejiri', 'tej@gmail.com', 'F', '2001-06-28', 'Bus. Exec', 'E1E 3I3', 'committed relationsh','Smart;Leader;Funny', 'Oghenemaro Oroh');

SELECT *
FROM my_contacts;

#Step 3

ALTER TABLE my_contacts
ADD COLUMN ID INT NOT NULL AUTO_INCREMENT FIRST,
ADD PRIMARY KEY (ID);
#Adds an autoincrementing primary key to my_contacts

CREATE TABLE attributes
	SELECT attributes
	FROM my_contacts;
#Extracts the my-contacts.attributes column to a new table


ALTER TABLE attributes
ADD COLUMN attribute_1 VARCHAR(25),
ADD COLUMN attribute_2 VARCHAR(25),
ADD COLUMN attribute_3 VARCHAR(25);
#Adds two empty columns to contain attribute data

SELECT *
FROM attributes;

UPDATE attributes
	SET attribute_1 = SUBSTRING_INDEX(attributes,';',1)
    WHERE LENGTH (attributes)>0;
#Copies the first attribute to attributes_1 from the attributes column

UPDATE attributes
	SET attributes = SUBSTR(attributes,LENGTH(attribute_1)+2)
    WHERE LENGTH(attributes)>0;
#Removes the first attribute from attribute by extracting a substring that only
#starts at the position of attribute_1+2

UPDATE attributes
	SET attribute_2 = SUBSTRING_INDEX(attributes,';',1)
    WHERE LENGTH (attributes)>0;
#Copies the second attribute to attributes_2 from the attributes column

UPDATE attributes
	SET attributes = SUBSTR(attributes,LENGTH(attribute_2)+2)
    WHERE LENGTH(attributes)>0;
#Removes the first attribute from attributes by extracting a substring that only
#starts at the position of attribute_1+2

UPDATE attributes
	SET attribute_3 = SUBSTRING_INDEX(attributes,';',1)
    WHERE LENGTH (attributes)>0;
#Copies the second attribute to attributes_3 from the attributes column

ALTER TABLE attributes DROP COLUMN attributes;

ALTER TABLE attributes
ADD COLUMN ID INT NOT NULL AUTO_INCREMENT FIRST,
ADD PRIMARY KEY (ID);
#Adds an autoincrementing primary key to attributes


#Creating friends table
CREATE TABLE friends
	SELECT friends
	FROM my_contacts;
#Extracts the my-contacts.friends column to a new table

ALTER TABLE friends
ADD COLUMN friend_1 VARCHAR(45),
ADD COLUMN friend_2 VARCHAR(45);
#Adds two empty columns to contain friends data

SELECT *
FROM friends;
#test

UPDATE friends
	SET friend_1 = SUBSTRING_INDEX(friends,';',1)
    WHERE LENGTH (friends)>0;
#Copies the first friend to friendss_1 from the friends column

UPDATE friends
	SET friends = SUBSTR(friends,LENGTH(friend_1)+2)
    WHERE LENGTH(friends)>0;
#Removes the first friend from friends by extracting a substring that only
#starts at the position of friends_1+2

UPDATE friends
	SET friend_2 = SUBSTRING_INDEX(friends,';',1)
    WHERE LENGTH (friends)>0;
#Copies the first friend to friends_1 from the attributes column

UPDATE friends
	SET friends = SUBSTR(friends,LENGTH(friend_2)+2)
    WHERE LENGTH(friends)>0;
#Removes the first friend from friends by extracting a substring that only
#starts at the position of friends_1+2

ALTER TABLE friends DROP COLUMN friends;

ALTER TABLE friends
ADD COLUMN ID INT NOT NULL AUTO_INCREMENT FIRST,
ADD PRIMARY KEY (ID);
#Adds an autoincrementing primary key to friends

#Creating contact_friends table
CREATE TABLE contact_friends
	SELECT ID AS contact_ID
	FROM my_contacts;
    
ALTER TABLE contact_friends ADD COLUMN friend_id INT(11) NOT NULL;

UPDATE contact_friends c
INNER JOIN my_contacts m
SET c.friend_id = m.ID;
    
SELECT * 
FROM contact_friends;
#test

#Creating contact_attributes table
CREATE TABLE contact_attributes
	SELECT ID AS contact_ID
	FROM my_contacts;

UPDATE contact_attributes c
INNER JOIN my_contacts 
SET c.attribute_id = my_contacts.ID;
#Matching column data to another
    
SELECT * 
FROM my_contacts;
#testing

ALTER TABLE my_contacts DROP COLUMN attributes;
ALTER TABLE my_contacts DROP COLUMN friends;
#Dropping redundant columns







-- PART 2 --

CREATE TABLE Clients
(
C_ID INT PRIMARY KEY,
Name Varchar(50),
Address Varchar(100)
);
#Creating clients table with 3 columns

CREATE TABLE Pets
(
P_ID INT  PRIMARY KEY,
Name VARCHAR(20),
C_ID INT REFERENCES Clients (C_ID)
);
#creating pets table with 3 columns

CREATE TABLE Pet_Procedures
(
PP_ID INT  PRIMARY KEY,
Pet_Procedure Varchar(50),
Amount DOUBLE
);
#Creating Pet Procedures table with 3 columns

CREATE TABLE Sessions
(
S_ID INT,
C_ID INT REFERENCES Clients (C_ID),
P_ID INT REFERENCES Pets (P_ID),
PP_ID INT REFERENCES Pet_Procedures (PP_ID)
);
#creating Sessions table with 3 columns
alter table Sessions drop primary key;

CREATE TABLE Invoice
(
I_ID INT NOT NULL,
C_ID INT REFERENCES Clients (C_ID),
S_ID INT REFERENCES Pet_Procedures (PP_ID),
DateOfVisit DATE,
Total DOUBLE,
Tax DOUBLE,
Amount_Owing DOUBLE
);
#Creating Invoice table with 7 columns

INSERT INTO Clients VALUES (1, 'MR. RICHARD COOK', '123 THIS STREET MY CITY, ONTARIO Z5Z 6G6');
INSERT INTO Clients VALUES (2, 'MRS. DENISE RODMAN', '246 THAT STREET ANOTHER CITY, ONTARIO A1A 1A1');
#Inserting Values into Clients table

SELECT *
FROM Clients;
 #testing

INSERT INTO Pets VALUES (1, 'ROVER', 1);
INSERT INTO Pets VALUES (2, 'MORRIS', 1);
INSERT INTO Pets VALUES (3, 'CHEW BARKA', 2);
INSERT INTO Pets VALUES (4, 'MARY PUPPINS', 2);
#Inserting values into Pets table

SELECT *
FROM Pets;
#Testing

INSERT INTO Pet_Procedures VALUES (1, 'RABIES VACCINATION', 30.00);
INSERT INTO Pet_Procedures VALUES (2, 'RABIES VACCINATION', 24.00);
INSERT INTO Pet_Procedures VALUES (3, 'SWALLOWED SOCK', 3000.00);
INSERT INTO Pet_Procedures VALUES (4, 'BLOOD WORK', 150.00);
#Inserting values into Pet_Procedures table

SELECT *
FROM Pet_Procedures;
#testing

INSERT INTO Sessions VALUES (1, 1, 1, 1);
INSERT INTO Sessions VALUES (1, 1, 1, 2);
INSERT INTO Sessions VALUES (2, 2, 2, 3);
INSERT INTO Sessions VALUES (2, 2, 2, 4);
#Inserting values into Sessions table

SELECT *
FROM Sessions;
#Testing
 
INSERT INTO Invoice VALUES (1, 1, 1, '2020-01-13', 30, 3.9, 33.9);
INSERT INTO Invoice VALUES (1, 1, 1, '2020-01-13', 24, 3.12, 27.12);
INSERT INTO Invoice VALUES (2, 2, 2, '2020-01-14', 3000, 390, 3390);
INSERT INTO Invoice VALUES (2, 2, 2, '2020-01-14', 150, 19.5, 169.5);
#Inserting Values into Invoice table

SELECT *
FROM Invoice;
#Testing