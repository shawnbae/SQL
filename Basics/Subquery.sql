-- 2003년에 조회된 주문번호 총계 테이블을 서브쿼리로 불러와 테이블을 만든 예시
SELECT
    productName, sales
FROM
    (SELECT
        productCode,
        ROUND(SUM(quantityOrdered * priceEach)) sales
    FROM
        orderdetails
    INNER JOIN orders USING (orderNumber)
    WHERE
        YEAR(shippedDate) = 2003
    GROUP BY productCode
    ORDER BY sales DESC
    LIMIT 5) top5products2003
INNER JOIN
    products USING (productCode);

-- CASE WHEN을 Subquery로 활용하는 방법
SELECT
    customerNumber,
    ROUND(SUM(quantityOrdered * priceEach)) sales,
    (CASE
        WHEN SUM(quantityOrdered * priceEach) < 10000 THEN 'Silver'
        WHEN SUM(quantityOrdered * priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
        WHEN SUM(quantityOrdered * priceEach) > 100000 THEN 'Platinum'
    END) customerGroup
FROM
    orderdetails
        INNER JOIN orders USING(orderNumber)
WHERE
    YEAR(shippedDate) = 2003
GROUP BY customerNumber;

-- 두 가지를 혼합하여 사용하는 경우
SELECT
    customerGroup,
    COUNT(cg.customerGroup) AS groupCount
FROM
    (SELECT
        customerNumber,
            ROUND(SUM(quantityOrdered * priceEach)) sales,
            (CASE
                WHEN SUM(quantityOrdered * priceEach) < 10000 THEN 'Silver'
                WHEN SUM(quantityOrdered * priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
                WHEN SUM(quantityOrdered * priceEach) > 100000 THEN 'Platinum'
            END) customerGroup
    FROM
        orderdetails
    INNER JOIN orders USING(orderNumber)
    WHERE
        YEAR(shippedDate) = 2003
    GROUP BY customerNumber) cg
GROUP BY cg.customerGroup;

-- EXISTS 사용하기
-- true / false를 반환하는 함수로, 조건에 일치하는 경우를 찾아낼 때 서브쿼리와 함께 사용한다.
SELECT
    customerNumber,
    customerName
FROM
    customers
WHERE
    NOT EXISTS(
        SELECT
            1
        FROM
            orders
        WHERE
            orders.customernumber = customers.customerNumber);

-- 데이터 업데이트 시에도 활용할 수 있다.
UPDATE employees
SET extension = CONCAT(extension, '1')
WHERE
    EXISTS(
        SELECT
            1
        FROM
            offices
        WHERE
            city = 'San Francisco'
                AND offices.officeCode = employees.officeCode);