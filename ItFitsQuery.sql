CREATE DATABASE ITFITS;

USE ITFITS;

--TABLES

CREATE TABLE COUPONS(
couponCode VARCHAR(10),
discount INT
);

CREATE TABLE CUSTOMERS(
customerID INT IDENTITY (1000,1) PRIMARY KEY,
cartContents VARCHAR(50),
userID INT
); 

CREATE TABLE PRODUCT_MANAGER(
prodManagerID INT IDENTITY (2000,1) PRIMARY KEY,
managedProducts TEXT,
approvedProducts TEXT,
userID INT
);

CREATE TABLE ADMINISTRATOR(
adminID INT IDENTITY (3000,1) PRIMARY KEY,
adminPermission TEXT,
systemReports TEXT,
approvedDeliveries TEXT,
employeesManaged TEXT,
userID INT
);

CREATE TABLE CUSTOMER_SALES_REP(
custSalesRepID INT IDENTITY (4000,1) PRIMARY KEY,
assignedCustomers TEXT,
activeConversations TEXT,
userID INT

);

CREATE TABLE USER_ACCOUNT(
userID INT IDENTITY (5000,1) PRIMARY KEY,
username VARCHAR(50),
email VARCHAR(99),
password VARCHAR(300),
firstName VARCHAR(255),
lastName VARCHAR(255),
profilePicture VARCHAR(255),
lastLogin DATETIME,
userStatus VARCHAR(30),
height FLOAT,
weight FLOAT,
userRole TEXT
);

CREATE TABLE PRODUCTS(
productID INT IDENTITY (6000,1),
productName VARCHAR(100),
category VARCHAR(50),
description TEXT,
price DECIMAL(10,2),
sizeOptions VARCHAR(100),
productImage VARCHAR(255)
);

CREATE TABLE ORDERS(
  orderID INT IDENTITY(100,1) PRIMARY KEY,
  userID INT NOT NULL,
  orderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(20) DEFAULT 'Pending'
);

CREATE TABLE CART_ITEMS(
  orderItemID INT IDENTITY(200,1) PRIMARY KEY,
  orderID INT NOT NULL,
  productID INT NOT NULL,
  quantity INT NOT NULL,
  unitPrice DECIMAL(10,2) NOT NULL,
  totalPrice DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (orderID) REFERENCES Orders(orderID)
);


CREATE TABLE VIRTUAL_FITTING_ROOM(
fittingRoomID INT IDENTITY (8000,1),
userID INT,
timestamp DATETIME
);

--PRIVILEGED ACCOUNTS
insert into USER_ACCOUNT (username, email, password, userRole)
VALUes
('Admin','admin@gmail.com','admin','Administrator'),
('Manager','manager@gmail.com','manager','Product Manager'),
('Sales Rep','salesrep@gmail.com','salesrep','Customer Sales Rep');

--SAMPLE CUSTOMER ACCOUNT
insert into USER_ACCOUNT (username, email, password, firstName, lastName, userStatus, height, weight, userRole)
Values
('RealUsername','customer@gmail.com','customer','John','Doe','Active','181','80','Customer');

--SHOW TABLE
select * from USER_ACCOUNT;

--DELETE TABLE
drop table USER_ACCOUNT;

--COUPONS
INSERT INTO COUPONS (couponCode, discount)
VALUES ('PasaraKami','100');

--SHOW COUPONS
SELECT * FROM COUPONS;
