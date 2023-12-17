CREATE DATABASE IF NOT EXISTS `diagnosis`; 
USE `diagnosis`;
CREATE TABLE IF NOT EXISTS `Geographical_data` (
    serialnumber INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    observationdate TIMESTAMP NOT NULL,
    province VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    lastupdate TIMESTAMP NOT NULL
);
CREATE TABLE IF NOT EXISTS disease_data (
	serialnumber INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date TIMESTAMP NOT NULL,
    FOREIGN KEY(date) REFERENCES Geografical_data(lastupdate) ON DELETE CASCADE,
    confirmed INTEGER,
    deaths INTEGER,
    recovered INTEGER
);
