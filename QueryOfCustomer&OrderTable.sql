CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    City VARCHAR(255)
);

CREATE TABLE [Order] (
    OrderId INT PRIMARY KEY,
    CustomerId INT,
    OrderValue DECIMAL(10, 2),
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

-- Insert data into Customer table
INSERT INTO Customer (CustomerId, CustomerName, City) VALUES
(1, 'Dhanshri Borole', 'Jalgaon'),
(2, 'Minal Wani', 'Mumbai'),
(3, 'Sarika Patil', 'Pune');


INSERT INTO [Order] (OrderId, CustomerId, OrderValue) VALUES
(101, 1, 50.00),
(102, 2, 75.50),
(103, 1, 30.25),
(104, 3, 45.75);

SELECT CustomerName, City
FROM Customer
WHERE CustomerId NOT IN (SELECT DISTINCT CustomerId FROM [Order]);



DELETE FROM Customer
WHERE CustomerId IN (
    SELECT CustomerId
    FROM [Order]
    GROUP BY CustomerId
    HAVING COALESCE(SUM(OrderValue), 0) < 1000
);



SELECT
    c.CustomerName,
    c.City,
    AVG(o.OrderValue) AS averageOrderValue
FROM
    Customer c
LEFT JOIN
    [Order] o ON c.CustomerId = o.CustomerId
GROUP BY
    c.CustomerId, c.CustomerName, c.City;



	SELECT
    o.OrderId,
    o.OrderValue,
    c.CustomerName,
    c.City
FROM
    [Order] o
JOIN
    Customer c ON o.CustomerId = c.CustomerId;