-- Создаем таблицу-фактов о продажах
CREATE TABLE sales_fact (
    sale_id SERIAL, -- Уникальный идентификатор продажи
    product_id INT, -- Идентификатор продукта
    sale_amount DECIMAL, -- Сумма продажи
    sale_date DATE, -- Дата продажи
    segment_id INT -- Идентификатор сегмента
) 
DISTRIBUTED BY (segment_id) -- Распределяем данные по полю segment_id
PARTITION BY RANGE (sale_date) ( -- Партиционируем по полю sale_date
    START (DATE '2023-01-01') END (DATE '2023-12-31') EVERY (INTERVAL '1 month')
);

-- Создаем таблицу-измерение, в которой отражены стоимость и название товара
CREATE TABLE dimension_product (
    product_id SERIAL PRIMARY KEY, -- Уникальный идентификатор товара
    product_name VARCHAR(255), -- Название товара
    product_price DECIMAL -- Стоимость товара
)
DISTRIBUTED BY (product_id);

-- Создаем внешний ключ для связи с таблицей-фактом
ALTER TABLE sales_fact ADD CONSTRAINT fk_product
    FOREIGN KEY (product_id) REFERENCES dimension_product(product_id);

-- Заполняем таблицу-измерение dimension_product
INSERT INTO dimension_product (product_name, product_price)
VALUES
    ('Товар 1', 10.99),
    ('Товар 2', 19.99),
    ('Товар 3', 5.99);

-- Заполняем таблицу-факт sales_fact
INSERT INTO sales_fact (product_id, sale_amount, sale_date, segment_id)
VALUES
    (1, 10.99, '2023-01-15', 1),
    (2, 19.99, '2023-02-20', 2),
    (3, 5.99, '2023-03-25', 3);

--  Сумма продаж определенного товара за определенную единицу времени
select
	SUM(sale_amount) as total_sales
from
	sales_fact
where
	product_id = 1
	and sale_date >= DATE '2023-01-01'
	and sale_date <= DATE '2023-01-31';

-- План предыдущего запроса
EXPLAIN
SELECT SUM(sale_amount) AS total_sales
FROM sales_fact
WHERE product_id = 1
    AND sale_date >= DATE '2023-01-01'
    AND sale_date <= DATE '2023-01-31';
