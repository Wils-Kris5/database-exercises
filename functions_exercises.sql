USE employees;

#Update your queries for employees whose names start and end with 'E'.
# and use concat() to combine their first and last name together as a single column
# in your results.
UPDATE  CONCAT(first_name, ' ', last_name) AS 'Employee Concat'
FROM employees;


#Find all employees born on Christmas — 842 rows.
SELECT CONCAT(first_name, ' ', last_name) AS 'Employee Concat'
FROM employees
WHERE month(birth_date) = 12 AND day(birth_date) = 25
AND last_name LIKE 'e%e';





#Find all employees hired in the 90s and born on Christmas — 362 rows.


#Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. It should be Khun Bernini.





#For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company (Hint: You might also need to use now() or curdate()).







SELECT * FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
ORDER BY first_name, last_name;

SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;


SELECT * FROM employees
WHERE last_name LIKE 'E%'

ORDER BY emp_no DESC;