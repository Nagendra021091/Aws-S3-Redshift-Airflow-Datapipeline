SELECT COUNT(*) 
FROM staging.sales_orders 
WHERE order_id IS NULL;
