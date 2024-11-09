CREATE database Premeier_League_23_24_Database;
USE Premeier_League_23_24_Database;

CREATE TABLE player_goals_per_90 (
    `Rank` INT,
    Player VARCHAR(50),
    Team VARCHAR(50),
    Goals_per_90 DECIMAL(4, 2),
    Total_Goals INT,
    Minutes INT,
    Matches INT,
    Country CHAR(3)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/player_goals_per_90.csv"
INTO TABLE player_goals_per_90
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS                   -- Skips the header row
(`Rank`, Player, Team, Goals_per_90, Total_Goals, Minutes, Matches, Country);


CREATE TABLE player_expected_goals (
    `rank` INT,
    player VARCHAR(50),
    team VARCHAR(50),
    expected_goals_xg DECIMAL(4, 1),
    actual_goals INT,
    minutes INT,
    matches INT,
    country VARCHAR(3)
);


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/player_expected_goals.csv"
INTO TABLE player_expected_goals
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS                   -- Skips the header row
(`Rank`, Player,Team, expected_goals_xg,actual_goals, Minutes, Matches, Country);

CREATE TABLE player_top_scorers (
    `Rank` INT,
    Player VARCHAR(50),
    Team VARCHAR(50),
    Goals INT,
    Penalties INT,
    Minutes INT,
    Matches INT,
    Country VARCHAR(3)
);


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Goal Scoring & Attacking Efficiency/player_top_scorers.csv"
INTO TABLE player_top_scorers
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                   -- Skips the header row

CREATE TABLE player_big_chances_created (
    `Rank` INT,
    Player VARCHAR(50),
    Team VARCHAR(50),
    Big_Chances_Created INT,
    Total_Assists INT,
    Minutes INT,
    Matches INT,
    Country VARCHAR(3)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Goal Scoring & Attacking Efficiency/player_big_chances_created.csv"
INTO TABLE player_big_chances_created
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                   -- Skips the header row

CREATE TABLE player_big_chances_missed (
    `Rank` INT,
    Player VARCHAR(50),
    Team VARCHAR(50),
    Big_Chances_Missed DECIMAL(5, 1),
    Shot_Conversion_Rate DECIMAL(4, 1),
    Minutes INT,
    Matches INT,
    Country VARCHAR(3)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Goal Scoring & Attacking Efficiency/player_big_chances_missed.csv"
INTO TABLE player_big_chances_missed
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                   -- Skips the header row

CREATE TABLE player_expected_goals_on_target (
    `Rank` INT,
    Player VARCHAR(50),
    Team VARCHAR(50),
    Expected_Goals_on_Target DECIMAL(5, 1),
    Actual_Goals DECIMAL(5, 1),
    Minutes INT,
    Matches INT,
    Country VARCHAR(3)
);


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Goal Scoring & Attacking Efficiency/player_expected_goals_on_target.csv"
INTO TABLE player_expected_goals_on_target
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                   -- Skips the header row

CREATE TABLE player_expected_goals_per_90 (
    `Rank` INT,
    Player VARCHAR(50),
    Team VARCHAR(50),
    Expected_Goals_per_90 DECIMAL(4, 2),
    Goals_per_90 DECIMAL(4, 2),
    Minutes INT,
    Matches INT,
    Country VARCHAR(3)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Goal Scoring & Attacking Efficiency/player_expected_goals_per_90.csv"
INTO TABLE player_expected_goals_per_90
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                   -- Skips the header row

CREATE TABLE player_on_target_scoring_attempts (
    `Rank` INT,
    Player VARCHAR(50),
    Team VARCHAR(50),
    Shots_on_Target_per_90 DECIMAL(4, 1),
    Shot_Accuracy DECIMAL(5, 1),
    Minutes INT,
    Matches INT,
    Country VARCHAR(3)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Goal Scoring & Attacking Efficiency/player_on_target_scoring_attempts.csv"
INTO TABLE player_on_target_scoring_attempts
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                   -- Skips the header row

CREATE TABLE player_total_scoring_attempts (
    `Rank` INT,
    Player VARCHAR(50),
    Team VARCHAR(50),
    Shots_per_90 DECIMAL(4, 1),
    Shot_Conversion_Rate DECIMAL(5, 1),
    Minutes INT,
    Matches INT,
    Country VARCHAR(3)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Goal Scoring & Attacking Efficiency/player_total_scoring_attempts.csv"
INTO TABLE player_total_scoring_attempts
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                   -- Skips the header row

CREATE TABLE player_top_assists (
    `Rank` INT,
    Player VARCHAR(50),
    Team VARCHAR(50),
    Assists INT,
    Secondary_Assists DECIMAL(5, 1),
    Minutes INT,
    Matches INT,
    Country VARCHAR(3)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Goal Scoring & Attacking Efficiency/player_top_assists.csv"
INTO TABLE player_top_assists
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                   -- Skips the header row

CREATE TABLE player_contests_won (
    `Rank` INT,
    Player VARCHAR(50),
    Team VARCHAR(50),
    Successful_Dribbles_per_90 DECIMAL(4, 1),
    Dribble_Success_Rate DECIMAL(5, 1),
    Minutes INT,
    Matches INT,
    Country VARCHAR(3)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Goal Scoring & Attacking Efficiency/player_contests_won.csv"
INTO TABLE player_contests_won
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                   -- Skips the header row

CREATE TABLE player_possessions_won_attacking_third (
    `Rank` INT,
    Player VARCHAR(50),
    Team VARCHAR(50),
    Possessions_Won_in_Final_3rd_per_90 DECIMAL(4, 1),
    Possessions_Won_Midfield_per_90 DECIMAL(4, 1),
    Minutes INT,
    Matches INT,
    Country VARCHAR(3)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Goal Scoring & Attacking Efficiency/player_possessions_won_attacking_third.csv"
INTO TABLE player_possessions_won_attacking_third
FIELDS TERMINATED BY ','        -- Specifies comma-separated columns
ENCLOSED BY '"'                 -- Optional, if values are enclosed in double quotes
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                   -- Skips the header row
