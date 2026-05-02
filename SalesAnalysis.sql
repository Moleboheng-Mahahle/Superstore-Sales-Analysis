-- creating and using the database
CREATE DATABASE superstore;

USE superstore;

-- inspecting the data at first glance
SELECT *
FROM sales;

-- checking for null values
SELECT *
FROM sales
WHERE `Order ID` IS NULL
   OR `Sales` IS NULL;

-- checking for duplicate values   
SELECT `Order ID`, COUNT(*)
FROM sales
GROUP BY `Order ID`
HAVING COUNT(*) > 1;

-- removing duplicate values by creating a new table with no duplicates
CREATE TABLE sales_clean AS
SELECT DISTINCT *
FROM sales;

-- previewing new table without duplicates
SELECT *
FROM sales_clean;

-- EDA
SELECT DISTINCT Category
FROM sales_clean;

SELECT DISTINCT `Sub-Category`
FROM sales_clean;

SELECT DISTINCT State
FROM sales_clean;

SELECT DISTINCT `Ship Mode`
FROM sales_clean;

SELECT DISTINCT Region
FROM sales_clean;

SELECT DISTINCT City
FROM sales_clean;

SELECT 
  STR_TO_DATE(`Order Date`, '%d/%m/%Y') AS order_date, 
  MIN(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) AS earliest_date 
FROM sales_clean;

SELECT 
  STR_TO_DATE(`Order Date`, '%d/%m/%Y') AS order_date, 
  MAX(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) AS earliest_date 
FROM sales_clean;


-- MAIN QUERY
 SELECT
 -- counts
 COUNT(DISTINCT `Customer ID`) AS number_of_customers,
 COUNT(`Order ID`) AS number_of_orders,
 COUNT(DISTINCT `Product ID`) AS number_of_products,
 
 -- date formatting
 STR_TO_DATE(`Order Date`, '%d/%m/%Y') AS order_date,
DAYNAME(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) AS day_name,
MONTHNAME(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) AS month_name,
MONTH(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) AS month_number,
DAYOFMONTH(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) AS day_of_month,
YEAR(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) AS the_year,

-- categorical columns
`Ship Mode`, `Segment`, `City`, `State`, `Region`, `Category`, `Sub-Category`, 

-- aggregated numeric fields
SUM(IFNULL(Sales,0)) AS total_sales

FROM sales_clean

GROUP BY 
order_date, day_name, month_name, month_number, day_of_month, the_year, `Ship Mode`, `Segment`, `City`, `State`, `Region`, `Category`, `Sub-Category`;
 
