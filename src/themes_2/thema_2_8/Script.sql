DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    category String, -- категория товара
    order_date Date, -- дата заказа
    revenue Float64, -- выручка
) ENGINE = MergeTree()
ORDER BY (category, order_date);

-- Генерация данных
INSERT INTO sales (category, order_date, revenue)
VALUES
    ('Категория1', '2023-10-01', 150.50),
    ('Категория2', '2023-10-01', 200.25),
    ('Категория3', '2023-10-01', 75.30),
    ('Категория1', '2023-10-01', 120.40),
    ('Категория1', '2023-10-02', 180.75),
    ('Категория2', '2023-10-02', 220.60),
    ('Категория3', '2023-10-02', 90.20),
    ('Категория1', '2023-10-02', 135.90),
    ('Категория2', '2023-10-02', 190.10),
    ('Категория1', '2023-10-03', 160.30),
    ('Категория2', '2023-10-03', 210.45),
    ('Категория3', '2023-10-03', 85.60),
    ('Категория2', '2023-10-03', 195.75),
    ('Категория1', '2023-10-04', 140.90),
    ('Категория2', '2023-10-04', 230.80),
    ('Категория3', '2023-10-04', 80.15),
    ('Категория1', '2023-10-04', 125.25),
    ('Категория2', '2023-10-04', 205.50),
    ('Категория3', '2023-10-04', 95.70),
    ('Категория1', '2023-10-05', 170.60),
    ('Категория2', '2023-10-05', 240.35),
    ('Категория3', '2023-10-05', 70.45),
    ('Категория1', '2023-10-05', 110.80),
    ('Категория3', '2023-10-05', 105.20);

-- 1. Расчет кумулятивной выручки
CREATE MATERIALIZED VIEW IF NOT EXISTS cumulative_revenue_view
ENGINE = AggregatingMergeTree()
ORDER BY (category, order_date)
AS
SELECT
    category,
    order_date,
    runningAccumulate(sum_state, category) AS cumulative_revenue -- кумулятивная выручка
FROM
(
    SELECT
        category,
        order_date,
        sumState(revenue) AS sum_state
    FROM sales
    GROUP BY category, order_date
    ORDER BY category, order_date
);
SELECT * FROM cumulative_revenue_view;

-- 2. Расчет среднего чека
CREATE MATERIALIZED VIEW IF NOT EXISTS average_check_view
ENGINE = AggregatingMergeTree()
ORDER BY (category, order_date)
AS
SELECT
    category,
    order_date,
    runningAccumulate(avg_state, category) AS average_check -- средний чек
FROM
(
    SELECT
        category,
        order_date,
        avgState(revenue) AS avg_state
    FROM sales
    GROUP BY category, order_date
    ORDER BY category, order_date
);
SELECT * FROM average_check_view;

-- 3. Определение даты и значения максимального среднего чека
SELECT
    category,
    argMax(order_date, average_check) AS max_avg_check_date, -- дата максимального среднего чека
    MAX(average_check) AS max_avg_check_value -- значение максимального среднего чека
FROM average_check_view
GROUP BY category
ORDER BY category;