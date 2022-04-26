CREATE VIEW  seller_successful AS
SELECT order_seller_id, seller_id
FROM ropstar.test_orders
WHERE (order_created_at BETWEEN '2022-01-01 00:00:01' AND '2022-01-15 23:59:59') AND
(payment_day IS NOT NULL) AND
(order_status != 'cancelled' AND order_status != 'trash') AND
seller_id != 2119
;

SELECT seller_id, COUNT(order_seller_id) as orders_count FROM seller_successful
GROUP BY seller_id
ORDER BY orders_count DESC;