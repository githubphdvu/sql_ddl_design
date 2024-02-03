
--$psql -d dbname -f filename.sql or $psql < filename.sql or #\i filename.sql
--$psql (^D:quit)
--#\l (all databases,q:quit)
--#\c soccerleague
--soccerleague=#\dt (tables)
--....#\d teams (table structure)
--...#SELECT * FROM teams (all records of table)
DROP DATABASE IF EXISTS soccerleague;
CREATE DATABASE soccerleague;--or --$createdb soccerLeague
\c soccerleague;
CREATE TABLE Teams (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL
);
CREATE TABLE Players (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birthday DATE NOT NULL,
    height DECIMAL(5,2) NOT NULL,
    current_team_id INT,
    FOREIGN KEY (current_team_id) REFERENCES Teams(id)
);
CREATE TABLE Referees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
CREATE TABLE Season (
    id SERIAL PRIMARY KEY,
    start_date DATE,
    end_date DATE
);
CREATE TABLE Matches (
    id SERIAL PRIMARY KEY,
    home_team_id INT NOT NULL,
    away_team_id INT NOT NULL,
    location VARCHAR(255),
    date DATE,
    start_time TIME,
    season_id INT,
    head_referee_id INT,
    assistant_referee_1_id INT,
    assistant_referee_2_id INT,
    FOREIGN KEY (home_team_id) REFERENCES Teams(id),
    FOREIGN KEY (away_team_id) REFERENCES Teams(id),
    FOREIGN KEY (season_id) REFERENCES Season(id),
    FOREIGN KEY (head_referee_id) REFERENCES Referees(id),
    FOREIGN KEY (assistant_referee_1_id) REFERENCES Referees(id),
    FOREIGN KEY (assistant_referee_2_id) REFERENCES Referees(id)
);
CREATE TABLE Goals (
    id SERIAL PRIMARY KEY,
    player_id INT,
    match_id INT,
    FOREIGN KEY (player_id) REFERENCES Players(id),
    FOREIGN KEY (match_id) REFERENCES Matches(id)
);
CREATE TABLE Results (
    id SERIAL PRIMARY KEY,
    team_id INT,
    match_id INT,
    result VARCHAR(50),
    FOREIGN KEY (team_id) REFERENCES Teams(id),
    FOREIGN KEY (match_id) REFERENCES Matches(id)
);
CREATE TABLE Lineups (
    id SERIAL PRIMARY KEY,
    player_id INT,
    match_id INT,
    team_id INT,
    FOREIGN KEY (player_id) REFERENCES Players(id),
    FOREIGN KEY (match_id) REFERENCES Matches(id),
    FOREIGN KEY (team_id) REFERENCES Teams(id)
);
INSERT INTO Teams (name, city) VALUES
('Team A', 'City X'),
('Team B', 'City Y'),
('Team C', 'City Z');
INSERT INTO Players (name, birthday, height, current_team_id) VALUES
('Player 1', '1990-01-01', 180.5, 1),
('Player 2', '1992-03-15', 175.0, 2),
('Player 3', '1988-07-20', 185.2, 1);
INSERT INTO Referees (name) VALUES
('Referee 1'),
('Referee 2'),
('Referee 3');
INSERT INTO Season (start_date, end_date) VALUES
('2024-01-01', '2024-12-31');
INSERT INTO Matches (home_team_id, away_team_id, location, date, start_time, season_id, head_referee_id, assistant_referee_1_id, assistant_referee_2_id) VALUES
(1, 2, 'Stadium 1', '2024-01-10', '14:00:00', 1, 1, 2, 3),
(2, 3, 'Stadium 2', '2024-01-15', '16:00:00', 1, 2, 3, 1),
(3, 1, 'Stadium 3', '2024-01-20', '18:00:00', 1, 3, 1, 2);
INSERT INTO Goals (player_id, match_id) VALUES
(1, 1),
(2, 1),
(1, 2);
INSERT INTO Results (team_id, match_id, result) VALUES
(1, 1, 'Win'),
(2, 1, 'Lost'),
(2, 2, 'Draw');
INSERT INTO Lineups (player_id, match_id, team_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 2);
