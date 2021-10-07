# GROUP BY LECTURE

# The "GROUP BY" clause is used to aggregate a table into various groups of shared characteristics.
#
# Grouping data is often accompanied with the use of aggregate functions to derive additional information
# about the various groupings.
#
# Most common aggregate functions are:
#
#     MIN()
#     MAX()
#     SUM()
#     AVG()
#     COUNT()
#
# One or multiple columns may be grouped together.
#
# No table columns may exist in a SELECT clause that are not contained in the GROUP BY clause.
#
#     The GROUP BY clause is after an optional where clause and before an optional order by clause.
#
#     The order of a result set may be by an aggregate column but an aggregate column cannot be referenced in a where clause.
#
# A having clause is a way to use aggregate results as if in a where clause.

use employees;

# --------- Grouping by a single column

select * from titles;

SELECT DISTINCT title from titles;

# How many have each title?
SELECT title, COUNT(*) FROM titles
WHERE to_date > NOW()
GROUP BY title;


SELECT * FROM employees;


SELECT gender FROM employees; # all genders of all employees listed

SELECT DISTINCT gender from employees; # all distinct genders in company

SELECT gender FROM employees # creating groups of employees by gender
GROUP BY gender;

SELECT gender, COUNT(*) from employees # how many are in each gender group?
GROUP BY gender;


# How many people share the same hire date?
SELECT hire_date, COUNT(*) AS `No of Employees Hired` FROM employees
GROUP BY hire_date
ORDER BY COUNT(*) DESC;


SELECT * FROM salaries;
# How many salaries are at a given amount?

SELECT salary, COUNT(*) FROM salaries
GROUP BY salary
ORDER BY COUNT(*) DESC;


# --------- Grouping by multiple columns


# How many employees share the same birthday?
SELECT birth_date, COUNT(*) FROM employees
GROUP BY birth_date;











# How many male and female employees share the same birthday?
SELECT gender, birth_date, COUNT(*) from employees
GROUP BY gender, birth_date ORDER BY birth_date;





SELECT first_name, last_name FROM employees
GROUP BY first_name, last_name;

SELECT DISTINCT first_name, last_name FROM employees;

# COUNT function

# Find total number of employees
SELECT COUNT(*) FROM employees;

# Find the most common name
SELECT first_name, last_name, COUNT(*) FROM employees
GROUP BY first_name, last_name;

SELECT first_name, last_name, COUNT(*) FROM employees
GROUP BY first_name, last_name
ORDER BY COUNT(*) DESC;

# Find the most common female and male name
SELECT first_name, last_name, gender, COUNT(*) FROM employees
GROUP BY first_name, last_name, gender
ORDER BY COUNT(*) desc;



# =========== AGGREGATE FUNCTIONS

# Find the most common name
# Find the most common female and male name
# Find total number of female and male employees
# Find the highest employee number of each unique first name
# Select the first and last hire date for each first name
# Find the minimum, maximum, average, and total number of salaries


# Find the min, max, avg, and count of each employee's salaries
SELECT emp_no, MIN(salary), MAX(salary), AVG(salary), COUNT(*) FROM salaries
GROUP BY emp_no;




















# Find total number of female and male employees
SELECT gender, COUNT(*) FROM employees
GROUP BY gender;

# MIN and MAX
# Select the first and last hire date for each first name
SELECT first_name, MIN(hire_date) as 'First Hired', MAX(hire_date) as 'Last Hired' FROM employees
GROUP BY first_name;

DESCRIBE salaries;

# Find the minimum, maximum, average, and total number of salaries
SELECT COUNT(salary), MIN(salary), MAX(salary), AVG(salary), SUM(salary) FROM salaries;

# Find the min, max, avg, total, and count of each employee's salaries
SELECT emp_no, COUNT(salary), MIN(salary), MAX(salary), AVG(salary), SUM(salary) FROM salaries
GROUP BY emp_no
ORDER BY MAX(salary) DESC;
