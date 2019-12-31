USE Test;

-- Q5 Find the average revenue per member that signed up in January within 1 month and 2 months of their signup date
SELECT TABLE1.member_id AS member_id, TABLE1.average_revenue AS one_mm_avg, TABLE2.average_revenue AS two_mm_avg 
FROM ((SELECT B.member_id, round(AVG(transaction_amount), 2) AS average_revenue
	  FROM (SELECT A.member_id, A.transaction_amount 
			FROM (SELECT M.member_id, M.signup_date, T.transaction_date, T.transaction_amount
				  FROM Memberships M, Transactions T
				  WHERE M.member_id = T.member_id AND MONTH(signup_date)=1 AND YEAR(transaction_date)=2018
				  ORDER BY T.member_id ASC) AS A
				  WHERE DATEDIFF(A.transaction_date, A.signup_date) <= 30) AS B
	  GROUP BY B.member_id) AS TABLE1
	  RIGHT JOIN
	 (SELECT B.member_id, round(AVG(transaction_amount), 2) AS average_revenue 
	  FROM (SELECT A.member_id, A.transaction_amount 
			FROM (SELECT M.member_id, M.signup_date, T.transaction_date, T.transaction_amount
				  FROM Memberships M, Transactions T
				  WHERE M.member_id = T.member_id AND MONTH(signup_date)=1 AND YEAR(transaction_date)=2018
				  ORDER by T.member_id ASC) AS A
			WHERE DATEDIFF(A.transaction_date, A.signup_date) <= 60) AS B
	  GROUP BY B.member_id) AS TABLE2
      ON TABLE1.member_id = TABLE2.member_id);