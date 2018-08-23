-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rol` (
  `idRol` INT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idRol`))
ENGINE = ndbcluster;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `cedulaUsuario` INT NOT NULL,
  `nombreUno` VARCHAR(45) NOT NULL,
  `nombreDos` VARCHAR(45) NULL,
  `apellidoUno` VARCHAR(45) NOT NULL,
  `apellidoDos` VARCHAR(45) NULL,
  `mail` VARCHAR(128) NOT NULL,
  `numeroCelular` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `activo` TINYINT NULL,
  `idRol` INT NOT NULL,
  PRIMARY KEY (`cedulaUsuario`),
  UNIQUE INDEX `cedulaUsuario_UNIQUE` (`cedulaUsuario` ASC) VISIBLE,
  INDEX `fk_Usuario_Rol_idx` (`idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Rol`
    FOREIGN KEY (`idRol`)
    REFERENCES `mydb`.`Rol` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TipoBasura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoBasura` (
  `idTipoBasura` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(128) NOT NULL,
  `activo` TINYINT NOT NULL,
  PRIMARY KEY (`idTipoBasura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TipoReporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoReporte` (
  `idTipoReporte` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(128) NOT NULL,
  `activo` TINYINT NOT NULL,
  PRIMARY KEY (`idTipoReporte`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reporte` (
  `idReporte` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(128) NOT NULL,
  `coordenada` POINT NULL,
  `imagenUno` VARCHAR(128) NOT NULL,
  `imagenDos` VARCHAR(128) NULL,
  `cedulaUsuario` INT NOT NULL,
  `idTipoBasura` INT NOT NULL,
  `idTipoReporte` INT NOT NULL,
  PRIMARY KEY (`idReporte`),
  INDEX `fk_Reporte_Usuario1_idx` (`cedulaUsuario` ASC) VISIBLE,
  INDEX `fk_Reporte_TipoBasura1_idx` (`idTipoBasura` ASC) VISIBLE,
  INDEX `fk_Reporte_TipoReporte1_idx` (`idTipoReporte` ASC) VISIBLE,
  CONSTRAINT `fk_Reporte_Usuario1`
    FOREIGN KEY (`cedulaUsuario`)
    REFERENCES `mydb`.`Usuario` (`cedulaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reporte_TipoBasura1`
    FOREIGN KEY (`idTipoBasura`)
    REFERENCES `mydb`.`TipoBasura` (`idTipoBasura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reporte_TipoReporte1`
    FOREIGN KEY (`idTipoReporte`)
    REFERENCES `mydb`.`TipoReporte` (`idTipoReporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Respuesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Respuesta` (
  `idRespuesta` INT NOT NULL,
  `descripcion` VARCHAR(128) NOT NULL,
  `idReporte` INT NOT NULL,
  PRIMARY KEY (`idRespuesta`),
  INDEX `fk_Respuesta_Reporte1_idx` (`idReporte` ASC) VISIBLE,
  CONSTRAINT `fk_Respuesta_Reporte1`
    FOREIGN KEY (`idReporte`)
    REFERENCES `mydb`.`Reporte` (`idReporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
