USE employees;

SELECT DISTINCT last_name  FROM employees
ORDER BY last_name DESC
LIMIT 10;
SELECT  emp_no, salary from salaries
ORDER BY salary desc
LIMIT 5 OFFSET 45;
