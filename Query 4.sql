/*
QUERY 4
How much does each media type contribute to the total revenue?
*/

WITH total_rev AS (SELECT sum(Total) AS Sum_total
                     FROM Invoice ),
     media_rev AS (SELECT m.Name AS "Media Type",
                            sum(l.Quantity * l.UnitPrice) AS "Media Revenue"
                     FROM MediaType m
                     JOIN Track t ON m.MediaTypeId = t.MediaTypeId
                     JOIN InvoiceLine l ON t.TrackId = l.TrackId
                     GROUP BY 1
					 ORDER BY 1 DESC)

SELECT "Media Type",
       "Media Revenue",
       round(("Media Revenue" / (SELECT Sum_total FROM total_rev) * 100),2) AS "Contribution %"
FROM media_rev
ORDER BY 3 DESC;