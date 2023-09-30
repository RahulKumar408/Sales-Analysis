
use sales;
select * from pizza_sales;

-- find total revenue

select cast(SUM(total_price) as decimal(10,2) ) as total_revenue from pizza_sales;

-- find average amount spent per order -> total_revenue/total number of order (distinct order_id)
SELECT  CAST( SUM(total_price)/COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
AS avg_amount_per_order FROM pizza_sales;

-- total pizza sold
select SUM(quantity) as total_pizza_sold from pizza_sales;

-- total orders
select count(distinct order_id) as total_order from pizza_sales;

-- average pizza per order
select cast( ( SUM(quantity)/count(distinct order_id) ) as decimal(10,2) ) 
as avg_pizza_per_order from pizza_sales;

-- daily trend for total order
-- SELECT DAYNAME("12-05-2017"); 
SELECT DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day, 
count(distinct order_id) as total_order 
FROM pizza_sales 
GROUP BY order_day
ORDER BY total_order DESC;

-- monthly trend for total order
SELECT 	MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_month, 
count(distinct order_id) as total_order 
FROM pizza_sales 
GROUP BY order_month
ORDER BY total_order DESC;

-- percetange of sales by pizza category
select distinct pizza_category as category, 
cast( sum(total_price) as decimal(10,2)) as total_revenue,  
cast( sum(total_price)*100/(select sum(total_price) from pizza_sales) as decimal(10,2) ) as pct
from pizza_sales
group by category
order by pct desc; 

-- pct of pizza sold by pizza size
select distinct pizza_size as category, 
cast( sum(total_price) as decimal(10,2)) as total_revenue,  
cast( sum(total_price)*100/(select sum(total_price) from pizza_sales) as decimal(10,2) ) as pct
from pizza_sales
group by category
order by pct desc; 

--  total pizza sold by pizza category
select distinct pizza_category as category, sum(quantity) as total_pizza_sold
from pizza_sales
group by category
order by total_pizza_sold desc; 


-- top 5 pizza by revenue
SELECT distinct pizza_name, cast(SUM(total_price) as decimal(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
limit 5;

-- bottom 5 pizza by revenue
SELECT distinct pizza_name, cast(SUM(total_price) as decimal(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue
limit 5;

-- busy time in a day
SELECT order_time, SUM(quantity) AS total_pizza_sold, 
CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY order_time
HAVING total_pizza_sold > 20
ORDER BY order_time;

-- less busy time range in a day 
SELECT order_time, SUM(quantity) AS total_pizza_sold, 
CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY order_time
HAVING total_pizza_sold < 2
ORDER BY order_time
LIMIT 15;






 



