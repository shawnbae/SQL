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

-- INNER JOIN
SELECT
m.member_id,
m.name AS member,
c.committee_id,
c.name AS committee
FROM members m 
INNER JOIN committees c ON m.name = c.name;
