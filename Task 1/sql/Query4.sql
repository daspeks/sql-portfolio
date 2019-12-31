USE Test;               
                           
-- Q4. Find the product (ID #) that brought in the second most revenue in March

-- Short solution
SELECT product_id,  revenue_generated
FROM (SELECT product_id, SUM(transaction_amount) AS revenue_generated , DENSE_RANK() OVER (ORDER BY SUM(transaction_amount) DESC) AS DR
	  FROM Transactions
	  WHERE MONTH(transaction_date)=3 AND YEAR(transaction_date)=2018
	  GROUP BY product_id
	  ORDER BY product_id ASC) AS T
WHERE T.DR=2;

-- Long solution
-- SELECT product_id, revenue_generated
-- FROM (SELECT product_id, SUM(transaction_amount) AS revenue_generated 
-- 	  FROM Transactions
--       WHERE MONTH(transaction_date)=3 AND YEAR(transaction_date)=2018
-- 	  GROUP BY product_id
-- 	  ORDER BY revenue_generated DESC, product_id ASC) AS T
-- WHERE revenue_generated = (SELECT MAX(revenue_generated)
-- 						   FROM (SELECT product_id, SUM(transaction_amount) AS revenue_generated 
-- 							     FROM Transactions
--                                  WHERE MONTH(transaction_date)=3 AND YEAR(transaction_date)=2018
-- 								 GROUP BY product_id
-- 								 ORDER BY revenue_generated DESC, product_id ASC) AS T
-- 						   WHERE revenue_generated < (SELECT MAX(revenue_generated)
-- 													  FROM (SELECT product_id, sum(transaction_amount) AS revenue_generated 
-- 															FROM Transactions
-- 															WHERE MONTH(transaction_date)=3 AND YEAR(transaction_date)=2018
-- 															GROUP BY product_id
-- 															ORDER BY revenue_generated DESC, product_id ASC) AS T));