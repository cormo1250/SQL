DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;

CREATE TABLE shop.categories
(
    id          INT AUTO_INCREMENT,
    name        VARCHAR(32) NOT NULL UNIQUE,
    signature   VARCHAR(3)  NOT NULL UNIQUE,
    description VARCHAR(64),
    PRIMARY KEY (id)
);

CREATE TABLE shop.clients
(
    id         INT AUTO_INCREMENT,
    first_name VARCHAR(64)  NOT NULL,
    last_name  VARCHAR(64)  NOT NULL,
    language   VARCHAR(2)   NOT NULL DEFAULT 'GB',
    email      VARCHAR(64)  NOT NULL,
    login      VARCHAR(32)  NOT NULL UNIQUE,
    password   VARCHAR(256) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE shop.suppliers
(
    id INT AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE shop.product_details (
    id INT AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    period INT NOT NULL,
    category INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (category) REFERENCES categories(id)
);

CREATE TABLE shop.products (
    id INT AUTO_INCREMENT,
    prd_details INT NOT NULL,
    supplier INT NOT NULL,
    cost DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (prd_details) REFERENCES product_details(id),
    FOREIGN KEY (supplier) REFERENCES suppliers(id)
);

CREATE TABLE shop.orders (
    id INT AUTO_INCREMENT,
    clt INT NOT NULL,
    order_date DATE NOT NULL,
    payment_date DATE,
    status VARCHAR(32) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (clt) REFERENCES clients(id)
);

CREATE TABLE shop.order_details (
    id INT AUTO_INCREMENT,
    ord INT NOT NULL,
    prd INT NOT NULL,
    quantity INT NOT NULL,
    cost DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (ord) REFERENCES orders(id),
    FOREIGN KEY (prd) REFERENCES products(id)
);