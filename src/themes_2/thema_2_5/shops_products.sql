--shop_dns
CREATE TABLE shop_dns (
    date DATE,
    product_id INT,
    sales_cnt INT
);

INSERT INTO shop_dns (date, product_id, sales_cnt)
VALUES
    ('2023-09-01', 1, 15),
    ('2023-09-01', 2, 10),
    ('2023-09-01', 3, 20),
    ('2023-09-02', 1, 12),
    ('2023-09-02', 2, 8),
    ('2023-09-02', 3, 18),
    ('2023-09-03', 1, 14),
    ('2023-09-03', 2, 9),
    ('2023-09-03', 3, 22),
    ('2023-08-01', 1, 10),
    ('2023-08-01', 2, 8),
    ('2023-08-01', 3, 15),
    ('2023-08-02', 1, 12),
    ('2023-08-02', 2, 9),
    ('2023-08-02', 3, 18),
    ('2023-08-03', 1, 14),
    ('2023-08-03', 2, 10),
    ('2023-08-03', 3, 20),
    ('2023-10-01', 1, 11),
    ('2023-10-01', 2, 9),
    ('2023-10-01', 3, 16),
    ('2023-10-02', 1, 13),
    ('2023-10-02', 2, 10),
    ('2023-10-02', 3, 18),
    ('2023-10-03', 1, 12),
    ('2023-10-03', 2, 8),
    ('2023-10-03', 3, 20);


-- shop_mvideo
CREATE TABLE shop_mvideo (
    date DATE,
    product_id INT,
    sales_cnt INT
);

INSERT INTO shop_mvideo (date, product_id, sales_cnt)
VALUES
    ('2023-09-01', 1, 12),
    ('2023-09-01', 2, 8),
    ('2023-09-01', 3, 16),
    ('2023-09-02', 1, 10),
    ('2023-09-02', 2, 6),
    ('2023-09-02', 3, 14),
    ('2023-09-03', 1, 11),
    ('2023-09-03', 2, 7),
    ('2023-09-03', 3, 17),
    ('2023-08-01', 1, 9),
    ('2023-08-01', 2, 7),
    ('2023-08-01', 3, 14),
    ('2023-08-02', 1, 11),
    ('2023-08-02', 2, 8),
    ('2023-08-02', 3, 16),
    ('2023-08-03', 1, 13),
    ('2023-08-03', 2, 9),
    ('2023-08-03', 3, 19),
    ('2023-10-01', 1, 10),
    ('2023-10-01', 2, 8),
    ('2023-10-01', 3, 15),
    ('2023-10-02', 1, 12),
    ('2023-10-02', 2, 9),
    ('2023-10-02', 3, 17),
    ('2023-10-03', 1, 11),
    ('2023-10-03', 2, 7),
    ('2023-10-03', 3, 19);


-- shop_sitilink
CREATE TABLE shop_sitilink (
    date DATE,
    product_id INT,
    sales_cnt INT
);

INSERT INTO shop_sitilink (date, product_id, sales_cnt)
VALUES
    ('2023-09-01', 1, 18),
    ('2023-09-01', 2, 12),
    ('2023-09-01', 3, 24),
    ('2023-09-02', 1, 15),
    ('2023-09-02', 2, 9),
    ('2023-09-02', 3, 21),
    ('2023-09-03', 1, 16),
    ('2023-09-03', 2, 10),
    ('2023-09-03', 3, 26),
    ('2023-08-01', 1, 15),
    ('2023-08-01', 2, 10),
    ('2023-08-01', 3, 20),
    ('2023-08-02', 1, 14),
    ('2023-08-02', 2, 9),
    ('2023-08-02', 3, 18),
    ('2023-08-03', 1, 16),
    ('2023-08-03', 2, 11),
    ('2023-08-03', 3, 22),
    ('2023-10-01', 1, 14),
    ('2023-10-01', 2, 10),
    ('2023-10-01', 3, 19),
    ('2023-10-02', 1, 12),
    ('2023-10-02', 2, 8),
    ('2023-10-02', 3, 16),
    ('2023-10-03', 1, 13),
    ('2023-10-03', 2, 9),
    ('2023-10-03', 3, 18);


-- plan
CREATE TABLE plan (
    product_id INT,
    shop_name VARCHAR(255),
    plan_cnt INT,
    plan_date DATE
);

INSERT INTO plan (product_id, shop_name, plan_cnt, plan_date)
VALUES
    (1, 'shop_dns', 25, '2023-09-01'),
    (2, 'shop_dns', 20, '2023-09-01'),
    (3, 'shop_dns', 30, '2023-09-01'),
    (1, 'shop_dns', 23, '2023-09-02'),
    (2, 'shop_dns', 21, '2023-09-02'),
    (3, 'shop_dns', 19, '2023-09-02'),
    (1, 'shop_dns', 22, '2023-09-03'),
    (2, 'shop_dns', 27, '2023-09-03'),
    (3, 'shop_dns', 17, '2023-09-03'),
    (1, 'shop_mvideo', 20, '2023-09-01'),
    (2, 'shop_mvideo', 15, '2023-09-01'),
    (3, 'shop_mvideo', 25, '2023-09-01'),
    (1, 'shop_mvideo', 17, '2023-09-02'),
    (2, 'shop_mvideo', 23, '2023-09-02'),
    (3, 'shop_mvideo', 22, '2023-09-02'),
    (1, 'shop_mvideo', 18, '2023-09-03'),
    (2, 'shop_mvideo', 27, '2023-09-03'),
    (3, 'shop_mvideo', 24, '2023-09-03'),
    (1, 'shop_sitilink', 30, '2023-09-01'),
    (2, 'shop_sitilink', 25, '2023-09-01'),
    (3, 'shop_sitilink', 35, '2023-09-01'),
    (1, 'shop_sitilink', 27, '2023-09-02'),
    (2, 'shop_sitilink', 23, '2023-09-02'),
    (3, 'shop_sitilink', 33, '2023-09-02'),
    (1, 'shop_sitilink', 22, '2023-09-03'),
    (2, 'shop_sitilink', 24, '2023-09-03'),
    (3, 'shop_sitilink', 26, '2023-09-03'),
    (1, 'shop_dns', 28, '2023-08-01'),
    (2, 'shop_dns', 22, '2023-08-01'),
    (3, 'shop_dns', 32, '2023-08-01'),
    (1, 'shop_dns', 25, '2023-08-02'),
    (2, 'shop_dns', 23, '2023-08-02'),
    (3, 'shop_dns', 20, '2023-08-02'),
    (1, 'shop_dns', 24, '2023-08-03'),
    (2, 'shop_dns', 28, '2023-08-03'),
    (3, 'shop_dns', 18, '2023-08-03'),
    (1, 'shop_mvideo', 22, '2023-08-01'),
    (2, 'shop_mvideo', 17, '2023-08-01'),
    (3, 'shop_mvideo', 27, '2023-08-01'),
    (1, 'shop_mvideo', 19, '2023-08-02'),
    (2, 'shop_mvideo', 25, '2023-08-02'),
    (3, 'shop_mvideo', 23, '2023-08-02'),
    (1, 'shop_mvideo', 21, '2023-08-03'),
    (2, 'shop_mvideo', 30, '2023-08-03'),
    (3, 'shop_mvideo', 26, '2023-08-03'),
    (1, 'shop_sitilink', 35, '2023-08-01'),
    (2, 'shop_sitilink', 28, '2023-08-01'),
    (3, 'shop_sitilink', 40, '2023-08-01'),
    (1, 'shop_sitilink', 30, '2023-08-02'),
    (2, 'shop_sitilink', 26, '2023-08-02'),
    (3, 'shop_sitilink', 36, '2023-08-02'),
    (1, 'shop_sitilink', 26, '2023-08-03'),
    (2, 'shop_sitilink', 30, '2023-08-03'),
    (3, 'shop_sitilink', 33, '2023-08-03'),
    (1, 'shop_dns', 30, '2023-10-01'),
    (2, 'shop_dns', 25, '2023-10-01'),
    (3, 'shop_dns', 35, '2023-10-01'),
    (1, 'shop_dns', 28, '2023-10-02'),
    (2, 'shop_dns', 23, '2023-10-02'),
    (3, 'shop_dns', 20, '2023-10-02'),
    (1, 'shop_dns', 32, '2023-10-03'),
    (2, 'shop_dns', 27, '2023-10-03'),
    (3, 'shop_dns', 18, '2023-10-03'),
    (1, 'shop_mvideo', 25, '2023-10-01'),
    (2, 'shop_mvideo', 20, '2023-10-01'),
    (3, 'shop_mvideo', 30, '2023-10-01'),
    (1, 'shop_mvideo', 22, '2023-10-02'),
    (2, 'shop_mvideo', 28, '2023-10-02'),
    (3, 'shop_mvideo', 23, '2023-10-02'),
    (1, 'shop_mvideo', 29, '2023-10-03'),
    (2, 'shop_mvideo', 32, '2023-10-03'),
    (3, 'shop_mvideo', 24, '2023-10-03'),
    (1, 'shop_sitilink', 38, '2023-10-01'),
    (2, 'shop_sitilink', 30, '2023-10-01'),
    (3, 'shop_sitilink', 40, '2023-10-01'),
    (1, 'shop_sitilink', 32, '2023-10-02'),
    (2, 'shop_sitilink', 28, '2023-10-02'),
    (3, 'shop_sitilink', 36, '2023-10-02'),
    (1, 'shop_sitilink', 35, '2023-10-03'),
    (2, 'shop_sitilink', 31, '2023-10-03'),
    (3, 'shop_sitilink', 42, '2023-10-03');


-- products
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(255),
    price DECIMAL(10, 2)
);

INSERT INTO products (product_id, product_name, price)
VALUES
    (1, 'Испорченный телефон', 100.00),
    (2, 'Сарафанное радио', 50.00),
    (3, 'Патефон', 75.00);

-- Первичные и внешние ключи, связи между таблицами
ALTER TABLE products
ADD PRIMARY KEY (product_id);

ALTER TABLE shop_dns
ADD CONSTRAINT fk_shop_dns_product
FOREIGN KEY (product_id)
REFERENCES products (product_id);

ALTER TABLE shop_mvideo
ADD CONSTRAINT fk_shop_mvideo_product
FOREIGN KEY (product_id)
REFERENCES products (product_id);

ALTER TABLE shop_sitilink
ADD CONSTRAINT fk_shop_sitilink_product
FOREIGN KEY (product_id)
REFERENCES products (product_id);

ALTER TABLE plan
ADD CONSTRAINT fk_plan_product
FOREIGN KEY (product_id)
REFERENCES products (product_id);

-- Создаем связующую таблицу
CREATE TABLE sales_summary AS
SELECT
    CASE
        WHEN p.shop_name = 'shop_dns' THEN 'DNS'
        WHEN p.shop_name = 'shop_mvideo' THEN 'М.Видео'
        WHEN p.shop_name = 'shop_sitilink' THEN 'Ситилинк'
        ELSE 'Default'
    END AS shop_name,
    pr.product_name,
    SUM(p.sales_cnt) AS sales_fact,
    SUM(pl.plan_cnt) AS sales_plan,
    CASE
        WHEN SUM(pl.plan_cnt) > 0
            THEN ROUND(SUM(p.sales_cnt) * 1.00 / SUM(pl.plan_cnt), 2)
        ELSE 0
    END AS sales_ratio,
    SUM(p.sales_cnt * pr.price) AS income_fact,
    SUM(pl.plan_cnt * pr.price) AS income_plan,
    CASE
        WHEN SUM(pl.plan_cnt * pr.price) > 0
            THEN ROUND(SUM(p.sales_cnt * pr.price) * 1.00 / SUM(pl.plan_cnt * pr.price), 2)
        ELSE 0
    END AS income_ratio,
    TO_CHAR(DATE_TRUNC('month', p.date), 'Month YYYY') AS month
FROM
    (
        SELECT
            'shop_dns' AS shop_name,
            *
        FROM
            shop_dns
        UNION ALL
        SELECT
            'shop_mvideo' AS shop_name,
            *
        FROM
            shop_mvideo
        UNION ALL
        SELECT
            'shop_sitilink' AS shop_name,
            *
        FROM
            shop_sitilink
    ) AS p
JOIN
    products AS pr ON p.product_id = pr.product_id
JOIN
    plan AS pl ON p.product_id = pl.product_id AND p.shop_name = pl.shop_name AND p.date = pl.plan_date
GROUP BY
    p.shop_name,
    pr.product_name,
    DATE_TRUNC('month', p.date)
ORDER BY
    DATE_TRUNC('month', p.date),
    p.shop_name,
    pr.product_name;


-- Проверяем результат
SELECT * FROM sales_summary;
