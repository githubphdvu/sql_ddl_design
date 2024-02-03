
--$psql -d dbname -f filename.sql or $psql < filename.sql or #\i filename.sql
--$psql (^D:quit)
--#\l (all databases, q:quit)
--#\c craigslist (can run \i filename.sql)
--craigslist=#\dt (tables)
--craigslist=#\d regions (table structure)
--craigslist=#SELECT * FROM regions; (all records in table regions)
DROP DATABASE IF EXISTS craigslist;
CREATE DATABASE craigslist;--or $createdb craigslist
\c craigslist;
CREATE TABLE Regions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE Categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    encrypted_password VARCHAR(255) NOT NULL,
    preferred_region_id INT REFERENCES Regions(id)
);

CREATE TABLE Posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    text TEXT,
    location VARCHAR(255),
    user_id INT REFERENCES Users(id),
    region_id INT REFERENCES Regions(id),
    category_id INT REFERENCES Categories(id)
);

INSERT INTO Regions (name) VALUES
('Atlanta'),
('Seattle');
INSERT INTO Categories (name) VALUES
('Furniture'),
('Jobs');
INSERT INTO Users (username, encrypted_password, preferred_region_id) VALUES
('user1', 'password1', 1),
('user2', 'password2', 2);
INSERT INTO Posts (title, text, location, user_id, region_id, category_id) VALUES
('Sofa for Sale', 'Good condition, only used for 6 months', '123 Main St', 1, 1, 1),
('Job Opportunity', 'Software engineer position available', '456 Oak St', 2, 2, 3);
