USE employees;

SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM departments d JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no WHERE to_date >= NOW() ORDER BY dept_name;

SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM departments d JOIN dept_manager dm ON d.dept_no = dm.dept_no
 JOIN employees e ON dm.emp_no = e.emp_no WHERE to_date >= NOW() AND e.gender = 'F'
                   ORDER BY dept_name;

SELECT title
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no
              JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service';

SELECT title
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service' AND t.to_date = '9999-01-01'
GROUP BY t.title;

    # tables are like functions in the way you dont want to overload them

  # notes
SELECT dept_name AS 'Department Name',
       CONCAT(first_name, ' ', last_name)
                 AS 'Department Manager'
FROM departments d JOIN dept_manager dm ON d.dept_no = dm.dept_no
                   JOIN employees e ON dm.emp_no = e.emp_no
WHERE to_date >= NOW() ORDER BY dept_name;

# WHERE to_date = '9999-01-01'
# WHERE to_date LIKE '9%'

# Find the name of all departments currently managed by women.

SELECT dept_name AS 'Department Name',
       CONCAT(first_name, ' ', last_name)
                 AS 'Department Manager'
FROM departments d JOIN dept_manager dm ON d.dept_no = dm.dept_no
                   JOIN employees e ON dm.emp_no = e.emp_no
WHERE dm.to_date >= NOW()
  AND e.gender = 'F'
ORDER BY d.dept_name;

# Find the current titles of employees currently working in the Customer Service department.

# Start by getting all the titles for everyone in Customer Service:

SELECT title
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service';

# Next, clump the titles together. I can use GROUP BY ... or I can use SELECT DISTINCT ... but if I use DISTINCT I won't be able to use COUNT later on.

SELECT title
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
GROUP BY t.title;

# Now I get the count of how many people have had those titles. This would not work had I chosen to use SELECT DISTINCT

SELECT title, COUNT(title)
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
GROUP BY t.title;

# Now limit it to current title-holders

SELECT title, COUNT(title)
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
  AND t.to_date = '9999-01-01'
GROUP BY t.title;

# I still have too many query results, probably because not all these people are current employees of Customer Service. Let's narrow it down a little more

SELECT title, COUNT(title)
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
  AND t.to_date = '9999-01-01'
  AND de.to_date = '9999-01-01'
GROUP BY t.title;