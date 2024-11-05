/*
QUERY 1
What is Iron Maiden's monthly growth rate?
*/
WITH Monthly_Maiden_Rev AS 
  (SELECT strftime('%Y-%m', i.InvoiceDate) AS MONTH, 
          sum(l.UnitPrice*l.Quantity) AS Revenue 
   FROM Invoice i 
   JOIN InvoiceLine l ON i.InvoiceId = l.InvoiceId 
   JOIN Track t ON l.TrackId = t.TrackId 
   JOIN Album a ON t.AlbumId = a.AlbumId 
   JOIN Artist r ON a.ArtistId = r.ArtistId 
   WHERE r.Name = 'Iron Maiden'
   GROUP BY 1)
SELECT MONTH,
       Revenue,
       lag(Revenue, 1) OVER (
                             ORDER BY MONTH) AS "Previous Revenue",
       round(((Revenue - lag(Revenue, 1) OVER (
                                               ORDER BY MONTH)) / NULLIF(lag(Revenue, 1) OVER (
                                                                                             ORDER BY MONTH), 0)) * 100, 2) AS "Growth Rate"
FROM Monthly_Maiden_Rev
ORDER BY 1