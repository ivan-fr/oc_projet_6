-- MySQL Script generated by MySQL Workbench
-- Fri Jan 18 09:51:35 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Role` (
  `idRole` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idRole`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Adresse` (
  `idAdresse` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codepostal` VARCHAR(5) NOT NULL,
  `rue` VARCHAR(200) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idAdresse`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Utilisateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Utilisateur` (
  `idUtilisateur` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `prenom` VARCHAR(100) NOT NULL,
  `mail` VARCHAR(100) NOT NULL,
  `Role_id` INT UNSIGNED NOT NULL,
  `mot_de_passe` VARCHAR(45) NOT NULL,
  `Adresse_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idUtilisateur`),
  INDEX `fk_Client_Role1_idx` (`Role_id` ASC),
  INDEX `fk_Utilisateur_Adresse1_idx` (`Adresse_id` ASC),
  UNIQUE INDEX `Adresse_id_UNIQUE` (`Adresse_id` ASC),
  CONSTRAINT `fk_Client_Role1`
    FOREIGN KEY (`Role_id`)
    REFERENCES `pizzeria`.`Role` (`idRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utilisateur_Adresse1`
    FOREIGN KEY (`Adresse_id`)
    REFERENCES `pizzeria`.`Adresse` (`idAdresse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Categorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Categorie` (
  `idCategorie` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `texte` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategorie`),
  UNIQUE INDEX `texte_UNIQUE` (`texte` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Produit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Produit` (
  `idProduit` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `prix_unitaire` DECIMAL(10,2) NOT NULL,
  `Categorie_id` INT UNSIGNED NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`idProduit`),
  INDEX `fk_Produit_Categorie1_idx` (`Categorie_id` ASC),
  CONSTRAINT `fk_Produit_Categorie1`
    FOREIGN KEY (`Categorie_id`)
    REFERENCES `pizzeria`.`Categorie` (`idCategorie`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Menu` (
  `idMenu` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `prix_unitaire` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idMenu`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Pizzeria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Pizzeria` (
  `idPizzeria` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(200) NOT NULL,
  `Adresse_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idPizzeria`),
  INDEX `fk_Pizzeria_Adresse1_idx` (`Adresse_id` ASC),
  UNIQUE INDEX `Adresse_id_UNIQUE` (`Adresse_id` ASC),
  CONSTRAINT `fk_Pizzeria_Adresse1`
    FOREIGN KEY (`Adresse_id`)
    REFERENCES `pizzeria`.`Adresse` (`idAdresse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Commande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Commande` (
  `idCommande` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Utilisateur_id` INT UNSIGNED NOT NULL,
  `date` DATETIME NOT NULL,
  `statut` VARCHAR(150) NOT NULL,
  `mode_de_paiement` VARCHAR(150) NOT NULL,
  `Pizzeria_id` INT NOT NULL,
  PRIMARY KEY (`idCommande`),
  INDEX `fk_Commande_Client1_idx` (`Utilisateur_id` ASC),
  INDEX `fk_Commande_Pizzeria1_idx` (`Pizzeria_id` ASC),
  CONSTRAINT `fk_Commande_Client1`
    FOREIGN KEY (`Utilisateur_id`)
    REFERENCES `pizzeria`.`Utilisateur` (`idUtilisateur`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commande_Pizzeria1`
    FOREIGN KEY (`Pizzeria_id`)
    REFERENCES `pizzeria`.`Pizzeria` (`idPizzeria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Commande_Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Commande_Menu` (
  `idCommandeMenu` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Menu_id` INT UNSIGNED NOT NULL,
  `Commande_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idCommandeMenu`),
  INDEX `fk_Commande_Menu_Menu_idx` (`Menu_id` ASC),
  INDEX `fk_Commande_Menu_Commande_idx` (`Commande_id` ASC),
  CONSTRAINT `fk_Commande_Menu_Menu`
    FOREIGN KEY (`Menu_id`)
    REFERENCES `pizzeria`.`Menu` (`idMenu`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commande_Menu_Commande`
    FOREIGN KEY (`Commande_id`)
    REFERENCES `pizzeria`.`Commande` (`idCommande`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Ingredient` (
  `idIngredient` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `texte` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idIngredient`),
  UNIQUE INDEX `texte_UNIQUE` (`texte` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Pizzeria_Ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Pizzeria_Ingredient` (
  `Pizzeria_id` INT NOT NULL,
  `Ingredient_id` INT UNSIGNED NOT NULL,
  `stock` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`Pizzeria_id`, `Ingredient_id`),
  INDEX `fk_Pizzeria_Ingredient_Ingredient1_idx` (`Ingredient_id` ASC),
  INDEX `fk_Pizzeria_Ingredient_Pizzeria1_idx` (`Pizzeria_id` ASC),
  CONSTRAINT `fk_Pizzeria_Ingredient_Pizzeria1`
    FOREIGN KEY (`Pizzeria_id`)
    REFERENCES `pizzeria`.`Pizzeria` (`idPizzeria`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizzeria_Ingredient_Ingredient1`
    FOREIGN KEY (`Ingredient_id`)
    REFERENCES `pizzeria`.`Ingredient` (`idIngredient`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Ingredient_Produit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Ingredient_Produit` (
  `Ingredient_id` INT UNSIGNED NOT NULL,
  `Produit_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Ingredient_id`, `Produit_id`),
  INDEX `fk_Ingredient_Produit_Produit1_idx` (`Produit_id` ASC),
  INDEX `fk_Ingredient_Produit_Ingredient1_idx` (`Ingredient_id` ASC),
  CONSTRAINT `fk_Ingredient_Produit_Ingredient1`
    FOREIGN KEY (`Ingredient_id`)
    REFERENCES `pizzeria`.`Ingredient` (`idIngredient`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ingredient_Produit_Produit1`
    FOREIGN KEY (`Produit_id`)
    REFERENCES `pizzeria`.`Produit` (`idProduit`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Commande_Menu_Produit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Commande_Menu_Produit` (
  `Produit_id` INT UNSIGNED NOT NULL,
  `Commande_Menu_id` INT UNSIGNED NOT NULL,
  `quantité` SMALLINT(2) UNSIGNED NULL,
  PRIMARY KEY (`Produit_id`, `Commande_Menu_id`),
  INDEX `fk_Commande_Menu_Produit_Commande_Menu_idx` (`Commande_Menu_id` ASC),
  INDEX `fk_Commande_Menu_Produit_Produit_idx` (`Produit_id` ASC),
  CONSTRAINT `fk_Commande_Menu_Produit_Produit`
    FOREIGN KEY (`Produit_id`)
    REFERENCES `pizzeria`.`Produit` (`idProduit`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commande_Menu_Produit_Commande_Menu`
    FOREIGN KEY (`Commande_Menu_id`)
    REFERENCES `pizzeria`.`Commande_Menu` (`idCommandeMenu`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Categorie_Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Categorie_Menu` (
  `Categorie_id` INT UNSIGNED NOT NULL,
  `Menu_id` INT UNSIGNED NOT NULL,
  `quantité` SMALLINT(2) UNSIGNED NULL,
  PRIMARY KEY (`Categorie_id`, `Menu_id`),
  INDEX `fk_Categorie_Menu_Menu1_idx` (`Menu_id` ASC),
  INDEX `fk_Categorie_Menu_Categorie1_idx` (`Categorie_id` ASC),
  CONSTRAINT `fk_Categorie_Menu_Categorie1`
    FOREIGN KEY (`Categorie_id`)
    REFERENCES `pizzeria`.`Categorie` (`idCategorie`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Categorie_Menu_Menu1`
    FOREIGN KEY (`Menu_id`)
    REFERENCES `pizzeria`.`Menu` (`idMenu`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Produit_Commande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Produit_Commande` (
  `Produit_id` INT UNSIGNED NOT NULL,
  `Commande_id` INT UNSIGNED NOT NULL,
  `quantité` SMALLINT(2) UNSIGNED NULL,
  PRIMARY KEY (`Produit_id`, `Commande_id`),
  INDEX `fk_Produit_Commande_Commande1_idx` (`Commande_id` ASC),
  INDEX `fk_Produit_Commande_Produit1_idx` (`Produit_id` ASC),
  CONSTRAINT `fk_Produit_Commande_Produit1`
    FOREIGN KEY (`Produit_id`)
    REFERENCES `pizzeria`.`Produit` (`idProduit`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produit_Commande_Commande1`
    FOREIGN KEY (`Commande_id`)
    REFERENCES `pizzeria`.`Commande` (`idCommande`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
