SELECT * FROM ecommerce_analysis.delivery;
SELECT o.order_id,
       d.delivery_days
FROM ecommerce_analysis.order o
JOIN ecommerce_analysis.delivery d
ON o.order_id = d.order_id
WHERE d.delivery_days > 7;

SELECT o.order_status,
COUNT(o.order_id) AS total_orders
FROM ecommerce_analysis.order o
JOIN ecommerce_analysis.delivery d
ON o.order_id = d.order_id
WHERE d.delivery_days > 7
GROUP BY o.order_status;

SELECT o.payment_method,
AVG(d.delivery_days) AS avg_delivery_days
FROM ecommerce_analysis.order o
JOIN ecommerce_analysis.delivery d
ON o.order_id = d.order_id
GROUP BY o.payment_method;

SELECT
  customer_id,
  order_id,
  order_date,
  ROW_NUMBER() OVER (
    PARTITION BY customer_id
    ORDER BY order_date
  ) AS order_sequence
FROM ecommerce_analysis.order;

SELECT
  payment_method,
  COUNT(order_id) AS total_orders,
  SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
  ROUND(
    100.0 * SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END)
    / COUNT(order_id), 2
  ) AS return_percentage
FROM ecommerce_analysis.order
GROUP BY payment_method;

