/*
QUERY 3
Who are Top 5 Artists by Total Sales?
*/

WITH Artist_Rev AS (SELECT r.ArtistId, r.Name AS Artist,
                           sum(l.Quantity * l.UnitPrice) AS "Revenue USD"
                    FROM Invoice i
                    JOIN InvoiceLine l ON i.InvoiceId = l.InvoiceId
                    JOIN Track t ON l.TrackId = t.TrackId
                    JOIN Album a ON t.AlbumId = a.AlbumId
                    JOIN Artist r ON a.ArtistId = r.ArtistId
                    GROUP BY 1
					ORDER BY 3 DESC),
    Artist_rank AS (SELECT Artist, "Revenue USD",
                    rank() OVER (ORDER BY "Revenue USD" DESC) AS "Rank"
                    FROM Artist_Rev)
					
SELECT Artist, "Revenue USD", "Rank"
FROM Artist_rank
WHERE "Rank" <= 5
ORDER BY 3;
