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
WITH min_stock AS (
    SELECT MIN(stock) AS lowest_stock
    FROM books
)
SELECT b.*
FROM books b
JOIN min_stock m
ON b.stock = m.lowest_stock;

--10.Calculate the total revenue generated from all orders
WITH order_revenue AS (
    SELECT 
        o.order_id,
        (o.quantity * b.price) AS revenue_per_order
    FROM orders o
    JOIN books b
        ON o.book_id = b.book_id
)
SELECT 
    SUM(revenue_per_order) AS total_revenue
FROM order_revenue;


--11.Retrieve the total number of books sold for each genre.
WITH genre_sales AS (
    SELECT 
        b.genre,
        o.quantity
    FROM orders o
    JOIN books b
        ON o.book_id = b.book_id
)

SELECT 
    genre,
    SUM(quantity) AS total_books_sold
FROM genre_sales
GROUP BY genre
ORDER BY total_books_sold DESC;


--12.Find the average price of books in the "Fantasy" genre.
WITH book_stats AS (
    SELECT 
        genre,
        price
    FROM books
)

SELECT 
    genre,
    AVG(price) AS avg_price
FROM book_stats
GROUP BY genre
HAVING genre = 'Fantasy';

--13.List customers who have placed atleast 2 orders.
WITH customer_order_count AS (
    SELECT 
        customer_id,
        COUNT(order_id) AS total_orders
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) >= 2
)

SELECT 
    c.customer_id,
    c.name,
    c.email,
    coc.total_orders
FROM customer_order_count coc
JOIN customers c
    ON c.customer_id = coc.customer_id;

--14.Find the most frequently ordered book.
WITH book_sales AS (
    SELECT 
        b.book_id,
        b.title,
        SUM(o.quantity) AS total_quantity
    FROM orders o
    JOIN books b
        ON o.book_id = b.book_id
    GROUP BY b.book_id, b.title
),
ranked_books AS (
    SELECT *,
           RANK() OVER (ORDER BY total_quantity DESC) AS rnk
    FROM book_sales
)

SELECT 
    book_id,
    title,
    total_quantity
FROM ranked_books
WHERE rnk = 1;

--15.Show the top 3 most expensive books of "Fantasy" Genre.
WITH fantasy_books AS (
    SELECT 
        book_id,
        title,
        price
    FROM books
    WHERE genre = 'Fantasy'
),
ranked_books AS (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY price DESC) AS rnk
    FROM fantasy_books
)

SELECT 
    book_id,
    title,
    price
FROM ranked_books
WHERE rnk <= 3;

--16.Retrieve the total quantity of books sold by each author.
WITH author_sales AS (
    SELECT 
        b.author,
        SUM(o.quantity) AS total_books_sold
    FROM orders o
    JOIN books b
        ON o.book_id = b.book_id
    GROUP BY b.author
),
ranked_authors AS (
    SELECT *,
           RANK() OVER (ORDER BY total_books_sold DESC) AS rnk
    FROM author_sales
)

SELECT 
    author,
    total_books_sold,
    rnk
FROM ranked_authors
ORDER BY rnk;

--17.List the cities where customers who spent over $30 are located.
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.city,
        SUM(o.quantity * b.price) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN books b
        ON o.book_id = b.book_id
    GROUP BY c.customer_id, c.city
)

SELECT DISTINCT 
    city
FROM customer_spending
WHERE total_spent > 30;

--18.Find the customers who spent the most on orders.
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.name,
        SUM(o.quantity * b.price) AS total_spent
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id
    JOIN books b 
        ON o.book_id = b.book_id
    GROUP BY c.customer_id, c.name
),
ranked_customers AS (
    SELECT *,
           RANK() OVER (ORDER BY total_spent DESC) AS rnk
    FROM customer_spending
)

SELECT 
    customer_id,
    name,
    total_spent
FROM ranked_customers
WHERE rnk = 1;


--19.Calculate the stock remaining after fulfilling orders.
WITH sales AS (
    SELECT 
        book_id,
        SUM(quantity) AS total_sold
    FROM orders
    GROUP BY book_id
),
stock_calc AS (
    SELECT 
        b.book_id,
        b.title,
        b.stock AS initial_stock,
        COALESCE(s.total_sold, 0) AS total_sold,
        (b.stock - COALESCE(s.total_sold, 0)) AS remaining_stock
    FROM books b
    LEFT JOIN sales s
        ON b.book_id = s.book_id
)

SELECT 
    book_id,
    title,
    initial_stock,
    total_sold,
    remaining_stock
FROM stock_calc;




































