-- 1) Create Database

 	create database [TechShop];
	use [TechShop];


-- 2) DATA DEFINATION LANGUAGE (DDL)
    -->

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(10) UNIQUE,
    Address VARCHAR(255)
);


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description TEXT,
    Price INT
);

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
TotalAmount INT,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);



CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);  

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- DATA MANIPULATION LANGUAGE(DML)
--> a) Inserting 10 records in each table


INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES (1,'Pratik','Wani','pratikwani@email.com','9022182556','123 Main Nsk'),
(2,'JP','Duminy','jpduminy@email.com','8765434567','456 Oak Pune'),
(3,'Vikas','Thakre','VikasThakre@email.com','9022182516','123 Main Thane'),
(4,'John','Peter','johnpeter@email.com','9033211234','901 Old St Pune'),
(5,'Rushi','Joshi','rushijoshi@email.com','9089782556','Indira stop chennai'),
(6,'Virat','Sharma','viratsharma@email.com','8765434877','Peth Road Pune'),
(7,'Pat','Singh','patsingh@email.com','8766182556','554 Main Street nsk'),
(8,'Pratik','Sharma','pratiksharma@email.com','8765441067', 'CAQE Gate Pune'),
(9,'Rushi','Thorat','rushithorat@email.com','7843982556','College Road Bhopal'),
(10,'MS','Dhoni', 'msdhoni@email.com','8765434568', '564 Old Street Ranchi');

select * from Customers;

INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES(10,'Laptop','Model 101 High-End Laptop',80000),
(20,'Smartphone','Latest smartphone model UJ101',60000),
(30,'Washing Machine','LG Washing Machine with 25 Modes',30000),
(40,'Fan', 'Multi Light White Color Fan',8000),
(50,'Table Lamp','Study Table Lamp 60watt',2000),
(60,'Hair Dryer','Cool and Hot air Hair Dryer',1000),
(70,'Fruit Grinder','Brand Portable Rechargable Grinder',3000),
(80,'Television','Ultra 4k Samsung Television',100000),
(90,'Fridge','Double Door Fridge',80000),
(100,'Iron','Latest Lightwight LG Iron',2000);

select * from Products;

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES(101,1,'2023-01-15',80000 ),(102,5,'2023-02-10',30000),
(103,6,'2023-02-15',2000 ),(104,4,'2023-03-10',100000),
(105,3,'2023-03-18',160000 ),(106,2,'2023-04-20',9000),
(107,10,'2023-07-12',60000 ),(108,7,'2023-08-22',1000),
(109,9,'2023-09-01',120000 ),(110,8,'2023-11-15',2000);

select * from Orders;

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES (1001,101,90,1),(1002,102,30,1),(1003,103,100,1),(1004,104,80,1),
(1005,105,90,2),(1006,106,70,3 ),(1007,107,20,1),(1008,108,60,1),(1009,109,20,2),(1010,110,50,1);

select * from OrderDetails;

INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate)
VALUES(201,10,20,20),(202,20,50,53),(203,30,9,10),(204,40,50,50),(205,50,1,2),
(206,60,70,71),(207,70,23,26),(208,80,13,14),(209,90,17,20),(210,100,19,20);

select * from Inventory;

--> b) Basic SQL Queries
--1) 
SELECT CONCAT([FirstName],' ',[LastName]) AS Name, [Email] FROM [dbo].[Customers];

--2)
SELECT Customers.[FirstName],Customers.[LastName],Orders.[OrderID],Orders.[OrderDate],Orders.[TotalAmount] 
from Customers inner join Orders 
on Customers.[CustomerID]=Orders.[CustomerID];

--3)
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
(11, 'Jack', 'Potter', 'jackpotter@email.com', '1236547895', 'Late Street Banglor');

--4)
UPDATE [dbo].[Products] SET [Price]=([Price]*1.1);
SELECT * FROM [dbo].[Products];

--5)
-- HERE I USED ON DELETE CASCADE SO REFERENTIAL INTEGRITY WILL BE MAINTAIN AUTOMATICALLY
DECLARE @OrderId INT;
SET @OrderId=102;
DELETE FROM [dbo].[Orders] WHERE [OrderID]=@OrderId;

SELECT * FROM [dbo].[Orders];
SELECT * FROM [dbo].[OrderDetails];

--6)
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES (111, 10, '2023-11-17', 60000);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES (1011, 111, 20, 1);
SELECT * FROM [dbo].[Orders];
SELECT * FROM [dbo].[OrderDetails];

--7)
DECLARE @CID INT;
SET @CID=1;
DECLARE @CFNAME VARCHAR(50);
SET @CFNAME='KUNAL';
DECLARE @CLNAME VARCHAR(50);
SET @CLNAME='DOGRA';
DECLARE @CEMAIL VARCHAR(50);
SET @CEMAIL='kunaldogra@email.com';
DECLARE @CPHONE VARCHAR(50);
SET @CPHONE='2323235656';
DECLARE @CADD VARCHAR(50);
SET @CADD='TIDKE COLONY NSK';

UPDATE [dbo].[Customers]  
SET [FirstName]=@CFNAME,[LastName]=@CLNAME,[Email]=@CEMAIL,[Phone]=@CPHONE,[Address]=@CADD
WHERE [CustomerID]=@CID;

select * from Customers;

--8)
UPDATE ORDERS 
SET [TotalAmount] =(SELECT SUM([Quantity]*Products.[Price]) FROM [dbo].[OrderDetails] INNER JOIN [dbo].[Products]
ON OrderDetails.ProductID=Products.ProductID
WHERE Orders.OrderID=OrderDetails.OrderID
);

--9)
-- HERE I USED ON DELETE CASCADE SO REFERENTIAL INTEGRITY WILL BE MAINTAIN AUTOMATICALLY
DECLARE @CusID INT; SET @CusID=9;
DELETE FROM Orders WHERE [CustomerID]=@CusID;

 
SELECT * FROM [dbo].[OrderDetails];


--10)
INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES (11, 'E-Toothbrush', 'Oral-B kids Electric Toothbrush', 1500);

--11)
ALTER TABLE Orders ADD Stat VARCHAR(10) DEFAULT 'PENDING';
DECLARE @O_ID INT;
SET @O_ID=101;
DECLARE @O_STATUS VARCHAR(10);
SET @O_STATUS='SHIPPED';
UPDATE [dbo].[Orders] SET [Stat]=@O_STATUS
WHERE [OrderID]=@O_ID;

--12)
ALTER TABLE [dbo].[Customers] ADD Total_orders INT DEFAULT 0;

UPDATE [dbo].[Customers] SET [Total_orders]=(SELECT COUNT(*) FROM Orders GROUP BY [CustomerID] having Customers.CustomerID=Orders.CustomerID)

select * from Customers;

--4) JOINS 

--1)
SELECT CONCAT(Customers.[FirstName],' ',Customers.[LastName]) AS Name, 
Customers.[Email],Customers.[Phone],Customers.[Address],
Orders.[OrderID],Orders.[OrderDate],Orders.[TotalAmount] FROM [dbo].[Customers] INNER JOIN [dbo].[Orders]
ON Customers.CustomerID=Orders.CustomerID;

--2)
SELECT Products.[ProductName],SUM(OrderDetails.[Quantity]*Products.[Price]) AS Revenue 
FROM [dbo].[Products] INNER JOIN [dbo].[OrderDetails] 
ON [dbo].[OrderDetails].[ProductID]=[dbo].[Products].[ProductID]  GROUP BY [Products].ProductName;

--3)
SELECT DISTINCT CONCAT(Customers.[FirstName],' ',Customers.[LastName]) AS Name, 
Customers.[Email],Customers.[Phone],Customers.[Address] FROM [dbo].[Customers] INNER JOIN [dbo].[Orders]
ON [dbo].[Orders].[CustomerID]=[dbo].[Customers].[CustomerID];

--4)

SELECT [dbo].[Products].[ProductName], (SUM([dbo].[OrderDetails].[Quantity])) AS Quantity_Order
FROM [dbo].[Products]  INNER JOIN [dbo].[OrderDetails]
ON [dbo].[Products].ProductID = [dbo].[OrderDetails].ProductID
GROUP BY [dbo].[Products].[ProductName]
ORDER BY Quantity_Order DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;

--5)
ALTER TABLE [dbo].[OrderDetails] ADD Category VARCHAR(20);
-- HERE TAKING 2 CATEGORIES AS ELECTRIC AND ELECTRONIC
UPDATE [dbo].[OrderDetails] SET Category='ELECTRIC'
WHERE [OrderDetailID] IN(1001,1005,1007,1010,1011);
UPDATE [dbo].[OrderDetails] SET Category='ELECTRONIC'
WHERE [OrderDetailID] IN(1004,1003,1006,1008);

SELECT [dbo].[Products].[ProductName],[dbo].[Products].[Description], [dbo].[OrderDetails].[Category]
FROM [dbo].[Products] INNER JOIN [dbo].[OrderDetails] ON [dbo].[Products].ProductID=[dbo].[OrderDetails].ProductID;

--6)
SELECT CONCAT(Customers.[FirstName],' ',Customers.[LastName]) AS Name , AVG([dbo].[Orders].[TotalAmount]) AS AVG_ORDER_VALUE
FROM [dbo].[Customers] LEFT JOIN [dbo].[Orders] ON [dbo].[Customers].CustomerID=[dbo].[Orders].CustomerID
GROUP BY FirstName,LASTNAME;

--7)
SELECT  CONCAT(Customers.[FirstName],' ',Customers.[LastName]) AS Name , Customers.[Email],Customers.[Phone],
[dbo].[Orders].OrderID,[dbo].[Orders].TotalAmount AS TOTAL_REVENUE FROM [dbo].[Customers] INNER JOIN [dbo].[Orders]
ON [dbo].[Customers].CustomerID=[dbo].[Orders].CustomerID WHERE [dbo].[Orders].TotalAmount=(SELECT MAX(TotalAmount) FROM [dbo].[Orders]);

--8)
SELECT Products.ProductName,SUM([dbo].[OrderDetails].Quantity) AS TOTAL_ORDERS FROM [dbo].[OrderDetails] RIGHT JOIN [dbo].[Products]
ON [dbo].[OrderDetails].ProductID=[dbo].[Products].ProductID GROUP BY Products.ProductName;

--9)
DECLARE @P_NAME VARCHAR(10); SET @P_NAME='FRIDGE';
SELECT CONCAT(Customers.[FirstName],' ',Customers.[LastName]) AS Name
FROM Customers
WHERE [CustomerID] IN(SELECT [CustomerID] FROM [dbo].[Orders] WHERE [OrderID] IN(
SELECT [dbo].[OrderDetails].OrderID 
FROM [dbo].[OrderDetails] INNER JOIN [dbo].[Products]
ON  [dbo].[OrderDetails].ProductID=[dbo].[Products].ProductID
WHERE [dbo].[Products].[ProductName]=@P_NAME));

--10)
DECLARE @STARTDATE DATE; SET @STARTDATE='2023-02-14';
DECLARE @ENDDATE DATE; SET @ENDDATE='2023-10-21';
SELECT [OrderID],[TotalAmount] AS TOTAL_REVENUE  FROM [dbo].[Orders]
WHERE [OrderDate] BETWEEN @STARTDATE AND @ENDDATE;

--5) AGGREGATE FUNCTION

--1)
SELECT * FROM Customers WHERE [Total_orders] IS NULL;

--2)
SELECT COUNT(*) AS TOTAL_NO_OF_PRODUCTS FROM Products;

--3)
SELECT SUM([TotalAmount]) AS TOTAL_REVENUE_TECHSHOP FROM [dbo].[Orders];

--4)
DECLARE @CAT VARCHAR(10); SET @CAT ='ELECTRIC';
DECLARE @TOTAL_PRODUCTS_ORDER INT; SET @TOTAL_PRODUCTS_ORDER=(SELECT SUM([Quantity]) FROM [dbo].[OrderDetails]);
SELECT (@TOTAL_PRODUCTS_ORDER/SUM([Quantity])) FROM [dbo].[OrderDetails]
GROUP BY [Category];

--5)
DECLARE @CUS_ID INT; SET @CUS_ID=8;
SELECT [CustomerID], SUM([TotalAmount]) AS TOTAL_REVENUE FROM Orders 
GROUP BY [CustomerID]  HAVING [CustomerID]=@CUS_ID;

--6)
SELECT TOP(1) Customers.[FirstName],Customers.[LastName],COUNT([dbo].[Orders].[CustomerID]) AS NO_OF_ORDERS
FROM [dbo].[Customers] INNER JOIN [dbo].[Orders] ON [dbo].[Customers].CustomerID=[dbo].[Orders].CustomerID
GROUP BY Customers.[FirstName],Customers.[LastName]
ORDER BY NO_OF_ORDERS DESC;

--7)
SELECT CONCAT(Customers.[FirstName],' ',Customers.[LastName]) AS Name , AVG([dbo].[Orders].[TotalAmount]) AS AVG_ORDER_VALUE
FROM [dbo].[Customers] LEFT JOIN [dbo].[Orders] ON [dbo].[Customers].CustomerID=[dbo].[Orders].CustomerID
GROUP BY FirstName,LASTNAME;


--8)
SELECT Customers.[FirstName],Customers.LastName,SUM(Orders.TotalAmount) AS TOTAL_SPENDINGS FROM [dbo].[Customers] INNER JOIN [dbo].[Orders]
ON [dbo].[Customers].CustomerID=[dbo].[Orders].CustomerID
GROUP BY Customers.[FirstName],Customers.LastName;

--9)
SELECT (SUM([dbo].[Orders].[TotalAmount])/SUM([dbo].[OrderDetails].Quantity)) AS AVG_ORDER_VALUE FROM [dbo].[Orders] INNER JOIN [dbo].[OrderDetails]
ON [dbo].[Orders].OrderID=[dbo].[OrderDetails].OrderID;

--10)
SELECT Customers.[FirstName],Customers.[LastName],COUNT([dbo].[Orders].[CustomerID]) AS NO_OF_ORDERS
FROM [dbo].[Customers] INNER JOIN [dbo].[Orders]
ON [dbo].[Customers].CustomerID=[dbo].[Orders].CustomerID
GROUP BY Customers.[FirstName],Customers.[LastName];

