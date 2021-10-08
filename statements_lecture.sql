# ================================= INSERT STATEMENTS

# Inserting a record

USE codeup_test_db;

show tables;

DROP TABLE IF EXISTS quotes;

CREATE TABLE quotes (
                        id INT UNSIGNED NOT NULL AUTO_INCREMENT,
                        author_first_name VARCHAR(50) DEFAULT 'NONE',
                        author_last_name  VARCHAR(100) NOT NULL,
                        content TEXT NOT NULL,
                        PRIMARY KEY (id)
);

DESCRIBE quotes;

INSERT INTO quotes (author_last_name, content)
VALUES ('Reich', 'Do your best!!');

SELECT * FROM quotes;







# INSERT INTO quotes (author_first_name, author_last_name, content) VALUES ('Casey', 'Edwards', 'To be or not to be.');


# INSERT INTO quotes (author_first_name, author_last_name, content) VALUES ('Justin', 'Reich', 'Do your best while you can.');

# Viewing all records on a table

SELECT * FROM quotes;

# Inserting Multiple Records

# INSERT INTO quotes (author_first_name, author_last_name, content) VALUES
#     ('Leslie', 'Knope', 'We need to remember what''s important in life: friends, waffles, work.'),
#     ('Ron', 'Swanson', 'You had me at meat \'tornado\'.'),
#     ('April', 'Ludgate', 'What?');

# Inserting empty columns
# INSERT INTO quotes (author_last_name, content) VALUES ('last', 'some content');
# INSERT INTO quotes (author_first_name, content) VALUES ('first', 'some content');
# INSERT INTO quotes (author_first_name, author_last_name) VALUES ('first', 'last');

# Inserting strings with escaped quotes

# Creating a seeder file...






# ================================= SELECT STATEMENTS

# Select All

SELECT * FROM albums;

# Select Specific Columns

SELECT id, name, artist FROM albums;

# Where clause

show tables;

SELECT id, name, artist FROM albums
WHERE release_date < 1980;



# Operators


# Miscellaneous Output
SELECT 'Migrating albums table' AS Migration;

SELECT 'Seeding albums' AS Seeder;









# ================================= UPDATE STATEMENTS (UPDATE)

# create books migration (table)
# The table books should have the following columns...
# id
# title
# author
# date_published
# description
# bestseller_weeks

USE codeup_test_db;

DROP TABLE IF EXISTS books;

CREATE TABLE IF NOT EXISTS books (
                                     id INT UNSIGNED NOT NULL AUTO_INCREMENT,
                                     title VARCHAR(255) NOT NULL,
                                     author VARCHAR(100) NOT NULL DEFAULT 'Unknown',
                                     date_published DATE NOT NULL,
                                     description TEXT,
                                     bestseller_weeks INT UNSIGNED NOT NULL DEFAULT 0,
                                     PRIMARY KEY (id)
);


# Books Seeder

INSERT INTO books (title, author, date_published, description, bestseller_weeks)
VALUES
    ('To Kill a Mockingbird', 'Harper Lee', '1960-07-11', 'This is a book about birds.', 0),
    ('The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10', 'This is a book about a great thing.', 10),
    ('Harry Potter and the Sorcerer`s Stone', 'J.K. Rowling', '1997-06-26', 'This is a book about wizards.', 70),
    ('The Hobbit', 'J.R.R. Tolkien', '1937-07-21', 'This is a book about hobbits.', 5);

SELECT * FROM books;

# Update values **Test alterations first with SELECT statements**
# Updating a single record
# (a record with an ID of 2 should have an author of 'bob')
SELECT * FROM books;

SELECT * FROM books
WHERE id = 2;

UPDATE books
SET author = 'Bob'
WHERE id = 2;


UPDATE books
SET author = 'bob'
WHERE id = 2;



# Update single record multiple columns
# (change author to 'Steve' and title to 'The Facts of Life' for the record with id of 1)

UPDATE books
SET author = 'Steve', title = 'The Facts of Life'
WHERE id = 1;

SELECT * FROM books;




# Update single value in multiple records
# (for all records with an id greater than 3, change the author to 'George')

SELECT * FROM books
WHERE id > 2;

UPDATE books
SET author = 'George'
WHERE id > 2;


# Leaving off Where Clause (DANGEROUS!!!)

# UPDATE books
# SET author = 'George';

SELECT * FROM books;

# ================================= DELETE STATEMENTS

# Delete values  **Test deletes first with SELECT statements**
# 1) Always write your WHERE condition first.
# 2) Whenever possible, DELETE using the table's primary key.
# (delete record with an id of 4)


SELECT * FROM books
WHERE id = 4;


DELETE FROM books
WHERE id = 4;

SELECT * FROM books;


# Truncate

TRUNCATE TABLE books;
