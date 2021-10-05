USE employees;

SELECT * FROM employees
WHERE first_name IN ('Irena','Vidya','Maya');

SELECT * FROM employees WHERE last_name LIKE 'e%';

SELECT * FROM employees WHERE last_name LIKE '%q%';

#part2
SELECT * FROM employees
WHERE first_name LIKE 'Irena'
OR first_name LIKE 'Vidya'
OR first_name LIKE 'Maya';

SELECT * FROM employees
WHERE 'gender' = 'm' AND (first_name LIKE 'Irena'
    OR first_name LIKE 'Vidya'
    OR first_name LIKE 'Maya');

SELECT * FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E';

SELECT *
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E';

SELECT * FROM employees
WHERE last_name LIKE '%qu'
  AND last_name NOT LIKE '%qu%';








