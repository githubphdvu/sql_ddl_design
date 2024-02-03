--$psql < filename.sql or $psql -d dbname -f filename.sql or #\i filename.sql
--$psql
--#\l (databases)(^D:quit)
--#\c medicalcenter
--medicalCenter=#\dt (tables)(q:quit)
--...#\d doctors (table structure)
--...#SELECT * FROM doctors; (all records from table)
DROP DATABASE IF EXISTS medicalcenter;
CREATE DATABASE medicalcenter;--or --$createdb medicalcenter
\c medicalcenter;
CREATE TABLE Doctors (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    specialty VARCHAR(255)
);
CREATE TABLE Patients (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    insurance VARCHAR(255),
    birthday DATE
);
CREATE TABLE Visits (
    id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    date DATE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(id),
    FOREIGN KEY (patient_id) REFERENCES Patients(id)
);
CREATE TABLE Diseases (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT
);
CREATE TABLE Diagnoses (
    id INT PRIMARY KEY,
    visit_id INT,
    disease_id INT,
    notes TEXT,
    FOREIGN KEY (visit_id) REFERENCES Visits(id),
    FOREIGN KEY (disease_id) REFERENCES Diseases(id)
);
INSERT INTO Doctors (id, name, specialty) VALUES
(1, 'Dr. Smith', 'Cardiology'),
(2, 'Dr. Johnson', 'Pediatrics');
INSERT INTO Patients (id, name, insurance, birthday) VALUES
(1, 'John Doe', 'BlueCross', '1990-05-15'),
(2, 'Jane Smith', 'Aetna', '1985-09-22');
INSERT INTO Diseases (id, name, description) VALUES
(1, 'Hypertension', 'High blood pressure condition'),
(2, 'Asthma', 'Respiratory condition');
INSERT INTO Visits (id, doctor_id, patient_id, date) VALUES
(1, 1, 1, '2024-01-10'),
(2, 2, 2, '2024-01-12');
INSERT INTO Diagnoses (id, visit_id, disease_id, notes) VALUES
(1, 1, 1, 'Prescribed medication and lifestyle changes'),
(2, 2, 2, 'Prescribed inhaler and monitoring');
