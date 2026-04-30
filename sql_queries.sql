-- 1. Total Sales & Profit
SELECT SUM("Sales") AS total_sales,
SUM("Profit") AS total_profit
FROM orders;

-- 2. Top 5 Cities by Revenue
SELECT "City", SUM("Sales") AS revenue
FROM orders
GROUP BY "City"
ORDER BY revenue DESC
LIMIT 5;

-- 3. Top 5 Profitable Cities
SELECT "City", SUM("Profit") AS profit
FROM orders
GROUP BY "City"
ORDER BY profit DESC
LIMIT 5;

-- 4. Loss-Making Cities
SELECT "City", SUM("Profit") AS profit
FROM orders
GROUP BY "City"
HAVING SUM("Profit") < 0
ORDER BY profit;

-- 5. Discount Impact
SELECT "Discount", SUM("Profit") AS profit
FROM orders
GROUP BY "Discount"
ORDER BY "Discount";

-- 6. Category Performance
SELECT "Category",
SUM("Sales") AS total_sales,
SUM("Profit") AS total_profit
FROM orders
GROUP BY "Category"
ORDER BY total_profit DESC;

-- 7. Top Sub-Categories
SELECT "Sub-Category",
SUM("Profit") AS total_profit
FROM orders
GROUP BY "Sub-Category"
ORDER BY total_profit DESC
LIMIT 5;

-- 8. Loss-Making Sub-Categories
SELECT "Sub-Category",
SUM("Profit") AS total_profit
FROM orders
GROUP BY "Sub-Category"
ORDER BY total_profit ASC;

-- 9. Ranking Cities (Window Function)
SELECT
"City",
SUM("Profit") AS profit,
RANK() OVER (ORDER BY SUM("Profit") DESC) AS rank
FROM orders
GROUP BY "City";

-- 10. Region Analysis (CTE)
WITH regional_sales AS (
SELECT "Region",
SUM("Sales") AS total_sales,
SUM("Profit") AS total_profit
FROM orders
GROUP BY "Region"
)
SELECT *
FROM regional_sales
ORDER BY total_sales DESC;

-- 11. Profit Classification
SELECT
CASE
WHEN "Profit" < 0 THEN 'Loss'
WHEN "Profit" = 0 THEN 'Break Even'
ELSE 'Profit'
END AS profit_status,
COUNT(*) AS orders_count
FROM orders
GROUP BY profit_status;