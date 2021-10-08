USE employees;



#Find all the employees with the same hire date as employee 101010 using a subquery.
# 69 Rows
# SELECT from_date FROM dept_emp WHERE emp_no = '101010';
SELECT ALL emp_no, hire_date FROM employees

WHERE hire_date IN (
    SELECT hire_date
    FROM employees
    WHERE emp_no = '101010'
    );





