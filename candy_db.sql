CREATE DATABASE IF NOT EXISTS candy_db;

CREATE TABLE IF NOT EXISTS types (
                                     id INT UNSIGNED NOT NULL,
                                     name VARCHAR(100) NOT NULL,
                                     PRIMARY KEY (id),
                                     description VARCHAR (180)
);

CREATE TABLE IF NOT EXISTS candies (
                                       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
                                       description VARCHAR (180),
                                       name VARCHAR(65),
                                       price_in_cents INT NOT NULL,
                                       types_id INT UNSIGNED DEFAULT NULL,
                                       PRIMARY KEY (id),
                                       FOREIGN KEY(types_id) REFERENCES types(id)
);

INSERT INTO types (name, description) VALUES
                                          ('Chewing Gum', 'Great for chewing!'),
                                          ('Chocolate', 'Great for chocolate goodness!'),
                                          ('Hard Candy', 'Don’‘t bite too hard!'),
                                          ('Gummy Candy', 'Not too hard; not too soft.');

INSERT INTO candies (name, price_in_cents, description, types_id) VALUES
                                                                     ('Doublemint Gum', 159, 'Standard chewing gum', 1),
                                                                     ('Orbit Gum', 110, 'Another standard chewing gum', 1),
                                                                     ('Hershey Bar', 210, 'Standard chocolate bar', 2),
                                                                     ('Gushers', 312, 'Nice and sour!', 4),
                                                                     ('Sour Patch Kids', 206, 'Quite sour!', 4),
                                                                     ('M&Ms', 199, 'Crunchy and chocolatey', 2);
SELECT t.name, c.name FROM candies c
JOIN types t ON c.types_id = t.id
WHERE price_in_cents > 200;


#