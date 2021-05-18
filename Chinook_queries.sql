/* 1- Query showing Customers (their full names, customer ID and country) who are not in the US.  */

SELECT FirstName,LastName,Country 
FROM customer 
WHERE Country<>'USA';


/* 2- Query to show the nunber of customers from each country, ordered by their count in descending order. */

SELECT Country,count(CustomerId) 
FROM customer 
GROUP BY Country 
ORDER BY count(Country) DESC;


/* 3- query that shows the invoices associated with each sales agent. The resulting table should include the Sales Agent's full name. */

SELECT e.firstname, e.lastname, i.invoiceid, i.customerid, i.invoicedate, i.billingaddress, i.billingcountry, i.billingpostalcode,i.total
FROM customer as c JOIN invoice as i
ON c.customerid = i.customerid
JOIN employee as e
ON e.employeeid = c.supportrepid
ORDER BY e.employeeid;


/* 4- Query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers. */

SELECT e.firstname as 'employee first', e.lastname as 'employee last', c.firstname as 'customer first', c.lastname as 'customer last', 
c.country, i.total
FROM employee as e
	JOIN customer as c on e.employeeid = c.supportrepid
	JOIN invoice as i on c.customerid = i.customerid;
    

/* 5- Provide a query that shows the # of invoices per country.*/

SELECT billingcountry, count(billingcountry) as '# of invoices'
FROM invoice
GROUP BY billingcountry 
ORDER BY count(billingcountry) DESC;


/* 6- Query that shows the details of tracks associated with Albums. */

SELECT album.*,track.trackId,track.Name 
FROM album 
JOIN track ON album.AlbumId=track.AlbumId;


/* 7- Query that shows details of nuber of tracks associated with each genre. */

SELECT genre.name,count(track.trackId) as 'Count of tracks' 
FROM genre 
JOIN track ON genre.genreId=track.genreId 
GROUP BY genre.genreId 
ORDER BY count(track.trackId) DESC;


/* 8- What is the average number of invoices by BillingCountry? */

SELECT BillingCountry, round(AVG(Invoiceid),0) as NetInvoices
FROM Invoice
JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId
GROUP BY BillingCountry
ORDER BY NetInvoices DESC
LIMIT 10;


/* 9- What is the total earnings received by top 10 artists? */

SELECT
  Artist.Name,
  SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS ArtistEarnings
FROM Invoice
JOIN InvoiceLine
  ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Track
  ON Track.TrackId = InvoiceLine.TrackId
JOIN Album
  ON Track.AlbumId = Album.AlbumId
JOIN Artist
  ON Album.ArtistId = Artist.ArtistId
GROUP BY Artist.ArtistId
ORDER BY ArtistEarnings DESC
LIMIT 10;


/* 10- Having understood the countries in which Chinook store sells most, let’s identify the popular music genres among customers in the top five countries which account for most customers and sales: USA, Canada, Brazil, France, and Germany. */

SELECT 
		g.name,
		COUNT(*) tracks_sold
		FROM genre g 
		INNER JOIN track t ON g.genreid = t.genreid
		INNER JOIN invoiceline il ON il.trackid = t.trackid
		INNER JOIN invoice i ON i.invoiceid = il.invoiceid
		WHERE i.billingcountry IN ("USA", "Canada", "Brazil", "France", "Germany")
		GROUP BY 1;
                  
                  
/* 11- Query to understand the total sales (in dollars) made by each sales representative. */

WITH 
		employee_sales AS
		(
		SELECT
		c.supportrepid,
		COUNT(*) as num_of_sales,
		SUM(i.total) as total_sales_value
		FROM customer c
        INNER JOIN invoice i ON c.customerid = i.customerid
        GROUP BY 1
		)
              
		SELECT
		concat(e.firstname," ",e.lastname) as name,
		e.hiredate,
		es.num_of_sales,
		es.total_sales_value
		FROM employee e
		INNER JOIN employee_sales es ON e.employeeid = es.supportrepid
		ORDER BY es.total_sales_value DESC;


                  
                  


    
    


