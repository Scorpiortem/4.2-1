USE `СOVID-19`;
START TRANSACTION;
    CREATE TEMPORARY TABLE temp_table (
	    SNo INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
        ObservationDate DATE NOT NULL,
        Province_State VARCHAR(50),
        Country_Region VARCHAR(50) NOT NULL,
        LastUpdate TIMESTAMP NOT NULL,
        Confirmed INTEGER,
        Deaths INTEGER,
        Recovered INTEGER
	);
    LOAD DATA INFILE 'Scorpiortem/4.2-1/COVID-19_data.csv'
	INTO TABLE temp_table
    FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (SNo, @Observationdate, Province_State, Country_Region, @LastUpdate, Confirmed, Deaths, Recovered)
    SET observationdate = STR_TO_DATE(@observationdate, '%d.%m.%y'),
    lastupdate = STR_TO_DATE(@lastupdate, '%d.%m.%y %H:%i');
    
    INSERT INTO regions (province)
    SELECT DISTINCT Province_State FROM temp_table;
    
    INSERT INTO countries  (country)
    SELECT DISTINCT Country_Region FROM temp_table;
      
	INSERT INTO observations 
      (SELECT temp.SNo, temp.ObservationDate, reg.ID, coun.ID, temp.LastUpdate, temp.Confirmed, temp.Deaths, temp.Recovered
       FROM temp_table temp, regions reg, countries coun 
       WHERE temp.Province_State = reg.province AND temp.Country_Region = coun.country);
      
COMMIT;
