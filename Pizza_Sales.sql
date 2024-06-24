PIZZA SALES SQL QUERIES
A. KPI’s
1. Total Revenue:
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;
 
2. Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales
 
3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales
 
4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
 
5. Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales
 

B. Daily Trend for Total Orders
SELECT 
    order_day, 
    total_orders
FROM (
    SELECT 
        TO_CHAR(order_date, 'Day') AS order_day, 
        COUNT(DISTINCT order_id) AS total_orders,
        EXTRACT(DOW FROM order_date) AS day_of_week
    FROM 
        pizza_sales
    GROUP BY 
        order_day, day_of_week
) AS ordered_days
ORDER BY 
    day_of_week;


Output:
 
C. Monthly Trend for Orders
SELECT 
    Month_Name, 
    total_orders
FROM (
    SELECT 
        TO_CHAR(order_date, 'Month') AS Month_Name, 
        COUNT(DISTINCT order_id) AS total_orders,
        EXTRACT(Month FROM order_date) AS Month_no
    FROM 
        pizza_sales
    GROUP BY 
         Month_no,Month_Name
) AS ordered_days
Output
 

D. % of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category
Output
 
E. % of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size
Output
 

F. Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE Extract(MONTH from order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC
Output
 
G. Top 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
limit 5 

 
H. Bottom 5 Pizzas by Revenue
SELECT  pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
limit 5
 
Output

 
I. Top 5 Pizzas by Quantity
SELECT  pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
limit 5 
Output
 
J. Bottom 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
limit 5

Output
 



K. Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
limit 5

 


L. Bottom 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
limit 5

 


NOTE
If you want to apply the pizza_category or pizza_size filters to the above queries you can use WHERE clause. Follow some of below examples
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC
Limit 5

 

