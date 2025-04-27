DROP DATABASE IF EXISTS `coffee_shop`;
CREATE DATABASE `coffee_shop`;
USE `coffee_shop`;

-- Stores table
CREATE TABLE `stores` (
`store_id` INT NOT NULL AUTO_INCREMENT,
`store_name` VARCHAR(50) NOT NULL,
PRIMARY KEY (`store_id`)
) ENGINE=InnoDB; -- support foreign keys and transactions in MySQL

-- Product category table
CREATE TABLE `product_category` (
`product_category_id` INT NOT NULL AUTO_INCREMENT,
`product_category` VARCHAR (50) NOT NULL,
PRIMARY KEY (`product_category_id`),
UNIQUE (`product_category`)
) ENGINE=InnoDB;

-- Products table
CREATE TABLE `products` (
`product_id` INT NOT NULL AUTO_INCREMENT,
`product_name` VARCHAR(100) NOT NULL,
`unit_price` DECIMAL(10,2) NOT NULL CHECK (`unit_price` >= 0),
`product_category_id` INT NOT NULL,
`description` VARCHAR(255),
PRIMARY KEY (`product_id`),
FOREIGN KEY (`product_category_id`) REFERENCES `product_category`(`product_category_id`) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Transactions table
CREATE TABLE `transactions` (
`transaction_id` INT NOT NULL AUTO_INCREMENT,
`transaction_datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,  
`transaction_qty` INT NOT NULL CHECK (`transaction_qty` > 0), 
`store_id` INT NOT NULL,
`product_id` INT NOT NULL,
PRIMARY KEY (`transaction_id`),
FOREIGN KEY (`store_id`) REFERENCES `stores`(`store_id`) ON DELETE RESTRICT,
FOREIGN KEY (`product_id`) REFERENCES `products`(`product_id`) ON DELETE RESTRICT
) ENGINE=InnoDB;

