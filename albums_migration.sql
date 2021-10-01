USE codeup_test_db;
 DROP TABLE IF EXISTS albums;
CREATE TABLE albums (
                        id INT UNSIGNED NOT NULL AUTO_INCREMENT,
                        artist VARCHAR(100),
                        name VARCHAR(100),
                        release_date SMALLINT UNSIGNED,
                       sales FLOAT(6, 2),
                        genre VARCHAR(100),
                        PRIMARY KEY (id)
);

/*
6 = THE NUMBER OF DIGITS
2 =  NUMBER OF DECIMALS / AFTER THE DECIMAL
 */