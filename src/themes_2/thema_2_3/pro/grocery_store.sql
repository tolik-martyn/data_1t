-- Создаем таблицу Customers для хранения информации о клиентах
CREATE TABLE Customers (
    CustomerID serial PRIMARY KEY, -- Уникальный идентификатор клиента
    FirstName varchar, -- Имя клиента
    LastName varchar, -- Фамилия клиента
    Email varchar -- Адрес электронной почты клиента
);

-- Создаем таблицу Orders для хранения информации о заказах
CREATE TABLE Orders (
    OrderID serial PRIMARY KEY, -- Уникальный идентификатор заказа
    CustomerID int, -- Идентификатор клиента, связанный с заказом
    OrderDate timestamp, -- Дата и время размещения заказа
    TotalAmount decimal -- Общая сумма заказа
);

-- Создаем таблицу OrderDetails для хранения информации о деталях заказов
CREATE TABLE OrderDetails (
    OrderDetailID serial PRIMARY KEY, -- Уникальный идентификатор детали заказа
    OrderID int, -- Идентификатор заказа, связанный с деталью
    ProductID int, -- Идентификатор продукта
    Quantity int, -- Количество продукта в заказе
    UnitPrice decimal -- Цена за единицу продукта
);

-- Добавляем внешний ключ для связи заказов с клиентами
ALTER TABLE Orders
ADD CONSTRAINT FK_CustomerID
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

-- Добавляем внешний ключ для связи деталей заказов с заказами
ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderID
FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID);

-- Вставляем данные о клиентах в таблицу Customers
INSERT INTO Customers (FirstName, LastName, Email)
VALUES
    ('Иван', 'Иванов', 'ivan@example.com'),
    ('Мария', 'Петрова', 'maria@example.com'),
    ('Петр', 'Сидоров', 'petr@example.com'),
    ('Елена', 'Козлова', 'elena@example.com'),
    ('Андрей', 'Смирнов', 'andrey@example.com');

-- Вставляем данные о заказах в таблицу Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
    (1, '2023-07-20 10:00:00', 100.00),
    (2, '2023-07-25 10:15:00', 150.00),
    (3, '2023-08-5 10:30:00', 200.00),
    (4, '2023-08-10 10:45:00', 50.00),
    (5, '2023-08-15 11:00:00', 225.00),
    (1, '2023-08-30 11:15:00', 180.00),
    (2, '2023-09-5 11:30:00', 90.00),
    (3, '2023-09-10 11:45:00', 300.00),
    (4, '2023-09-15 12:00:00', 140.00),
    (5, '2023-09-20 12:15:00', 225.00);

-- Вставляем данные о деталях заказов в таблицу OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 101, 1, 50.00),
    (1, 102, 2, 25.00),
    (2, 103, 4, 12.50),
    (2, 101, 2, 50.00),
    (3, 104, 1, 100.00),
    (3, 101, 2, 50.00),
    (4, 103, 2, 12.50),
    (4, 102, 1, 25.00),
    (5, 103, 6, 12.50),
    (5, 101, 3, 50.00),
    (6, 104, 1, 100.00),
    (6, 105, 2, 40.00),
    (7, 102, 2, 25.00),
    (7, 105, 1, 40.00),
    (8, 104, 3, 100.00),
    (9, 101, 2, 50.00),
    (9, 105, 1, 40.00),
    (10, 102, 1, 25.00),
    (10, 104, 2, 100.00);

-- Создаем таблицу Products для хранения информации о продуктах
CREATE TABLE Products (
    ProductID serial PRIMARY KEY, -- Уникальный идентификатор продукта
    ProductName varchar, -- Название продукта
    CategoryID int, -- Идентификатор категории продукта
    Price decimal -- Цена продукта
);

-- Вставляем данные о продуктах в таблицу Products
INSERT INTO Products (ProductID, ProductName, CategoryID, Price)
VALUES
    (101, 'Продукт 1', 1, 50.00),
    (102, 'Продукт 2', 2, 25.00),
    (103, 'Продукт 3', 1, 12.50),
    (104, 'Продукт 4', 3, 100.00),
    (105, 'Продукт 5', 2, 40.00);

-- Создаем таблицу ProductReviews для хранения информации об отзывах о продуктах
CREATE TABLE ProductReviews (
    ReviewID serial PRIMARY KEY, -- Уникальный идентификатор отзыва
    ProductID int, -- Идентификатор продукта, к которому относится отзыв
    CustomerID int, -- Идентификатор клиента, оставившего отзыв
    Rating int, -- Оценка продукта от 1 до 5
    ReviewText text -- Текст отзыва
);

-- Вставляем данные о отзывах в таблицу ProductReviews
INSERT INTO ProductReviews (ProductID, CustomerID, Rating, ReviewText)
VALUES
    (101, 1, 5, 'Отличный продукт!'),
    (103, 2, 4, 'Хорошее качество, но дорого.'),
    (101, 3, 3, 'Средний продукт.'),
    (102, 4, 5, 'Отличное качество и цена.'),
    (103, 5, 2, 'Не понравилось.'),
    (101, 1, 4, 'Хороший продукт для своей цены.'),
    (105, 2, 3, 'Среднее качество, но недорого.'),
    (104, 3, 5, 'Отличный выбор!'),
    (105, 4, 4, 'Хорошее соотношение цены и качества.'),
    (101, 5, 2, 'Не рекомендую, низкое качество.');

-- Добавляем внешний ключ для связи отзывов с продуктами
ALTER TABLE ProductReviews
ADD CONSTRAINT FK_ProductID
FOREIGN KEY (ProductID)
REFERENCES Products(ProductID);

-- Добавляем внешний ключ для связи деталей заказов с продуктами
ALTER TABLE OrderDetails
ADD CONSTRAINT FK_ProductID
FOREIGN KEY (ProductID)
REFERENCES Products(ProductID);

-- Добавляем внешний ключ для связи клиентов с отзывами о продуктах
ALTER TABLE ProductReviews
ADD CONSTRAINT FK_CustomerID
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

-- Задание 1. Запрос для анализа общего количества продуктов и общей суммы заказов для каждого клиента
WITH CustomerTotalProducts AS (
    SELECT
        o.CustomerID,
        SUM(od.Quantity) AS TotalProducts
    FROM Orders AS o
    LEFT JOIN OrderDetails AS od ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID
),
CustomerTotalOrderAmount AS (
    SELECT
        o.CustomerID,
        SUM(o.TotalAmount) AS TotalOrderAmount
    FROM Orders AS o
    GROUP BY o.CustomerID
)
SELECT
    c.FirstName,
    c.LastName,
    COALESCE(tp.TotalProducts, 0) AS TotalProducts,
    COALESCE(toa.TotalOrderAmount, 0) AS TotalOrderAmount
FROM Customers AS c
LEFT JOIN CustomerTotalProducts AS tp ON c.CustomerID = tp.CustomerID
LEFT JOIN CustomerTotalOrderAmount AS toa ON c.CustomerID = toa.CustomerID;

-- Задание 2. Запрос для получения информации о заказах клиентов с указанием категории "Новые заказы" или "Старые заказы"
SELECT
    o.OrderID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderDate,
    o.TotalAmount,
    CASE
        WHEN o.OrderDate >= NOW() - INTERVAL '1 month' THEN 'Новые заказы'
        ELSE 'Старые заказы'
    END AS OrderCategory
FROM Orders AS o
LEFT JOIN Customers AS c ON o.CustomerID = c.CustomerID;

-- Задание 3.1. Запрос для вычисления средней оценки клиентов
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    ROUND (AVG(pr.Rating), 2) AS AverageRating
FROM Customers c
LEFT JOIN ProductReviews pr ON c.CustomerID = pr.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY c.CustomerID;

-- Задание 3.2. Запрос для вычисления средней оценки продуктов для каждого клиента
SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    p.ProductName,
    ROUND (AVG(pr.Rating), 2) AS AverageRating
FROM Customers c
LEFT JOIN ProductReviews pr ON c.CustomerID = pr.CustomerID
LEFT JOIN Products p ON pr.ProductID = p.ProductID
GROUP BY c.CustomerID, p.ProductID
ORDER BY c.CustomerID, p.ProductID;

-- Задание 4. Запрос для анализа общего количества продуктов, общей суммы заказов, и средней оценки клиентов
-- Специально не добавлял вывод старых/новых заказов, так как это относится к заказам.
-- В текущем же запросе мы выводим информацию по клиентам, а не по заказам.
-- По такой же причине показаны средние оценки клиентов, а не средние оценки по продуктам.

WITH CustomerTotalProducts AS (
    SELECT
        o.CustomerID,
        SUM(od.Quantity) AS TotalProducts
    FROM Orders AS o
    LEFT JOIN OrderDetails AS od ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID
),
CustomerTotalOrderAmount AS (
    SELECT
        o.CustomerID,
        SUM(o.TotalAmount) AS TotalOrderAmount
    FROM Orders AS o
    GROUP BY o.CustomerID
),
CustomerOrderCategories AS (
    SELECT
        o.CustomerID,
        CASE
            WHEN o.OrderDate >= NOW() - INTERVAL '1 month' THEN 'Новые заказы'
            ELSE 'Старые заказы'
        END AS OrderCategory
    FROM Orders AS o
)
SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COALESCE(toa.TotalOrderAmount, 0) AS TotalOrderAmount,
    COALESCE(tp.TotalProducts, 0) AS TotalProducts,
    -- coc.OrderCategory,
    ROUND(AVG(pr.Rating), 2) AS AverageRating
FROM Customers AS c
LEFT JOIN CustomerTotalOrderAmount AS toa ON c.CustomerID = toa.CustomerID
LEFT JOIN CustomerTotalProducts AS tp ON c.CustomerID = tp.CustomerID
-- LEFT JOIN CustomerOrderCategories AS coc ON c.CustomerID = coc.CustomerID
LEFT JOIN ProductReviews AS pr ON c.CustomerID = pr.CustomerID
GROUP BY c.CustomerID, toa.TotalOrderAmount, tp.TotalProducts -- без <coc.OrderCategory>
-- GROUP BY c.CustomerID, toa.TotalOrderAmount, tp.TotalProducts, coc.OrderCategory -- с <coc.OrderCategory>
ORDER BY c.CustomerID;
