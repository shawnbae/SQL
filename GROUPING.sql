-- GROUPING 시 기본적으로 SELECT보다 GROUP BY가 먼저 실행되므로 ALIAS로는 GROUP BY가 되지 않는다.
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

-- HAVING은 그룹에 대한 Filtering을 적용한다. 
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
    year
HAVING
    year > 2003;