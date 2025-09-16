-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`county`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`county` (
  `id_county` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_county`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`town`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`town` (
  `id_town` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `county_id_county` INT NOT NULL,
  PRIMARY KEY (`id_town`),
  INDEX `fk_town_county1_idx` (`county_id_county` ASC) VISIBLE,
  CONSTRAINT `fk_town_county1`
    FOREIGN KEY (`county_id_county`)
    REFERENCES `pizzeria`.`county` (`id_county`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`client` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `surname` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `town_id_town` INT NOT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `fk_client_town1_idx` (`town_id_town` ASC) VISIBLE,
  CONSTRAINT `fk_client_town1`
    FOREIGN KEY (`town_id_town`)
    REFERENCES `pizzeria`.`town` (`id_town`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`store` (
  `id_store` INT NOT NULL,
  `address_id_address` INT NOT NULL,
  `town_id_town` INT NOT NULL,
  PRIMARY KEY (`id_store`),
  INDEX `fk_store_town1_idx` (`town_id_town` ASC) VISIBLE,
  CONSTRAINT `fk_store_town1`
    FOREIGN KEY (`town_id_town`)
    REFERENCES `pizzeria`.`town` (`id_town`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`worker` (
  `id_worker` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `surname` VARCHAR(45) NULL,
  `nif` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `cook_or_delivery` TINYINT NULL,
  `delivery_date_hour` DATETIME NULL,
  `store_id_store` INT NOT NULL,
  PRIMARY KEY (`id_worker`),
  INDEX `fk_worker_store1_idx` (`store_id_store` ASC) VISIBLE,
  CONSTRAINT `fk_worker_store1`
    FOREIGN KEY (`store_id_store`)
    REFERENCES `pizzeria`.`store` (`id_store`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`order` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `takeaway_or_pickup` TINYINT NULL,
  `total_amount` INT NULL,
  `price` DECIMAL(8,2) NULL,
  `client_id_client` INT NOT NULL,
  `worker_id_worker` INT NOT NULL,
  `store_id_store` INT NOT NULL,
  PRIMARY KEY (`id_order`),
  INDEX `fk_order_client1_idx` (`client_id_client` ASC) VISIBLE,
  INDEX `fk_order_worker1_idx` (`worker_id_worker` ASC) VISIBLE,
  INDEX `fk_order_store1_idx` (`store_id_store` ASC) VISIBLE,
  CONSTRAINT `fk_order_client1`
    FOREIGN KEY (`client_id_client`)
    REFERENCES `pizzeria`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_worker1`
    FOREIGN KEY (`worker_id_worker`)
    REFERENCES `pizzeria`.`worker` (`id_worker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_store1`
    FOREIGN KEY (`store_id_store`)
    REFERENCES `pizzeria`.`store` (`id_store`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`category` (
  `id_category` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_category`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`product` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `name` ENUM('pizza', 'burguer', 'drink') NULL,
  `description` VARCHAR(45) NULL,
  `image` BLOB NULL,
  `price` INT NULL,
  `order_id_order` INT NOT NULL,
  PRIMARY KEY (`id_product`),
  INDEX `fk_product_order1_idx` (`order_id_order` ASC) VISIBLE,
  CONSTRAINT `fk_product_order1`
    FOREIGN KEY (`order_id_order`)
    REFERENCES `pizzeria`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_category` (
  `id_pizza_category` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `product_id_product` INT NOT NULL,
  `category_id_category` INT NOT NULL,
  PRIMARY KEY (`id_pizza_category`),
  INDEX `fk_pizza_category_product1_idx` (`product_id_product` ASC) VISIBLE,
  INDEX `fk_pizza_category_category1_idx` (`category_id_category` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_category_product1`
    FOREIGN KEY (`product_id_product`)
    REFERENCES `pizzeria`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_category_category1`
    FOREIGN KEY (`category_id_category`)
    REFERENCES `pizzeria`.`category` (`id_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
