CREATE SCHEMA IF NOT EXISTS pizzeria DEFAULT CHARACTER SET utf8mb4;
USE pizzeria;

-- Pueblos / ciudades
CREATE TABLE town (
  id_town INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45),
  county VARCHAR(45)
) ENGINE=InnoDB;

-- Clientes
CREATE TABLE client (
  id_client INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45),
  surname VARCHAR(45),
  address VARCHAR(45),
  postal_code VARCHAR(45),
  phone VARCHAR(45),
  email VARCHAR(45),
  town_id_town INT NOT NULL,
  INDEX fk_client_town1_idx (town_id_town),
  CONSTRAINT fk_client_town1
    FOREIGN KEY (town_id_town)
    REFERENCES town (id_town)
) ENGINE=InnoDB;

-- Tiendas / locales físicos
CREATE TABLE store (
  id_store INT AUTO_INCREMENT PRIMARY KEY,
  address_id_address INT NOT NULL,
  town_id_town INT NOT NULL,
  INDEX fk_store_town1_idx (town_id_town),
  CONSTRAINT fk_store_town1
    FOREIGN KEY (town_id_town)
    REFERENCES town (id_town)
) ENGINE=InnoDB;

-- Trabajadores (cocinero / repartidor)
CREATE TABLE worker (
  id_worker INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45),
  surname VARCHAR(45),
  nif VARCHAR(45),
  phone VARCHAR(45),
  cook_or_delivery ENUM('cook', 'delivery'),
  store_id_store INT NOT NULL,
  INDEX fk_worker_store1_idx (store_id_store),
  CONSTRAINT fk_worker_store1
    FOREIGN KEY (store_id_store)
    REFERENCES store (id_store)
) ENGINE=InnoDB;

-- Direcciones (ojo: en tu modelo esto apunta tanto a client como a store con IDs,
-- pero NO tienes foreign keys aquí, así que lo dejo tal cual)
CREATE TABLE address (
  Id_address INT AUTO_INCREMENT PRIMARY KEY,
  street VARCHAR(45) NOT NULL,
  number VARCHAR(45) NOT NULL,
  apartment VARCHAR(45),
  door VARCHAR(45),
  city VARCHAR(45) NOT NULL,
  postal_code VARCHAR(45) NOT NULL,
  country VARCHAR(45) NOT NULL,
  client_id_client INT NOT NULL,
  store_id_store INT NOT NULL
) ENGINE=InnoDB;

-- Productos vendibles
CREATE TABLE product (
  id_product INT AUTO_INCREMENT PRIMARY KEY,
  name ENUM('pizza', 'burguer', 'drink'),
  description VARCHAR(45),
  image BLOB,
  price INT
) ENGINE=InnoDB;

-- Categorías (vegana, picante, sin gluten, etc.)
CREATE TABLE category (
  id_category INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45)
) ENGINE=InnoDB;

-- Relación producto <-> categoría (muchos a muchos)
CREATE TABLE pizza_category (
  id_pizza_category INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(45) NOT NULL,
  product_id_product INT NOT NULL,
  category_id_category INT NOT NULL,
  INDEX fk_pizza_category_product1_idx (product_id_product),
  INDEX fk_pizza_category_category1_idx (category_id_category),
  CONSTRAINT fk_pizza_category_product1
    FOREIGN KEY (product_id_product)
    REFERENCES product (id_product),
  CONSTRAINT fk_pizza_category_category1
    FOREIGN KEY (category_id_category)
    REFERENCES category (id_category)
) ENGINE=InnoDB;

-- Pedido
CREATE TABLE request (
  id_request INT AUTO_INCREMENT PRIMARY KEY,
  takeaway_or_pickup ENUM('takeaway', 'pickup'),
  total_amount INT,
  price DECIMAL(8,2),
  delivery_date_hour DATETIME,
  client_id_client INT NOT NULL,
  worker_id_worker INT NOT NULL,
  store_id_store INT NOT NULL,
  INDEX fk_order_client1_idx (client_id_client),
  INDEX fk_order_worker1_idx (worker_id_worker),
  INDEX fk_order_store1_idx (store_id_store),
  CONSTRAINT fk_order_client1
    FOREIGN KEY (client_id_client)
    REFERENCES client (id_client),
  CONSTRAINT fk_order_worker1
    FOREIGN KEY (worker_id_worker)
    REFERENCES worker (id_worker),
  CONSTRAINT fk_order_store1
    FOREIGN KEY (store_id_store)
    REFERENCES store (id_store)
) ENGINE=InnoDB;

-- Detalle del pedido (líneas de pedido: qué producto, cuántas unidades)
CREATE TABLE request_detail (
  id_request_detail INT AUTO_INCREMENT PRIMARY KEY,
  quantity INT,
  product_id_product INT NOT NULL,
  request_id_request INT NOT NULL,
  INDEX fk_request_detail_product1_idx (product_id_product),
  INDEX fk_request_detail_request1_idx (request_id_request),
  CONSTRAINT fk_request_detail_product1
    FOREIGN KEY (product_id_product)
    REFERENCES product (id_product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_request_detail_request1
    FOREIGN KEY (request_id_request)
    REFERENCES request (id_request)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;
