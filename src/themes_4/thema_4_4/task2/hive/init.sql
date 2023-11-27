-- Создание и загрузка таблицы customers_tmp
CREATE TABLE IF NOT EXISTS customers_tmp(
        row_nbr int,
        Customer_Id string,
        First_Name string,
        Last_Name string,
        Company string,
        City string,
        Country string,
        Phone_1 string,
        Phone_2 string,
        Email string,
        Subscription_Date date,
        Website string,
        year_subs string,
        cust_group string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
TBLPROPERTIES ("skip.header.line.count"="1");

LOAD DATA INPATH '/user/tolik/customers_new.csv' INTO TABLE customers_tmp;

-- Создание и загрузка таблицы organizations_tmp
CREATE TABLE IF NOT EXISTS organizations_tmp(
        row_nbr int,
        Organization_Id string,
        Name string,
        Website string,
        Country string,
        Description string,
        Founded string,
        Industry string,
        Number_of_employees int,
        cust_group string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
TBLPROPERTIES ("skip.header.line.count"="1");

LOAD DATA INPATH '/user/tolik/organizations_new.csv' INTO TABLE organizations_tmp;

-- Создание и загрузка таблицы people_tmp
CREATE TABLE IF NOT EXISTS people_tmp(
        row_nbr int,
        User_Id string,
        First_Name string,
        Last_Name string,
        Sex string,
        Email string,
        Phone string,
        Date_of_birth date,
        Job_Title string,
        cust_group string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
TBLPROPERTIES ("skip.header.line.count"="1");

LOAD DATA INPATH '/user/tolik/people_new.csv' INTO TABLE people_tmp;

-- Создание и загрузка таблицы age_grp
CREATE TABLE IF NOT EXISTS age_grp(
        low_thr int,
        high_thr int,
        age_grp string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

LOAD DATA INPATH '/user/tolik/age_groups.csv' INTO TABLE age_grp;

-- Создание таблицы customers
CREATE TABLE IF NOT EXISTS customers
PARTITIONED BY(cust_group string)
CLUSTERED BY (Customer_Id) INTO 64 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
AS
SELECT * FROM customers_tmp;

-- Удаление временной таблицы customers_tmp
DROP TABLE IF EXISTS customers_tmp;

-- Создание таблицы organizations
CREATE TABLE IF NOT EXISTS organizations
PARTITIONED BY(cust_group string)
CLUSTERED BY (Name) INTO 64 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
AS
SELECT * FROM organizations_tmp;

-- Удаление временной таблицы organizations_tmp
DROP TABLE IF EXISTS organizations_tmp;

-- Создание таблицы people
CREATE TABLE IF NOT EXISTS people
PARTITIONED BY(cust_group string)
CLUSTERED BY (User_Id) INTO 64 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
AS
SELECT * FROM people_tmp;

-- Удаление временной таблицы people_tmp
DROP TABLE IF EXISTS people_tmp;

-- Создание таблицы age_group
CREATE TABLE IF NOT EXISTS age_group
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
AS
SELECT * FROM age_grp;