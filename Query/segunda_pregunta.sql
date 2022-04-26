SELECT order_id, total_item_quantity
FROM ropstar.test_orders
WHERE (order_created_at BETWEEN '2022-01-01 00:00:00' AND '2022-01-15 23:59:59') AND
(payment_day IS NOT NULL) AND
(order_status != 'cancelled' AND order_status != 'trash') AND
seller_id != 2119
;