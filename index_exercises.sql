SHOW INDEXES FROM salaries;




SHOW TABLES;

DESCRIBE departments;

SELECT * FROM departments;

DESCRIBE dept_emp;

DESCRIBE dept_manager;

DESCRIBE employees;

DESCRIBE salaries;

DESCRIBE titles;

SELECT * FROM titles;

USE codeup_test_db;

ALTER TABLE albums ADD UNIQUE unique_artist_and_name (artist, name);

SELECT * FROM albums;

INSERT INTO albums (artist, name, release_date, sales, genre) VALUES ('Michael Jackson', 'Thriller', 1982,48.9, 'Pop, post-disco, funk, rock');
