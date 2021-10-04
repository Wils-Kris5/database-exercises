USE codeup_test_db;

SELECT 'All albums in your table.' AS 'Exercise 1';
SELECT * FROM albums;

SELECT 'All albums released before 1980.' AS 'Exercise 2';
SELECT name FROM albums
WHERE release_date < 1980;

SELECT 'All albums by Michael Jackson.' AS 'Exercise 3';
SELECT name FROM albums
WHERE artist = 'Michael Jackson';