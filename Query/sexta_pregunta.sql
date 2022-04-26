CREATE VIEW  seller_successful AS
SELECT order_seller_id, seller_id
FROM ropstar.test_orders
WHERE (order_created_at BETWEEN '2022-01-01 00:00:01' AND '2022-01-15 23:59:59') AND
(payment_day IS NOT NULL) AND
(order_status != 'cancelled' AND order_status != 'trash') AND
seller_id != 2119
;

CREATE VIEW  view_seller_succesful AS
SELECT seller_successful.seller_id, test_orders.order_created_at, 
test_orders.payment_day FROM seller_successful
LEFT JOIN test_orders ON seller_successful.order_seller_id=test_orders.order_seller_id;

CREATE VIEW  week_payment AS
SELECT seller_id, WEEK(payment_day, 5) as week_number FROM view_seller_succesful;

CREATE VIEW  Total AS
SELECT seller_id,
COUNT(CASE WHEN week_number=0 THEN seller_id ELSE NULL END) AS Week_0,
COUNT(CASE WHEN week_number=1 THEN seller_id ELSE NULL END) AS Week_1,
COUNT(CASE WHEN week_number=2 THEN seller_id ELSE NULL END) AS Week_2,
SUM(seller_id) As Total
FROM week_payment
GROUP BY seller_id
ORDER BY seller_id;

SELECT seller_id, Week_0, Week_1, Week_2, (Week_0 + Week_1 + Week_2) AS Total FROM Total
ORDER BY Total DESC
LIMIT 10
