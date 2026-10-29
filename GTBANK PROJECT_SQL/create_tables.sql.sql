CREATE DATABASE gtbank;
USE gtbank;

-- CUSTOMERS
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(20),
  date_of_birth DATE,
  registration_date DATE NOT NULL,
  customer_type VARCHAR(20)
);

-- BRANCHES
CREATE TABLE branches (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(100) NOT NULL,
  city VARCHAR(50),
  state VARCHAR(50),
  manager_name VARCHAR(100)
);

-- ACCOUNTS
CREATE TABLE accounts (
  account_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  account_number VARCHAR(20) UNIQUE NOT NULL,
  account_type VARCHAR(20),
  balance DECIMAL(15,2) DEFAULT 0,
  opening_date DATE,
  branch_id INT,
  status VARCHAR(20) DEFAULT 'Active',
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- LOANS
CREATE TABLE loans (
  loan_id INT PRIMARY KEY,
  customer_id INT,
  loan_type VARCHAR(30),
  loan_amount DECIMAL(15,2),
  interest_rate DECIMAL(5,2),
  loan_date DATE,
  loan_status VARCHAR(20),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- TRANSACTIONS
CREATE TABLE transactions (
  transaction_id INT PRIMARY KEY,
  account_id INT,
  transaction_type VARCHAR(20),
  amount DECIMAL(15,2),
  transaction_date DATETIME,
  description TEXT,
  balance_after DECIMAL(15,2),
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);