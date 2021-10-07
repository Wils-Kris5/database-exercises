Use employees;


SELECT DISTINCT title
FROM titles;

#find just the unique last names that start and end with 'E' using GROUP BY
 SELECT  last_name FROM employees
 WHERE last_name like 'e%e'
GROUP BY last_name;

SELECT DISTINCT first_name, last_name FROM employees
WHERE last_name  LIKE 'e%e'
GROUP BY first_name, last_name;

SELECT DISTINCT first_name, last_name, COUNT(*)
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
GROUP BY first_name, last_name;

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

SELECT DISTINCT COUNT(*), last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY last_name;

SELECT COUNT(*) AS 'COUNT', gender
FROM employees
WHERE first_name = 'Irena' OR first_name  = 'Vidya' OR first_name = 'Maya'

GROUP BY 'COUNT', gender, gender = 'M' AND 'COUNT', gender = 'F';

