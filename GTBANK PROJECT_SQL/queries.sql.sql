-- Customers with more than one account
SELECT customer_id, COUNT(account_id) AS total_accounts
FROM accounts
GROUP BY customer_id
HAVING COUNT(account_id) > 1;

-- Total balance per customer
SELECT c.first_name, c.last_name, SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id;

-- Top 5 customers by transaction amount
SELECT c.first_name, c.last_name, SUM(t.amount) AS total_amount
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.customer_id
ORDER BY total_amount DESC
LIMIT 5;

-- Large transactions (fraud check)
SELECT c.first_name, c.last_name, t.amount, t.transaction_date, t.transaction_type
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
WHERE t.amount > 10000;

-- Average balance by account type
SELECT account_type, AVG(balance) AS avg_balance
FROM accounts
GROUP BY account_type;

-- Frequent withdrawals (fraud detection)
SELECT c.first_name, COUNT(t.transaction_id) AS withdrawals
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_type = 'Withdrawal'
GROUP BY c.customer_id
HAVING COUNT(t.transaction_id) > 10;

-- Branch performance
SELECT b.branch_name, COUNT(a.account_id) AS total_accounts
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_id
ORDER BY total_accounts DESC;

-- Customers with loan + savings account
SELECT DISTINCT c.first_name, c.last_name
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN loans l ON c.customer_id = l.customer_id
WHERE a.account_type = 'Savings';

-- Loan analysis
SELECT loan_type, loan_status, SUM(loan_amount) AS total
FROM loans
GROUP BY loan_type, loan_status;

-- Low balance accounts
SELECT account_number, balance
FROM accounts
WHERE balance < 100;

-- Above average customers
SELECT c.customer_id, SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id
HAVING SUM(a.balance) > (SELECT AVG(balance) FROM accounts);

-- Most active account
SELECT account_id, COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY account_id
ORDER BY total_transactions DESC
LIMIT 1;

-- Monthly transaction volume
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS month,
SUM(amount) AS total_volume
FROM transactions
GROUP BY month;

-- Inactive customers
SELECT c.customer_id, c.first_name
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

-- Customer statement (customer_id = 5)
SELECT c.first_name, a.account_number, t.transaction_type, t.amount
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
WHERE c.customer_id = 5;