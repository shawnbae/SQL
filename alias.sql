-- 문자열 결합하기
-- contactLastName과 concatFirstName을 공백으로 결합하여 하나의 열로 만들기 
SELECT CONCAT_WS(" ", contactLastName, contactFirstName) FROM customers
SELECT CONCAT_WS(" ", contactLastName, contactFirstName) AS contactFullName FROM customers


