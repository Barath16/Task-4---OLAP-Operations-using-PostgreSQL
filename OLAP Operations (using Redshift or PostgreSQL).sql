
CREATE DATABASE sales_olap;


-- Create Sales Sample Table
CREATE TABLE sales_sample (
    Product_Id     INTEGER,
    Region         VARCHAR(50),
    Date           DATE,
    Sales_Amount   NUMERIC
);



INSERT INTO sales_sample VALUES
(101, 'East',  '2025-01-05', 1200),
(102, 'West',  '2025-01-07', 1800),
(103, 'North', '2025-02-10', 900),
(101, 'South', '2025-02-15', 1500),
(102, 'East',  '2025-03-01', 1100),
(103, 'West',  '2025-03-10', 2000),
(101, 'North', '2025-04-05', 1700),
(102, 'South', '2025-04-15', 800),
(103, 'East',  '2025-05-10', 1600),
(101, 'West',  '2025-05-20', 900);



-- OLAP OPERATIONS

SELECT 
    Region,
    Product_Id,
    SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region, Product_Id
ORDER BY Region, Product_Id;



-- Rollup- To summarize sales data at different levels of granularity. Write a query to perform roll up from product to region level to view total sales by region.

SELECT 
    Region,
    Product_Id,
    SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY ROLLUP (Region, Product_Id)
ORDER BY Region, Product_Id;



--Cube - To analyze sales data from multiple dimensions simultaneously. Write a query to Explore sales data from different perspectives, such as product, region, and date.

SELECT 
    Product_Id,
    Region,
    Date,
    SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY CUBE (Product_Id, Region, Date)
ORDER BY Product_Id, Region, Date;



--Slice- To extract a subset of data based on specific criteria. Write a query to slice the data to view sales for a particular region or date range.
--Query for particular region
SELECT *
FROM sales_sample
WHERE Region = 'East';

----Query for particular date range
SELECT *
FROM sales_sample
WHERE Date BETWEEN '2025-03-01' AND '2025-05-31';



--Dice - To extract data based on multiple criteria. Write a query to view sales for specific combinations of product, region, and date

SELECT *
FROM sales_sample
WHERE Product_Id = 101
  AND Region = 'East'
  AND Date BETWEEN '2025-01-01' AND '2025-12-31';










