USE Test;

-- Q3. Find the product (ID #) that brought in the most revenue in March

-- Short solution
SELECT product_id, revenue_generated 
FROM (SELECT product_id, SUM(transaction_amount) AS revenue_generated, DENSE_RANK() OVER (ORDER BY sum(transaction_amount) DESC) AS DR
	FROM Transactions
	WHERE MONTH(transaction_date)=3 AND YEAR(transaction_date)=2018
	GROUP BY product_id
	ORDER BY product_id ASC) AS T
WHERE T.DR=1;

-- Long solution
-- SELECT product_id, revenue_generated
-- FROM (SELECT product_id, SUM(transaction_amount) AS revenue_generated
-- 	  FROM Transactions
--       WHERE MONTH(transaction_date)=3 AND YEAR(transaction_date)=2018
-- 	  GROUP BY product_id
-- 	  ORDER BY revenue_generated DESC, product_id ASC) AS T
-- WHERE revenue_generated = (SELECT MAX(revenue_generated)
-- 						   FROM (SELECT product_id, SUM(transaction_amount) AS revenue_generated 
-- 								 FROM Transactions
-- 								 WHERE MONTH(transaction_date)=3 AND YEAR(transaction_date)=2018
-- 								 GROUP BY product_id
-- 								 ORDER BY revenue_generated DESC, product_id ASC) AS T);