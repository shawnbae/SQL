-- Setting up sample tables
DROP TABLE members;
DROP TABLE committees;

CREATE TABLE members(
    member_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (member_id)
);

CREATE TABLE committees(
    committee_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (committee_id)
);

INSERT INTO members(name) VALUES('John'),('Jane'),('Mary'),('David'),('Amelia');
INSERT INTO committees(name) VALUES('John'),('Mary'),('Amelia'),('Joe');

SELECT * FROM members;
SELECT * FROM committees;

-- INNER JOIN / RIGHT JOIN / OUTER JOIN / CROSS JOIN
-- USING을 사용하여 컬럼을 매칭시킬 수 있다.
SELECT
m.member_id,
m.name AS member,
c.committee_id,
c.name AS committee
FROM members m 
INNER JOIN committees c ON m.name = c.name;

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
INNER JOIN committees c USING(name);

-- self join
-- INNER JOIN을 활용하여 self join을 수행한 예시 
SELECT 
CONCAT(m.lastName, ', ', m.firstName) AS Manager,
CONCAT(e.lastName, ', ', e.firstName) AS 'Direct report'
FROM employees e
INNER JOIN employees m ON
    m.employeeNumber = e.reportsTo
ORDER BY Manager;

-- successive row들을 비교한 예시
SELECT 
    c1.city,
    c1.customerName,
    c2.customerName
FROM
    customers c1
INNER JOIN customers c2 ON
    c1.city = c2.city
    AND c1.customerName > c2.customerName
ORDER BY
    c1.city;