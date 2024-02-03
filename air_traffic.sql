-- from the terminal run:
-- psql < air_traffic.sql

--not-good schema
-- DROP DATABASE IF EXISTS air_traffic;
-- CREATE DATABASE air_traffic;
-- \c air_traffic
-- CREATE TABLE tickets
-- ( id SERIAL PRIMARY KEY,
--   first_name TEXT NOT NULL,
--   last_name TEXT NOT NULL,
--   seat TEXT NOT NULL,
--   departure TIMESTAMP NOT NULL,
--   arrival TIMESTAMP NOT NULL,
--   airline TEXT NOT NULL,
--   from_city TEXT NOT NULL,
--   from_country TEXT NOT NULL,
--   to_city TEXT NOT NULL,
--   to_country TEXT NOT NULL
-- );
-- INSERT INTO tickets (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
-- VALUES
--   ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
--   ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
--   ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
--   ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
--   ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
--   ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
--   ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
--   ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
--   ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
--   ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');

--improved schema: separate tables for passengers, airlines, and locations, allowing for better data organization and normalization. 
--The tickets table references these new tables using foreign key constraints.
DROP DATABASE IF EXISTS air_traffic;
CREATE DATABASE air_traffic;
\c air_traffic;
CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    passenger_id INT NOT NULL,
    seat TEXT NOT NULL,
    departure TIMESTAMP NOT NULL,
    arrival TIMESTAMP NOT NULL,
    airline_id INT NOT NULL,
    from_location_id INT NOT NULL,
    to_location_id INT NOT NULL
);
CREATE TABLE passengers (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);
CREATE TABLE airlines (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);
CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    city TEXT NOT NULL,
    country TEXT NOT NULL
);
INSERT INTO passengers (first_name, last_name)
VALUES
    ('Jennifer', 'Finch'),
    ('Thadeus', 'Gathercoal'),
    ('Sonja', 'Pauley'),
    ('Waneta', 'Skeleton'),
    ('Berkie', 'Wycliff'),
    ('Alvin', 'Leathes'),
    ('Cory', 'Squibbes');

INSERT INTO airlines (name)
VALUES
    ('United'),
    ('British Airways'),
    ('Delta'),
    ('TUI Fly Belgium'),
    ('Air China'),
    ('American Airlines'),
    ('Avianca Brasil');
INSERT INTO locations (city, country)
VALUES
    ('Washington DC', 'United States'),
    ('Tokyo', 'Japan'),
    ('Los Angeles', 'United States'),
    ('Seattle', 'United States'),
    ('Paris', 'France'),
    ('Dubai', 'UAE'),
    ('New York', 'United States'),
    ('Cedar Rapids', 'United States'),
    ('Charlotte', 'United States'),
    ('Sao Paolo', 'Brazil'),
    ('Chicago', 'United States'),
    ('New Orleans', 'United States'),
    ('Santiago', 'Chile');
INSERT INTO tickets (passenger_id, seat, departure, arrival, airline_id, from_location_id, to_location_id)
VALUES
    (1, '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 1, 4),
    (2, '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 2, 2, 11),
    (3, '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 3, 3, 9),
    (1, '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 3, 4, 8),
    (4, '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 4, 5, 10),
    (2, '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 5, 6, 12),
    (5, '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 1, 7, 9),
    (6, '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 6, 8, 11),
    (5, '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 6, 9, 13),
    (7, '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 7, 10, 14);
