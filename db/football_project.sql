CREATE DATABASE IF NOT EXISTS football_scores;

DROP TABLE IF EXISTS fixtures;

CREATE TABLE fixtures (
  id SERIAL8 PRIMARY KEY,
  fixture_date DATE,
  home_team VARCHAR(255),
  away_team VARCHAR(255),
  home_team_goals INT4,
  away_team_goals INT4
);
