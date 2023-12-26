-- MySQL Script generated by MySQL Workbench
-- Tue Dec 26 14:02:30 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema COVID-19
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema COVID-19
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `COVID-19` DEFAULT CHARACTER SET utf8 ;
USE `COVID-19` ;

-- -----------------------------------------------------
-- Table `COVID-19`.`regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COVID-19`.`regions` (
  `ID` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `province` VARCHAR(60) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `COVID-19`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COVID-19`.`countries` (
  `ID` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(60) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `COVID-19`.`observations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COVID-19`.`observations` (
  `serialnumber` INT UNSIGNED NOT NULL,
  `observationDate` DATE NOT NULL,
  `regionID` SMALLINT UNSIGNED NOT NULL,
  `countryID` SMALLINT UNSIGNED NOT NULL,
  `lastUpdate` TIMESTAMP NOT NULL,
  `confirmed` MEDIUMINT UNSIGNED NULL,
  `deaths` SMALLINT UNSIGNED NULL,
  `recovered` MEDIUMINT UNSIGNED NULL,
  PRIMARY KEY (`serialnumber`),
  CONSTRAINT `regionID`
    FOREIGN KEY (`regionID`)
    REFERENCES `COVID-19`.`regions` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `countryID`
    FOREIGN KEY (`countryID`)
    REFERENCES `COVID-19`.`countries` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
