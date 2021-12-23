-- GROUPING 시 ALIAS로는 GROUP BY가 되지 않는다.
-- 배송이 완료된 주문에 대한 연도 별 합계총액 
SELECT
    YEAR(orderDate) AS year,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orders
INNER JOIN orderdetails
    USING(orderNumber)
WHERE
    status = 'Shipped'
GROUP BY
    YEAR(orderDate)

