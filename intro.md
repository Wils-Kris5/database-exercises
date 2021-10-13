# Intro to MySQL

Some clarification regarding terminology. SQL is a language called Structured Query Language (SQL for short). Some people pronounce it "sequel", but many old-timers stick to the "ess-kew-ell" pronunciation and that's how I will be pronouncing it. A sequel is part two of a movie, SQL is structured query language.

MySQL is not a language, it's a relational database management system. You use SQL to interact with MySQL. Likewise you use SQL to interact with other implementations of RDBMS, such as Oracle SQL or PostgreSQL.

First things first, try
```
mysql --version
```
to make sure we have it working our systems.

Most of you should have installed yours using the Codeup setup script at the beginning of the course. If that is the case, then you should be able to type a command ```mysql.server status``` to see if the server is running. If it is not, you should type ```mysql.server start```, then try ```mysql.server status``` again to see the difference. Be sure and make sure your MySQL server is running if you encounter db communication errors. You can't interact with MySQL if the MySQL server is not running.

If you have done a manual download and install of MySQL, you should instead use the mysqladmin command line tool. Do
```
mysqladmin -u root -p status
Enter password:
Uptime: 233  Threads: 2  Questions: 2  Slow queries: 0  Opens: 115  Flush tables: 3  Open tables: 36  Queries per second avg: 0.008
```

In a few lessons' time, we will be setting up IntelliJ to interact with our MySQL server, but until then we will be using the joyous MySQL command line tool.

If you followed the Codeup setup script you should be able to log in as the root user with the password ```codeup```. So do

```
mysql -u root -p
```
This means "I want to log in to the MySQl server with the user (-u) root and a password (-p)"

You should now be in the MySQL command-line client. This is a way to communicate with the MySQL server. This is a client-server communication.

Once you are in, you should be able to type in some commands such as ```help```. This shows you some general commands you can issue to the mysql CLI client. Then there is ```help contents```, which shows the various categories of commands that can be issued to the MySQL server itself. You can find lists of commands in each category, e.g. ```help Data Definition``` shows a comprehensive list of all data definition commands, and you can select any particular one to see its help page, e.g., ```help DROP DATABASE``` shows information on the drop database command.

Eventually, we will be using our MySQL server to store databases full of tabular data. For example

I have obtained a set of baseball statistics from [seanlahman.com](https://raw.githubusercontent.com/WebucatorTraining/lahman-baseball-mysql/master/lahman-mysql-dump.sql) and inserted them into my MySQL server. I use these now

## Databases and tables - quick intro

Notice that on the server, data is organized into databases, and within databases into tables. So,

```
SHOW DATABASES;
```
```
USE lahmansbaseballdb;
SHOW TABLES;
SELECT * FROM parks;
```

This is your standard tabular representation of data. You can also use the "ego" (extended GO) flag for vertical representation.

```
select * from people\G;
```
This is good for data that is not easily represented on your screen in proper table form.

You can leave the mysql client with the keywords ```exit``` or ```quit``` or the abbreviation `\q`.

## Database Users

The MySQL server, like MacOS or like a Linux OS, is a multi-user environment. It is understood that multiple users may be interacting with a MySQL server, often at the same time, and it's set up to handle that.

Right now, we are logged in as the all-powerful root user, which is very common when you are just messing around in your private machine, but is actually not best practice.

Users can also be logical constructs such as applications.

Notice users in MySQL are always defined by a username and a host, which is the place the user is allowed to connect from. This is both for security and in order to allow for different users connecting from different places but with the same username.

So, let's create some imaginary users. We're going to be using strictly localhost in this class, so all our users will be username@localhost.

```
 CREATE USER 'sofia'@'localhost' IDENTIFIED BY 'password';
```
```
 SELECT user, host FROM mysql.user;
```

Now you can see that sofia exists as a user connecting from localhost. However, sofia cannot do anything yet, as sofia has no privileges granted on the server.

The highest order of privileges we can grant is everything on all databases.

```
GRANT ALL ON *.* TO 'sofia'@'localhost';
```

Sofia is now pretty much all-powerful and can do anything across all databases stored on this particular server.

We granted all privileges on all tables in all databases. Remember, data in MySQL is stored in databases, and within the databases, in tables. You can control very specifically what each user is allowed to do.

If you want to grant read privileges, that is done by granting the ability to SELECT. So let's create a user that can only read from the baseball database.

```
CREATE USER 'youssef'@'localhost' IDENTIFIED BY 'password';
```
```
GRANT SELECT ON lahmansbaseballdb.* TO 'youssef'@'localhost';
```

We can also give users privileges only on specific tables. If a user should only be messing with a particular table, then that is perfectly possible.

```
SHOW TABLES IN lahmansbaseballdb;
```
Notice to show the tables in the baseball db I can either do the command above, or to

```
USE lahmansbaseballdb;
```
```
 SHOW TABLES;
```

So let's say we want our next user to be able to modify data as well as reading it, but only on the pitchers. We could do something like

```
CREATE USER 'alysha'@'localhost' IDENTIFIED BY 'password';
```
Notice when we do not grant anything, the user just has 'usage';
```
SHOW GRANTS FOR 'alysha'@'localhost';
+--------------------------------------------+
| Grants for alysha@localhost                |
+--------------------------------------------+
| GRANT USAGE ON *.* TO `alysha`@`localhost` |
+--------------------------------------------+
1 row in set (0.00 sec)
```
Let's grant alysha some privileges on the pitchers table
```
GRANT CREATE, ALTER, INSERT, DROP ON lahmansbaseballdb.pitchers TO 'alysha'@'localhost';
```
And now notice the show grants command yields different results.
```
SHOW GRANTS FOR 'alysha'@'localhost';
+---------------------------------------------------------------------------------------------+
| Grants for alysha@localhost                                                                 |
+---------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `alysha`@`localhost`                                                  |
| GRANT INSERT, CREATE, DROP, ALTER ON `lahmansbaseballdb`.`pitchers` TO `alysha`@`localhost` |
+---------------------------------------------------------------------------------------------+
```
Last but not least we can also grant a user the authority to grant privileges. So a superuser or full admin user could be created as follows:

```
CREATE USER 'lucas'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON *.* TO 'lucas'@'localhost' WITH GRANT OPTION;
```

## Databases

OK, now let's look at the way data is structured inside a relational database system. The large-scale unit of organization is the database. A database is a set of tables. Tables can't exist on their own; they have to be part of a database. Generally speaking the tables in a database should have some relationship with one another. Either they all cover different aspects of the same topic, or they all pertain to one application.

Let's go ahead and create a database.

Ask students to follow along but doing the curriculum exercises.

```CREATE DATABASE my_test_db```

```SHOW DATABASES```

```USE my_test_db```

```SELECT database()```

```SHOW CREATE DATABASE my_test_db```

```DROP DATABASE my_test_db```

```SHOW DATABASES```

### Database vs. schema

The curriculum mentions the two words database and schema. It correctly states that in MySQL the words are interchangeable. For example

``` help CREATE SCHEMA```

However, this does not mean that the words database and schema are universally considered to be identical. They are not. Many people use the term schema to mean a database design -- a representation of all the structures, such as tables and columns, in a database along with how they connect. So it would be a diagram of all the tables, with the column names, and any relationships between columns portrayed with arrows.

More broadly, in information science, a descriptive schema is a list of the attributes that can be used to describe some specific entity. So when you think of an entity that can be described, what attributes should you use to describe that entity in a way that would be useful for people.

People tend to search for information about an entity using particular tags or keywords representing aspects of that thing that they are interested in. So, let's say you are looking for a hiking trail. You want to know its length, its roughness, its elevation change, its location, its accessibility, its closeness to parking, any outstanding features along it. You search for a beer, you want to know its color, bitterness, sweetness, alcohol content, the hops and malts used in making it, location of the brewery, reviews. Restaurant? Type of food, chef, owner, menu items, reviews, price range, hours, location, website. You use these attribute lists to create metadata -- information about the information -- and the metadata is used to search for and retrieve the information people are looking for. To do that you need to make lists of attributes for the entities that are represented in your database. That list of attributes along with any instructions for applying content to the attributes is a descriptive schema.

Thus, while it is true that in the MySQL RDBMS flavor of the SQL language specifically, schema and database are synonymous, it would be a mistake to think that these two terms are synonymous more broadly in information science and database design.

### reserved words and identifiers

The syllabus also notes that you can use reserved words like 'SELECT' in your database names as long as you enclose them in backticks. I have just two words to say about this. Yeaaaaaahhh ... No.

### exercises

We should have done exercises 1-7 already.

Do problem 8 from curriculum exercises.

## Tables

OK, so let's have a look at tables. Although databases contain tables, tables themselves are the basic organizing principle for data in contemporary SQL RDBMSes.

Much as in Java, everything you store in MySQL has to be of a specified data type. This is the way MySQL knows how much space to allocate for each table cell.

When designing a table, the first thing I do is think of the attributes that I want to use to describe the entity. Then I think of the data types we might use to represent those attributes.

Let's look at a few examples (use DESCRIBE queries on some of the tables in the baseball and movies databases. Offer opportunity to import the sample databases).

So let's create a table. The basic syntax is (```USE codeup_test_db```)

```
CREATE TABLE users (
    first_name VARCHAR(35),
    last_name  VARCHAR(65)
    );
```

```
DESCRIBE users;
```
Notice that we must define the data types. This is required for all MySQL columns. They all hold one particular type of data. Text data takes more storage room than integer data, for example, so it makes sense to define columns that store numbers as integers. The other advantage is a level of built-in validation: you cannot stuff text into an int column, you can't stuff an int into a date column. But it does mean you need to be generally familiar with the MySQL data types.

There is a good account in the [syllabus](https://java.codeup.com/mysql/tables/) and a full account in the [MySQL docs](https://docs.oracle.com/cd/E17952_01/mysql-8.0-en/data-types.html).

We often want to specify things about fields. One of the commonest specifications is that a field always be filled, that is, not be null. To ensure that a table is not null, you can define it as a NOT NULL value.

Let's start again

```DROP TABLE users;```

```
CREATE TABLE users (
    first_name VARCHAR(35) NOT NULL,
    last_name  VARCHAR(65) NOT NULL
    );
```
```
DESCRIBE users;
```

Notice now the "NULL" column has "NO" where before it had "YES". Best practices for efficient queries: use numeric rather than string operations when possible; don't use larger types when smaller ones will do - this isn't just a matter of data storage, shorter values can also be processed more quickly than larger values; define columns to be not null. Not null column values don't need to be checked to see if they are null before being handled, therefore not null columns are handled more efficiently.

If there are going to be null values for a given attribute, we will see later on that we can use multi-table schemas to avoid having columns with null values. For now just tuck that in the back of your minds and define columns as not null whenever possible or necessary.

We often have unique identifiers for entities. So, a user in our database will have a user_id, so that two different John Smiths can be distinguished. So we call it user_id.

```
```DROP TABLE users;```
```
```
CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(35) NOT NULL,
    last_name  VARCHAR(65) NOT NULL,
    PRIMARY KEY (user_id)
    );
```

We have to define the column as not null and we have to add the auto_increment keyword. This means we do not have to populate the column ourselves, it will be automatically populated by the RDBMS itself. In addition, we must define it as a primary key using the syntax PRIMARY KEY (column_name).

Notice in the syllabus the user_id column is additionally defined as UNSIGNED. This means it won't allow negative numbers, which in turn increases the upper range of integers that are allowable.

Putting all this together, we can actually create MySQL scripts, which range from very simple to rather complex. These are used to create and re-create tables and databases. Let's write a simple script to automate creation of a table.

```
USE test_db;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(35) NOT NULL,
    last_name VARCHAR(65) NOT NULL,
    address VARCHAR(200) NOT NULL,
    join_date DATETIME NOT NULL,
    date_of_birth DATE NOT NULL,
    personal_statement TEXT,
    hours_volunteered DOUBLE NOT NULL,
    friends INT NOT NULL,
    PRIMARY KEY (user_id)
    );
```

Use TextEdit. Verify in preferences that the app is set for Plain Text, not Rich Text. Drop the text in there and save as users_table.sql.

Run ```DESCRIBE users```. Then open up another terminal window and do something like

```
mysql -u root -p -t < Documents/Codeup/SQL_Dumps/test_db_users_table.sql
```

Where ```root``` may be a test user such as ```codeup_test_user``` and the path should lead to wherever the file is from wherever the user is in the terminal.

Then in the terminal that has the mysql login, run
```
DESCRIBE users;
```
again, and note the difference.

You can also

```
SHOW CREATE TABLE users;
```

## Backing up your database

It's worth knowing how to reverse it.
From outside mysql client:
```
mysqldump -u root -p test_db > Documents/Codeup/SQL_Dumps/test_db.sql
```
Now from the mysql client
```
SHOW DATABASES;
DROP DATABASE test_db;
SHOW DATABASES;
CREATE DATABASE test_db;
```
Now from outside the mysql client
```
mysql -u root -p test_db < Documents/Codeup/SQL_Dumps/test_db.sql
```
# https://www.codejava.net/java-ee/servlet/handling-html-form-data-with-java-servlet