--Create Table
DROP TABLE IF EXISTS Books;
CREATE TABLE Books(
		Book_ID SERIAL PRIMARY KEY,
		Title VARCHAR(100),
		Author VARCHAR(100),
		Genre VARCHAR(50),
		Published_year INT,
		Price NUMERIC(10,2),
		Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers(
		Customer_ID SERIAL PRIMARY KEY,
		Name VARCHAR(100),
		Email VARCHAR(100),
		Phone VARCHAR(15),
		City VARCHAR(50),
		Country VARCHAR(150)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
		Order_ID SERIAL PRIMARY KEY,
		Customer_ID INT REFERENCES Customers(Customer_ID),
		Book_ID INT REFERENCES Books(Book_ID),
		Order_Date DATE,
		Quantity INT,
		Total_Amount NUMERIC(10,2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

--Import
COPY Books(Title, Author, Genre, Published_year, Price, Stock)
FROM 'H:\olist\New folder1\SALES\Book4.csv'
CSV HEADER;

COPY Customers(Name,Email,Phone,City,Country)
FROM 'H:\olist\New folder1\SALES\Customers1.csv'
CSV HEADER;

COPY Orders(Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
FROM 'H:\olist\New folder1\SALES\Orders.csv'
CSV HEADER;

SHOW data_directory;



