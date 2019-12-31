USE Test;

-- Q2. Find the number of unique members that joined per day for March
SELECT DATE(transaction_date) AS march_date, COUNT(distinct member_id) AS number_of_unique_members
FROM Transactions
WHERE MONTH(transaction_date)=3 AND YEAR(transaction_date)=2018 AND transaction_type_id=1
GROUP BY transaction_date
ORDER BY transaction_date ASC;