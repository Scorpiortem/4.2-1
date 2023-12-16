USE diagnosis;

START TRANSACTION;

    CREATE TEMPORARY TABLE temp_table (
	    SNo INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
        ObservationDate TIMESTAMP NOT NULL,
        Province_State VARCHAR(50),
        Country_Region VARCHAR(50) NOT NULL,
        LastUpdate TIMESTAMP NOT NULL,
        Confirmed INTEGER,
        Deaths INTEGER,
        Recovered INTEGER
	);
    LOAD DATA INFILE 'Scorpiortem/4.2-1/covid_19_data.csv'
	INTO TABLE temp_table
    FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (SNo, @Observationdate, Province_State, Country_Region, @LastUpdate, Confirmed, Deaths, Recovered)
    SET observationdate = STR_TO_DATE(@observationdate, '%m/%d/%Y'),
    lastupdate = STR_TO_DATE(@lastupdate, '%c/%d/%Y %H:%i:%s');
    
    INSERT INTO Geographical_data (serialnumber, observationdate, province, country, lastupdate)
    SELECT SNo, Observationdate, Province_State, Country_Region, LastUpdate FROM temp_table;
    
    INSERT INTO disease_data (serialnumber, date, confirmed, deaths, recovered)
    SELECT SNo, LastUpdate, Confirmed, Deaths, Recovered FROM temp_table;
    
COMMIT;
