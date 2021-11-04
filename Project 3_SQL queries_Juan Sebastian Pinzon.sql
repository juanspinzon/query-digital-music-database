###SQL queries for Chinook project_Juan Sebastian Pinzon

/* Q1: How many tracks are there by genre? */
SELECT
  g.Name,
  COUNT(*) Number_Tracks
FROM Track t
JOIN Genre g
  ON t.GenreID = g.GenreID
GROUP BY 1
ORDER BY 2 DESC;

/* Q2: 2.	What is the distribution for total songs sold and what are the artists that has earned the most? */

/* To find the average of total sales */
SELECT
  AVG(Table1.Total_Sales)
FROM (SELECT
  ar.name,
  COUNT(*) * il.UnitPrice Total_Sales
FROM Artist ar
JOIN Album al
  ON ar.ArtistID = al.ArtistID
JOIN Track t
  ON al.AlbumID = t.AlbumID
JOIN InvoiceLine il
  ON t.TrackID = il.TrackID
GROUP BY 1) Table1

/* To find the sales distribution and top artists */
SELECT
  ar.Name,
  COUNT(*) Sold_Songs,
  il.UnitPrice,
  COUNT(*) * il.UnitPrice Total_Sales
FROM Artist ar
JOIN Album al
  ON ar.ArtistID = al.ArtistID
JOIN Track t
  ON al.AlbumID = t.AlbumID
JOIN InvoiceLine il
  ON t.TrackID = il.TrackID
GROUP BY 1
HAVING COUNT(*)*il.UnitPrice > 50
ORDER BY 2 DESC;

/* Q3: Amount spent by customers by Genre */
SELECT
  g.Name,
  COUNT(il.Quantity) SongsSold,
  il.UnitPrice,
  COUNT(il.Quantity) * il.UnitPrice AmountSpent
FROM Genre g
JOIN Track t
  ON g.GenreID = t.GenreID
JOIN InvoiceLine il
  ON t.TrackID = il.TrackID
GROUP BY 1
ORDER BY 2 DESC;

/* Q4: Who is the best customer and what are his/her purchases? */

/*To find the best customer */
SELECT
  c.CustomerID,
  c.FirstName,
  c.LastName,
  SUM(Total)
FROM Customer c
JOIN Invoice i
  ON c.CustomerID = i.CustomerID
GROUP BY 1,
         2,
         3
ORDER BY 4 DESC
LIMIT 1;

/* Details about his/her purchases */
SELECT
  c.FirstName,
  c.LastName,
  g.Name GenreName,
  COUNT(*) NumberTracks,
  il.UnitPrice,
  SUM(il.Quantity) * il.UnitPrice AmountSpent
FROM Customer c
JOIN Invoice i
  ON c.CustomerID = i.CustomerID
JOIN InvoiceLine il
  ON i.InvoiceID = il.InvoiceID
JOIN Track t
  ON il.TrackID = t.TrackID
JOIN Genre g
  ON t.GenreID = g.GenreID
WHERE c.CustomerID = 6
GROUP BY 1,
         2,
         3
ORDER BY 6 DESC;
