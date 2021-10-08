USE employees;

# MySQL allows us to JOIN tables, usually based on a foreign key relationship.
 # The process of joining will allow us to obtain query results from more than one table in a single query.
 # There are different types of joins,
 # and those different types give us a lot of flexibility in the actual query results.
           #types of joins
            # JOIN, a.k.a INNER JOIN
            # LEFT JOIN
            # RIGHT JOIN
# Syntax:
  # using JOIN to describe the table that will be joining the query
  #  ON to describe the relationship.
# tables can be aliased by using table_name as alias

# SELECT columns
# FROM table_a as A
# JOIN table_b as B ON A.id = B.fk_id;
# records from table_a and table_b will be joined based on the relationship provided between the column id in table_a
   # and the column fk_id in table_b.

# table_a in the above example, is referred to as the LEFT table of the join
    #The joined/second table mentioned, table_b in the above example, is referred to as the right table of the join.


 # ***** YOU NE

# Join or Inner Join, specifically Equijoin

# SELECT employees.emp_no, CONCAT(first_name, ' ', last_name) AS 'Full Name', salary, from_date, to_date FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no;

# SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS 'Full Name', s.salary, s.from_date, s.to_date FROM employees e JOIN salaries s ON e.emp_no = s.emp_no;

# Left Join

CREATE DATABASE join_test_db;

 USE join_test_db;

CREATE TABLE roles (
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       name VARCHAR(100) NOT NULL,
       PRIMARY KEY (id)
);
 #line 42 = role_id >>>> this is where the two tables can be JOINED



CREATE TABLE users (
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       name VARCHAR(100) NOT NULL,
       email VARCHAR(100) NOT NULL,
       role_id INT UNSIGNED DEFAULT NULL,
       PRIMARY KEY (id),
       FOREIGN KEY (role_id) REFERENCES roles (id)
            #^^^^
);

INSERT INTO roles (name) VALUES ('admin');
INSERT INTO roles (name) VALUES ('author');
INSERT INTO roles (name) VALUES ('reviewer');
INSERT INTO roles (name) VALUES ('commenter');

INSERT INTO users (name, email, role_id) VALUES
         ('bob', 'bob@example.com', 1),
         ('joe', 'joe@example.com', 2),
         ('sally', 'sally@example.com', 3),
         ('adam', 'adam@example.com', 3),
         ('jane', 'jane@example.com', null),
         ('mike', 'mike@example.com', null);

SELECT * FROM roles;
# note, first the table structure, and then in the data set.
# The foreign key relationship between the role_id in the users table and the id in the roles table.
#
#
# Next, note that the role_id in the users table allows NULL values.

#Join / Inner Join
# basic JOIN, also referred to as INNER JOIN. An example of a JOIN query on the above data set:


SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;

# note that join can be replaced with inner join for the same result
#  based on the relationship between the role_id in the users table and the id in the roles table

# For a basic join, we can expect that we will get only the results where both the left and right tables have values for their respective keys that are mentioned in the ON part of the query

#

# SELECT users.name, roles.name FROM roles JOIN users ON roles.id = users.role_id;

# Left join shows rows in the left table that have no match in the right table.
# If I say `users LEFT JOIN roles`, users is the left table and roles is the right table



# Left join:
# MySQL, go through the users table, find all the role_id values, for each role_id value, go through the roles table and try to find matching id values. When you find a match, retrieve the values of the name columns for me. (So far, that's just the same as a regular join). Also, retrieve any names from the users table (that is, the left table) that have no match in the right table, and display those too.

SELECT users.name, roles.name FROM users LEFT JOIN roles ON users.role_id = roles.id;

# Right join:
# MySQL, go through the users table, find all the role_id values, for each role_id value, go through the roles table and try to find matching id values. When you find a match, retrieve the values of the name columns for me. (So far, that's just the same as a regular join). Also, retrieve any names from the roles table (that is, the right table) that have no match in the left table, and display those too.

SELECT users.name, roles.name FROM users RIGHT JOIN roles ON users.role_id = roles.id;
# Exercises work through together
 USE employees;
#
# # a query that shows each department along with the name of the current manager for that department.
#
# # Rephrase the question in terms of the tables and columns in your database
#
 SELECT dept_name AS 'Department Name',
       CONCAT(first_name, ' ', last_name)
                 AS 'Department Manager'
FROM departments d JOIN dept_manager dm ON d.dept_no = dm.dept_no
                   JOIN employees e ON dm.emp_no = e.emp_no
WHERE to_date >= NOW() ORDER BY dept_name;

# # WHERE to_date = '9999-01-01'
# # WHERE to_date LIKE '9%'
#
# # Find the name of all departments currently managed by women.
#
SELECT dept_name AS 'Department Name',
       CONCAT(first_name, ' ', last_name)
                 AS 'Department Manager'
FROM departments d JOIN dept_manager dm ON d.dept_no = dm.dept_no
                   JOIN employees e ON dm.emp_no = e.emp_no
WHERE dm.to_date >= NOW()
  AND e.gender = 'F'
ORDER BY d.dept_name;

# # Find the current titles of employees currently working in the Customer Service department.
#
# # Start by getting all the titles for everyone in Customer Service:
#
SELECT title
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service';

# # Next, clump the titles together. I can use GROUP BY ... or I can use SELECT DISTINCT ... but if I use DISTINCT I won't be able to use COUNT later on.
#
SELECT title
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
GROUP BY t.title;

# # Now I get the count of how many people have had those titles. This would not work had I chosen to use SELECT DISTINCT
#
SELECT title, COUNT(title)
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
GROUP BY t.title;

# # Now limit it to current title-holders
#
SELECT title, COUNT(title)
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
  AND t.to_date = '9999-01-01'
GROUP BY t.title;

# # I still have too many query results, probably because not all these people are current employees of Customer Service. Let's narrow it down a little more
#
SELECT title, COUNT(title)
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
  AND t.to_date = '9999-01-01'
  AND de.to_date = '9999-01-01'
GROUP BY t.title;

 SELECT dept_name AS 'Department Name',
 CONCAT(first_name, ' ', last_name) AS 'Department Manger', salary FROM salaries s
      JOIN dept_manager dm ON s.emp_no = dm.emp_no
JOIN employees e ON  dm.emp_no = e.emp_no
JOIN departments d ON d.dept_no = dm.dept_no
 WHERE s.to_date LIKE  '9%'







