-- 문자열 결합하기
-- contactLastName과 concatFirstName을 공백으로 결합하여 하나의 열로 만들기 
SELECT CONCAT_WS(" ", contactLastName, contactFirstName) FROM customers
SELECT CONCAT_WS(" ", contactLastName, contactFirstName) AS contactFullName FROM customers

-- MySQL은 아래와 같은 축약어도 사용이 가능하다.
SELECT orderNumber `Order no.`, SUM(priceEach * quantityOrdered) total FROM orderdetails GROUP BY `Order no.` HAVING total > 60000;

-- Table Alias
SELECT 
    customerName, COUNT(o.orderNumber) total
FROM customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY
    customerName
ORDER BY
    total DESC;