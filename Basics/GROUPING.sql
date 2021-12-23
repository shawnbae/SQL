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

-- Sample Table 만들기
CREATE TABLE sales
SELECT
    productLine,
    YEAR(orderDate) orderYear,
    SUM(quantityOrdered * priceEach) orderValue
FROM
    orderDetails
        INNER JOIN
    orders USING (orderNumber)
        INNER JOIN
    products USING (productCode)
GROUP BY
    productLine ,
    YEAR(orderDate);

SELECT * FROM sales;

-- ROLLUP을 활용한 총합 구하기
SELECT 
    productLine, 
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    productline WITH ROLLUP;

-- GROUPING과 ROLLUP을 함께 활용하여 모든 GROUP에 대한 결과를 반환함
SELECT 
    orderYear,
    productLine, 
    SUM(orderValue) totalOrderValue,
    GROUPING(orderYear),
    GROUPING(productLine)
FROM
    sales
GROUP BY 
    orderYear,
    productline
WITH ROLLUP;

-- ROLLUP으로 출력되는 소계를 IF와 함께 사용하여 네이밍을 정할 수 있다.
SELECT
    IF(GROUPING(orderYear),
        'All Years',
        orderYear) orderYear,
    IF(GROUPING(productLine),
        'All Product Lines',
        productLine) productLine,
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY
    orderYear,
    productline
WITH ROLLUP;