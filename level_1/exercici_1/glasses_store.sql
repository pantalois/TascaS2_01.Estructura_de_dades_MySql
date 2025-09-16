-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cul_de_ampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cul_de_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cul_de_ampolla` DEFAULT CHARACTER SET utf8 ;
USE `cul_de_ampolla` ;

-- -----------------------------------------------------
-- Table `cul_de_ampolla`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_de_ampolla`.`address` (
  `Id_address` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `apartment` VARCHAR(45) NULL,
  `door` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `client_id_client` INT NOT NULL,
  `store_id_store` INT NOT NULL,
  PRIMARY KEY (`Id_address`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_de_ampolla`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_de_ampolla`.`supplier` (
  `id_supplier` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `fax` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `address_Id_address` INT NOT NULL,
  PRIMARY KEY (`id_supplier`),
  INDEX `fk_supplier_address1_idx` (`address_Id_address` ASC) VISIBLE,
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_address1`
    FOREIGN KEY (`address_Id_address`)
    REFERENCES `cul_de_ampolla`.`address` (`Id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_de_ampolla`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_de_ampolla`.`brand` (
  `id_brand` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `Supplier_id_supplier` INT NOT NULL,
  PRIMARY KEY (`id_brand`),
  INDEX `fk_brand_Supplier1_idx` (`Supplier_id_supplier` ASC) VISIBLE,
  CONSTRAINT `fk_brand_Supplier1`
    FOREIGN KEY (`Supplier_id_supplier`)
    REFERENCES `cul_de_ampolla`.`supplier` (`id_supplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_de_ampolla`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_de_ampolla`.`glasses` (
  `id_glasses` INT NOT NULL AUTO_INCREMENT,
  `right_glass_prescription` DECIMAL(4,2) NOT NULL,
  `left_glass_prescription` DECIMAL(4,2) NOT NULL,
  `frame_type` ENUM('plastic', 'paste', 'metallic') NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `color_right_glass` VARCHAR(45) NOT NULL,
  `color_left_glass` VARCHAR(45) NOT NULL,
  `price` DECIMAL(8,2) NOT NULL,
  `brand_id_brand` INT NOT NULL,
  PRIMARY KEY (`id_glasses`),
  INDEX `fk_glasses_brand1_idx` (`brand_id_brand` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_brand1`
    FOREIGN KEY (`brand_id_brand`)
    REFERENCES `cul_de_ampolla`.`brand` (`id_brand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_de_ampolla`.`seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_de_ampolla`.`seller` (
  `id_seller` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_seller`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_de_ampolla`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_de_ampolla`.`client` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `register_date` DATETIME NOT NULL,
  `address_Id_address` INT NOT NULL,
  `recommended_by_client_id` INT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `fk_Client_Client1_idx` (`recommended_by_client_id` ASC) VISIBLE,
  INDEX `fk_client_address1_idx` (`address_Id_address` ASC) VISIBLE,
  CONSTRAINT `fk_Client_Client1`
    FOREIGN KEY (`recommended_by_client_id`)
    REFERENCES `cul_de_ampolla`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_address1`
    FOREIGN KEY (`address_Id_address`)
    REFERENCES `cul_de_ampolla`.`address` (`Id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_de_ampolla`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_de_ampolla`.`sale` (
  `id_sale` INT NOT NULL AUTO_INCREMENT,
  `Glasses_id_glasses` INT NOT NULL,
  `Seller_id_seller` INT NOT NULL,
  `Client_id_client` INT NOT NULL,
  `sale_date` DATETIME NOT NULL,
  PRIMARY KEY (`id_sale`),
  INDEX `fk_Sale_Glasses1_idx` (`Glasses_id_glasses` ASC) VISIBLE,
  INDEX `fk_Sale_Seller1_idx` (`Seller_id_seller` ASC) VISIBLE,
  INDEX `fk_Sale_Client1_idx` (`Client_id_client` ASC) VISIBLE,
  CONSTRAINT `fk_Sale_Glasses1`
    FOREIGN KEY (`Glasses_id_glasses`)
    REFERENCES `cul_de_ampolla`.`glasses` (`id_glasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_Seller1`
    FOREIGN KEY (`Seller_id_seller`)
    REFERENCES `cul_de_ampolla`.`seller` (`id_seller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_Client1`
    FOREIGN KEY (`Client_id_client`)
    REFERENCES `cul_de_ampolla`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
