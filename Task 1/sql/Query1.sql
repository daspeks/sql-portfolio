USE Test;

-- Q1. Find the number of joins per day for March
SELECT DATE(transaction_date) AS Date, COUNT(member_id) AS Joins
FROM Transactions
WHERE MONTH(transaction_date)=3 AND YEAR(transaction_date)=2018 AND transaction_type_id=1
GROUP BY transaction_date
ORDER BY transaction_date ASC;