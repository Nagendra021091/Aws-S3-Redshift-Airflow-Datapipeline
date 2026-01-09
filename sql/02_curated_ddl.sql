CREATE TABLE curated.sales_summary AS
SELECT
  order_date,
  COUNT(*) AS total_orders,
  SUM(amount) AS total_sales
FROM staging.sales_orders
GROUP BY order_date;
