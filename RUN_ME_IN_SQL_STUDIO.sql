-- Create the database
CREATE DATABASE ITFITS;
GO

-- Switch context immediately
USE ITFITS;
GO

-- Create USER_ACCOUNT table
CREATE TABLE USER_ACCOUNT (
    userID INT IDENTITY(5000,1) PRIMARY KEY,
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
GO

-- Create CUSTOMERS table
CREATE TABLE CUSTOMERS (
    customerID INT IDENTITY(1000,1) PRIMARY KEY,
    cartContents VARCHAR(50),
    userID INT
);
GO

-- Create PRODUCT_MANAGER table
CREATE TABLE PRODUCT_MANAGER (
    prodManagerID INT IDENTITY(2000,1) PRIMARY KEY,
    managedProducts TEXT,
    approvedProducts TEXT,
    userID INT
);
GO

-- Create ADMINISTRATOR table
CREATE TABLE ADMINISTRATOR (
    adminID INT IDENTITY(3000,1) PRIMARY KEY,
    adminPermission TEXT,
    systemReports TEXT,
    approvedDeliveries TEXT,
    employeesManaged TEXT,
    userID INT
);
GO

-- Create CUSTOMER_SALES_REP table
CREATE TABLE CUSTOMER_SALES_REP (
    custSalesRepID INT IDENTITY(4000,1) PRIMARY KEY,
    assignedCustomers TEXT,
    activeConversations TEXT,
    userID INT
);
GO

-- Create PRODUCTS table
CREATE TABLE PRODUCTS (
    productID INT IDENTITY(6000,1) PRIMARY KEY,
    productName VARCHAR(100),
    category VARCHAR(50),
    description TEXT,
    price DECIMAL(10,2),
    sizeOptions VARCHAR(100),
    productImage VARCHAR(255)
);
GO

-- Create ORDERS table
CREATE TABLE ORDERS (
    orderID INT IDENTITY(7000,1) PRIMARY KEY,
    userID INT,
    orderDate DATETIME,
    totalAmount DECIMAL(10,2),
    status VARCHAR(50)
);
GO

-- Create VIRTUAL_FITTING_ROOM table
CREATE TABLE VIRTUAL_FITTING_ROOM (
    fittingRoomID INT IDENTITY(8000,1) PRIMARY KEY,
    userID INT,
    timestamp DATETIME
);
GO

-- Create CART_ITEMS table
CREATE TABLE CART_ITEMS (
    cartItemID INT IDENTITY(9000,1) PRIMARY KEY,
    customerID INT,
    productID INT,
    quantity INT,
    dateAdded DATETIME
);
GO

-- Insert default privileged accounts
INSERT INTO USER_ACCOUNT (username, email, password, userRole)
VALUES
('Admin', 'admin@gmail.com', 'admin', 'Administrator'),
('Manager', 'manager@gmail.com', 'manager', 'Product Manager'),
('Sales Rep', 'salesrep@gmail.com', 'salesrep', 'Customer Sales Rep');
GO

-- Insert sample customer account
INSERT INTO USER_ACCOUNT (
    username, email, password, firstName, lastName, userStatus, height, weight, userRole
)
VALUES (
    'RealUsername', 'customer@gmail.com', 'customer',
    'John', 'Doe', 'Active',
    181, 80, 'Customer'
);
GO

-- Show data to verify
SELECT * FROM USER_ACCOUNT;
GO
