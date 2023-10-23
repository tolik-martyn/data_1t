-- Создание таблицы Address
CREATE TABLE IF NOT EXISTS Address (
    address_id SERIAL PRIMARY KEY,
    region VARCHAR(255),
    city VARCHAR(255),
    street VARCHAR(255),
    house INT,
    apartment INT
);

-- Создание таблицы ListAddress
CREATE TABLE IF NOT EXISTS ListAddress (
    list_address_id SERIAL PRIMARY KEY,
    address_id INT,
    person_id INT,
    description TEXT
);

-- Создание таблицы Phone
CREATE TABLE IF NOT EXISTS Phone (
    phone_id SERIAL PRIMARY KEY,
    number VARCHAR(20)
);

-- Создание таблицы ListPhone
CREATE TABLE IF NOT EXISTS ListPhone (
    list_phone_id SERIAL PRIMARY KEY,
    person_id INT,
    phone_id INT,
    description TEXT
);

-- Создание таблицы Person
CREATE TABLE IF NOT EXISTS Person (
    person_id SERIAL PRIMARY KEY,
    last_name VARCHAR(255),
    first_name VARCHAR(255)
);

-- Создание таблицы Reader
CREATE TABLE IF NOT EXISTS Reader (
    reader_id SERIAL PRIMARY KEY,
    person_id INT
);

-- Создание таблицы Author
CREATE TABLE IF NOT EXISTS Author (
    author_id SERIAL PRIMARY KEY,
    person_id INT
);

-- Создание таблицы Book
CREATE TABLE IF NOT EXISTS Book (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    publication_year DATE,
    page_count INT,
    price DECIMAL,
    quantity_in_stock INT
);

-- Создание таблицы BookAuthor
CREATE TABLE IF NOT EXISTS BookAuthor (
    book_author_id SERIAL PRIMARY KEY,
    author_id INT,
    book_id INT
);

-- Создание таблицы Publisher
CREATE TABLE IF NOT EXISTS Publisher (
    publisher_id SERIAL PRIMARY KEY,
    publisher_name VARCHAR(255),
    city VARCHAR(255)
);

-- Создание таблицы BookPublisher
CREATE TABLE IF NOT EXISTS BookPublisher (
    b_p_id SERIAL PRIMARY KEY,
    book_id INT,
    publisher_id INT
);

-- Создание таблицы BookLoans
CREATE TABLE IF NOT EXISTS BookLoans (
    loan_id SERIAL PRIMARY KEY,
    reader_id INT,
    book_id INT,
    loan_date TIMESTAMP,
    return_date TIMESTAMP
);

-- Установление связи между ListAddress и Address
ALTER TABLE ListAddress
ADD CONSTRAINT fk_listaddress_address 
FOREIGN KEY (address_id) REFERENCES Address(address_id);

-- Установление связи между ListAddress и Person
ALTER TABLE ListAddress
ADD CONSTRAINT fk_listaddress_person 
FOREIGN KEY (person_id) REFERENCES Person(person_id);

-- Установление связи между ListPhone и Person
ALTER TABLE ListPhone
ADD CONSTRAINT fk_listphone_person 
FOREIGN KEY (person_id) REFERENCES Person(person_id);

-- Установление связи между ListPhone и Phone
ALTER TABLE ListPhone
ADD CONSTRAINT fk_listphone_phone 
FOREIGN KEY (phone_id) REFERENCES Phone(phone_id);

-- Установление связи между Reader и Person
ALTER TABLE Reader
ADD CONSTRAINT fk_reader_person 
FOREIGN KEY (person_id) REFERENCES Person(person_id);

-- Установление связи между Author и Person
ALTER TABLE Author
ADD CONSTRAINT fk_author_person 
FOREIGN KEY (person_id) REFERENCES Person(person_id);

-- Установление связи между BookAuthor и Author
ALTER TABLE BookAuthor
ADD CONSTRAINT fk_bookauthor_author 
FOREIGN KEY (author_id) REFERENCES Author(author_id);

-- Установление связи между BookAuthor и Book
ALTER TABLE BookAuthor
ADD CONSTRAINT fk_bookauthor_book 
FOREIGN KEY (book_id) REFERENCES Book(book_id);

-- Установление связи между BookPublisher и Book
ALTER TABLE BookPublisher
ADD CONSTRAINT fk_bookpublisher_book 
FOREIGN KEY (book_id) REFERENCES Book(book_id);

-- Установление связи между BookPublisher и Publisher
ALTER TABLE BookPublisher
ADD CONSTRAINT fk_bookpublisher_publisher 
FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id);

-- Установление связи между BookLoans и Reader
ALTER TABLE BookLoans
ADD CONSTRAINT fk_bookloans_reader 
FOREIGN KEY (reader_id) REFERENCES Reader(reader_id);

-- Установление связи между BookLoans и Book
ALTER TABLE BookLoans
ADD CONSTRAINT fk_bookloans_book 
FOREIGN KEY (book_id) REFERENCES Book(book_id);
