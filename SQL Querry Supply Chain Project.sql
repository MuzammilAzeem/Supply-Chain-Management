-- Sales by purchase method 
SELECT `Purchase Method`, COUNT(*) AS total_sales
FROM f_sales as f
JOIN d_store as d ON f.`Store Key` = d.`Store Key`
GROUP BY `Purchase Method`
ORDER BY total_sales desc ;

-- Top 5 stores by number of sales
SELECT count(f.`Order Number`),d.`Store Name`
from d_store as d
join f_sales as f 
on d.`Store Key` = f.`Store Key`
GROUP BY d.`Store Name`
ORDER BY count(f.`Order Number`) desc 
limit 5;

-- Top 5 Regions by Sales
SELECT  `Store Region`,COUNT(`Order Number`) 
from d_store as d
join f_sales as f
on d.`Store Key` = f.`Store Key`
GROUP BY `Store Region`
ORDER BY COUNT(`Order Number`)  desc;

-- Average Sales per Customer
SELECT AVG(customer_sales.total_sales_per_customer) AS average_sales_per_customer
FROM (
  SELECT f.`Cust Key`, COUNT(*) AS total_sales_per_customer
  FROM f_sales AS f
  GROUP BY f.`Cust Key`
) AS customer_sales;

-- Sales over Time 
SELECT 
  YEAR(STR_TO_DATE(`Date`, '%Y-%m-%d')) AS sales_year,
  MONTH(STR_TO_DATE(`Date`, '%Y-%m-%d')) AS sales_month,
  concat(COUNT(*), ' M') AS total_sales
FROM f_sales
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;

-- Total inv val
Select `Product Name`, concat((Price * `Quantity on Hand`), ' M') as Total_Inv_Val
from f_inventory_adjusted;
-- Avg Cost per product
SELECT `Product Name`, round(AVG(`Cost Amount`), 2) AS average_cost
FROM f_inventory_adjusted
GROUP BY `Product Name`
ORDER BY average_cost DESC;