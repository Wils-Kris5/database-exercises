CREATE DATABASE if not exists adlister_db;

  CREATE TABLE IF NOT EXISTS users (
      id INT UNSIGNED NOT NULL AUTO_INCREMENT,
      email VARCHAR(60),
      password VARCHAR(50),
      PRIMARY KEY(id)
  );

CREATE TABLE IF NOT EXISTS ads (
    id INT UNSIGNED NOT NULL,
    title VARCHAR(60),
    description VARCHAR(180),
    user_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)

);

CREATE TABLE IF NOT EXISTS categories(
    id INT UNSIGNED NOT NULL,
    title VARCHAR(60),
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS ads_categories (
 ads_id INT UNSIGNED NOT NULL,
 categories_id INT UNSIGNED NOT NULL,
 FOREIGN KEY (ads_id) REFERENCES ads(id),
 FOREIGN KEY (categories_id) REFERENCES categories(id)
);




