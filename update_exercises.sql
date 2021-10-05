USE codeup_test_db;

SELECT 'All albums in your table.' AS 'Exercise 1';
SELECT * FROM albums;

SELECT 'All albums released before 1980.' AS 'Exercise 2';
SELECT name FROM albums
WHERE release_date < 1980;

SELECT 'All albums by Michael Jackson.' AS 'Exercise 3';
SELECT name FROM albums
WHERE artist = 'Michael Jackson';


UPDATE albums
SET sales = sales * 10;
SELECT * FROM albums;



UPDATE albums
SET release_date = release_date - 100
WHERE release_date < 1980;



UPDATE albums
SET artist = 'Peter Jackson'
WHERE artist = 'Michael Jackson';
SELECT * FROM albums;
