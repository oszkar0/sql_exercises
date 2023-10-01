/*
	 1. Calculate the average age of pets by species
	 2. Find the clinics with the highest and lowest number of veterinarians
	 3. Rank veterinarians by salary within each clinic
	 4. List pets that have not had any visits
	 5. - Calculate the total number of visits for each veterinarian
	 6. - Divide vets into two groups based on the height of their salary within each clinic
	 7. - List owners who have multiple pets and their pets' names
 */

DROP SCHEMA IF EXISTS veterinary;
CREATE SCHEMA veterinary;
USE veterinary;


-- Create the clinics table for clinic information
CREATE TABLE clinics (
    clinic_id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(15)
);

-- Insert sample data into the clinics table
INSERT INTO clinics (clinic_id, name, address, phone)
VALUES
    (1, 'Main Street Animal Clinic', '123 Main St, City, Country', '123-456-7890'),
    (2, 'Northside Vet Clinic', '456 Elm St, City, Country', '987-654-3210');

-- Create the owners table for owner information
CREATE TABLE owners (
    owner_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(15)
);

-- Insert sample data into the owners table
INSERT INTO owners (owner_id, first_name, last_name, email, address, phone)
VALUES
    (1, 'John', 'Doe', 'john@example.com', '789 Oak St, City, Country', '555-123-4567'),
    (2, 'Jane', 'Smith', 'jane@example.com', '456 Maple Ave, City, Country', '555-987-6543'),
    (3, 'Michael', 'Brown', 'michael@example.com', '123 Pine Rd, City, Country', '555-789-0123'),
    (4, 'Emily', 'Davis', 'emily@example.com', '789 Cedar Ln, City, Country', '555-456-7890');

-- Create the pets table for patient information with date of birth
CREATE TABLE pets (
    pet_id INT PRIMARY KEY,
    name VARCHAR(50),
    species VARCHAR(50),
    date_of_birth DATE,
    owner_id INT,
    FOREIGN KEY (owner_id) REFERENCES owners(owner_id)
);

-- Insert sample data into the pets table with date of birth
INSERT INTO pets (pet_id, name, species, date_of_birth, owner_id)
VALUES
    (1, 'Fluffy', 'Cat', '2018-03-15', 1),
    (2, 'Rex', 'Dog', '2020-05-20', 2),
    (3, 'Whiskers', 'Cat', '2021-09-10', 3),
    (4, 'Buddy', 'Dog', '2019-07-25', 4),
    (5, 'Marcel', 'Cat', '2010-07-25', 4);

-- Create the vets table for vet information including clinic_id and salary
CREATE TABLE vets (
    vet_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialty VARCHAR(100),
    clinic_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (clinic_id) REFERENCES clinics(clinic_id)
);

-- Insert sample data into the vets table
INSERT INTO vets (vet_id, first_name, last_name, specialty, clinic_id, salary)
VALUES
    (1, 'Dr. Sarah', 'Johnson', 'Dermatology', 1, 70000.00),
    (2, 'Dr. Michael', 'Smith', 'Internal Medicine', 2, 75000.00),
    (3, 'Dr. Emily', 'Wilson', 'Orthopedics', 1, 72000.00),
    (4, 'Dr. Oskar', 'Wilson', 'Dermatology', 2, 71000.00),
	(5, 'Dr. Robert', 'Johnson', 'Dermatology', 1, 80000.00),
    (6, 'Dr. Michael', 'Scott', 'Internal Medicine', 2, 90000.00),
    (7, 'Dr. Alex', 'Wilson', 'Orthopedics', 1, 75000.00),
    (8, 'Dr. Oskar', 'Robust', 'Dermatology', 2, 69000.00);

-- Create the visits table for visit history
CREATE TABLE visits (
    visit_id INT PRIMARY KEY,
    pet_id INT,
    vet_id INT,
    visit_date DATE,
    diagnosis VARCHAR(255),
    FOREIGN KEY (pet_id) REFERENCES pets(pet_id),
    FOREIGN KEY (vet_id) REFERENCES vets(vet_id)
);

-- Insert sample data into the visits table
INSERT INTO visits (visit_id, pet_id, vet_id, visit_date, diagnosis)
VALUES
    (1, 1, 1, '2023-01-15', 'Routine checkup'),
    (2, 2, 2, '2023-02-20', 'Vaccination'),
    (3, 3, 3, '2023-03-10', 'Injury evaluation'),
    (4, 4, 1, '2023-04-05', 'Dental cleaning');

    
-- 1. Calculate the average age of pets by species:
SELECT p.species, AVG(DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), date_of_birth)), '%Y')) as 'AGE'
FROM pets p 
GROUP BY p.species;

-- 2. Find the clinics with the highest and lowest number of veterinarians:
SELECT c.clinic_id, c.name, COUNT(v.vet_id) as 'Number of veterinarians'
FROM vets v
LEFT JOIN clinics c ON c.clinic_id = v.clinic_id
GROUP BY c.clinic_id
HAVING COUNT(v.vet_id) = (
	SELECT MAX(num_vets)
    FROM ( 
		SELECT c.clinic_id, c.name, COUNT(v.vet_id) as num_vets
		FROM vets v
		LEFT JOIN clinics c ON c.clinic_id = v.clinic_id
		GROUP BY c.clinic_id) AS temp)
UNION
SELECT c.clinic_id, c.name, COUNT(v.vet_id) as 'Number of veterinarians'
FROM vets v
LEFT JOIN clinics c ON c.clinic_id = v.clinic_id
GROUP BY c.clinic_id
HAVING COUNT(v.vet_id) = (
	SELECT MIN(num_vets)
    FROM ( 
		SELECT c.clinic_id, c.name, COUNT(v.vet_id) as num_vets
		FROM vets v
		LEFT JOIN clinics c ON c.clinic_id = v.clinic_id
		GROUP BY c.clinic_id) AS temp);

-- 3. Rank veterinarians by salary within each clinic:
SELECT CONCAT(v.first_name, ' ', v.last_name) as 'Vet name', v.salary, 
c.name, DENSE_RANK() OVER(PARTITION BY c.clinic_id ORDER BY v.salary DESC) AS 'Salary rank' 
FROM vets v
JOIN clinics c ON c.clinic_id = v.clinic_id;

-- 4. List pets that have not had any visits:
SELECT p.pet_id, p.name
FROM pets p
WHERE p.pet_id NOT IN (
	SELECT v.pet_id 
    FROM visits v);

-- 5. - Calculate the total number of visits for each veterinarian:
SELECT ve.first_name, ve.last_name, COUNT(vi.visit_id)
FROM vets ve
LEFT JOIN visits vi ON vi.vet_id = ve.vet_id
GROUP BY ve.vet_id;

-- 6. - Divide vets into two groups based on the height of their salary within each clinic:
SELECT v.first_name, v.last_name, c.name, NTILE(2) OVER (PARTITION BY c.clinic_id ORDER BY v.salary ASC) as "Group number", v.salary
FROM vets v
JOIN clinics c ON c.clinic_id = v.clinic_id;


-- 7. - List owners who have multiple pets and their pets' names:

SELECT o.first_name, o.last_name, p.name
FROM owners o
JOIN pets p ON p.owner_id = o.owner_id
WHERE o.owner_id IN (
	SELECT o.owner_id
    FROM owners o
	JOIN pets p ON p.owner_id = o.owner_id
    GROUP BY o.owner_id
    HAVING COUNT(p.pet_id) > 1
);
    



