CREATE TABLE author (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(400)
);

CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(400)
);

CREATE TABLE book_language (
    language_id INT PRIMARY KEY,
    language_code VARCHAR(8),
    language_name VARCHAR(50)
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(200),
    last_name VARCHAR(200),
    email VARCHAR(350)
);

CREATE TABLE country (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(200)
);

CREATE TABLE address (
    address_id INT PRIMARY KEY,
    street_number VARCHAR(10),
    street_name VARCHAR(200),
    city VARCHAR(100),
    country_id INT,
    CONSTRAINT fk_addr_ctry FOREIGN KEY (country_id) REFERENCES country (country_id)
);

CREATE TABLE address_status (
    status_id INT,
    address_status VARCHAR(30),
    CONSTRAINT pk_addr_status PRIMARY KEY (status_id)
);

CREATE TABLE shipping_method (
    method_id INT PRIMARY KEY,
    method_name VARCHAR(100),
    cost DECIMAL(6, 2)
);

CREATE TABLE order_status (
    status_id INT PRIMARY KEY,
    status_value VARCHAR(20)
);
CREATE TABLE book (
    book_id INT PRIMARY KEY,
    title VARCHAR(400),
    isbn13 VARCHAR(13),
    language_id INT,
    num_pages INT,
    publication_date DATE,
    publisher_id INT,
    CONSTRAINT fk_book_lang FOREIGN KEY (language_id) REFERENCES book_language (language_id),
    CONSTRAINT fk_book_pub FOREIGN KEY (publisher_id) REFERENCES publisher (publisher_id)
);

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    CONSTRAINT pk_custaddr PRIMARY KEY (customer_id, address_id),
    CONSTRAINT fk_ca_cust FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    CONSTRAINT fk_ca_addr FOREIGN KEY (address_id) REFERENCES address (address_id)
);

CREATE TABLE bridge_book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book (book_id),
    FOREIGN KEY (author_id) REFERENCES author (author_id)
);

CREATE TABLE cust_order (
    order_id SERIAL,
    order_date TIMESTAMP,
    customer_id INT,
    shipping_method_id INT,
    dest_address_id INT,
    CONSTRAINT pk_custorder PRIMARY KEY (order_id),
    CONSTRAINT fk_order_cust FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    CONSTRAINT fk_order_ship FOREIGN KEY (shipping_method_id) REFERENCES shipping_method (method_id),
    CONSTRAINT fk_order_addr FOREIGN KEY (dest_address_id) REFERENCES address (address_id)
);

CREATE TABLE fact_order_line (
    line_id SERIAL PRIMARY KEY,
    order_id INT,
    book_id INT,
    price DECIMAL(5, 2),
    customer_id INT,
    order_date TIMESTAMP,
    shipping_method_id INT,
    address_id INT,
    status_id INT,
    CONSTRAINT fk_ol_order FOREIGN KEY (order_id) REFERENCES cust_order (order_id),
    CONSTRAINT fk_ol_book FOREIGN KEY (book_id) REFERENCES book (book_id),
    CONSTRAINT fk_ol_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    CONSTRAINT fk_ol_ship FOREIGN KEY (shipping_method_id) REFERENCES shipping_method (method_id),
    CONSTRAINT fk_ol_addr FOREIGN KEY (address_id) REFERENCES address (address_id),
    CONSTRAINT fk_ol_status FOREIGN KEY (status_id) REFERENCES order_status (status_id)
);




