/*
QUERY 2
How many customers fall into different spending groups?
*/

WITH customer_spent AS (SELECT c.CustomerId, 
                              (c.FirstName || ' ' || c.LastName) AS Name,
                              sum(i.total) AS Tot_Spent
                       FROM Customer c
                       JOIN Invoice i ON c.CustomerId = i.CustomerId
                       GROUP BY 1
			           ORDER BY 3 DESC)

SELECT CASE
           WHEN Tot_Spent < 40 THEN "Low"
           WHEN Tot_Spent BETWEEN 40 AND 45 THEN "Medium"
           ELSE "High"
       END AS Category,
       count(CustomerId) AS "Customers Count"
FROM customer_spent
GROUP BY 1;