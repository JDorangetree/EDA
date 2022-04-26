# 1 creating a view
CREATE VIEW  successful AS 
SELECT product_id, order_id FROM ropstar.test_order_items
WHERE order_id IN (SELECT order_id
FROM ropstar.test_orders
WHERE (order_created_at BETWEEN '2022-01-01 00:00:00' AND '2022-01-15 23:59:59') AND
(payment_day IS NOT NULL) AND
(order_status != 'cancelled' AND order_status != 'trash') AND
seller_id != 2119);

# 2 join view vs test_product_buckets
SELECT successful.order_id, successful.product_id, test_product_buckets.bucket 
FROM successful
LEFT JOIN test_product_buckets ON successful.product_id=test_product_buckets.product_id;
