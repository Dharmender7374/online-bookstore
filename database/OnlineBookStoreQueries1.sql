<<<<<<< HEAD
--Queries
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Books;

--1.Retrieve all books in the 'Fiction' genre
SELECT book_id,title,author,published_year,genre
FROM Books
WHERE LOWER(TRIM(genre)) = 'fiction';

--2.Find books published after the year 1950
SELECT book_id,title,published_year AS books_published
FROM Books
WHERE published_year > 1950
ORDER BY books_published ASC;

--3.List all customers from the Canada
SELECT * FROM Customers;

SELECT customer_id,name,country
FROM Customers
WHERE country = 'Canada';

--4.Show orders placed in November 2023
SELECT * FROM Orders;

SELECT order_id,order_date
FROM Orders
WHERE  order_date >= Date '2023-11-01' 
	AND order_date < Date '2023-12-01';

--5.Retrieve the total stock of books available.
SELECT * FROM Books;

SELECT SUM(stock) AS total_stock
FROM Books;

--6.Find the details of the most expensive book.
SELECT * FROM Books;

SELECT book_id,title,author,genre,published_year,price
FROM Books
ORDER BY price DESC
LIMIT 1;


--7.Show all customers who ordered more than 1 quantity of a book.
SELECT * FROM Customers;
SELECT * FROM Books;
SELECT * FROM Orders;

SELECT c.name, b.title, SUM(o.quantity) AS total_quantity
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Books b ON o.book_id = b.book_id
GROUP BY c.name, b.title
HAVING SUM(o.quantity) > 1
ORDER BY total_quantity ASC;


--8.Retrieve all orders where the total amount exceeds $20.
SELECT * FROM Customers;
SELECT * FROM Books;
SELECT * FROM Orders;

SELECT order_id,total_amount
FROM Orders
WHERE total_amount > 20
ORDER BY order_id DESC;


--9.Find the book with the lowest stock
SELECT * FROM Books;

SELECT book_id, title, stock
FROM Books
WHERE stock = (SELECT MIN(stock) FROM Books)
ORDER BY stock ASC
LIMIT 1;


--10.Calculate the total revenue generated from all orders


--11.Retrieve the total number of books sold for each genre
--12.Find the average price of books in the "Fantasy" genre
--13.List customers who have placed atleast 2 orders
--14.Find the most frequently ordered book
--15.Show the top 3 most expensive books of "Fantasy" Genre
--16.Retrieve the total quantity of books sold by each author
--17.List the cities where customers who spent over $30 are 
--18.Find the customers who spent the most on orders
--19.Calculate the stock remaining after fulfilling orders.




































=======
--Queries
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Books;

--1.Retrieve all books in the 'Fiction' genre
SELECT book_id,title,author,published_year,genre
FROM Books
WHERE LOWER(TRIM(genre)) = 'fiction';

--2.Find books published after the year 1950
SELECT book_id,title,published_year AS books_published
FROM Books
WHERE published_year > 1950
ORDER BY books_published ASC;

--3.List all customers from the Canada
SELECT * FROM Customers;

SELECT customer_id,name,country
FROM Customers
WHERE country = 'Canada';

--4.Show orders placed in November 2023
SELECT * FROM Orders;

SELECT order_id,order_date
FROM Orders
WHERE  order_date >= Date '2023-11-01' 
	AND order_date < Date '2023-12-01';

--5.Retrieve the total stock of books available.
SELECT * FROM Books;

SELECT SUM(stock) AS total_stock
FROM Books;

--6.Find the details of the most expensive book.
SELECT * FROM Books;

SELECT book_id,title,author,genre,published_year,price
FROM Books
ORDER BY price DESC
LIMIT 1;


--7.Show all customers who ordered more than 1 quantity of a book.
SELECT * FROM Customers;
SELECT * FROM Books;
SELECT * FROM Orders;

SELECT c.name, b.title, SUM(o.quantity) AS total_quantity
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Books b ON o.book_id = b.book_id
GROUP BY c.name, b.title
HAVING SUM(o.quantity) > 1
ORDER BY total_quantity ASC;


--8.Retrieve all orders where the total amount exceeds $20.
SELECT * FROM Customers;
SELECT * FROM Books;
SELECT * FROM Orders;

SELECT order_id,total_amount
FROM Orders
WHERE total_amount > 20
ORDER BY order_id DESC;


--9.Find the book with the lowest stock
--10.Calculate the total revenue generated from all orders


--11.Retrieve the total number of books sold for each genre
--12.Find the average price of books in the "Fantasy" genre
--13.List customers who have placed atleast 2 orders
--14.Find the most frequently ordered book
--15.Show the top 3 most expensive books of "Fantasy" Genre
--16.Retrieve the total quantity of books sold by each author
--17.List the cities where customers who spent over $30 are 
--18.Find the customers who spent the most on orders
--19.Calculate the stock remaining after fulfilling orders.




































>>>>>>> 6162aa54efdcfc9851243036e06303e6881a1d64
