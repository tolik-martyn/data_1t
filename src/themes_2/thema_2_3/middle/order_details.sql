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
    (1, '2023-09-20 10:00:00', 100.00),
    (2, '2023-09-20 10:15:00', 75.50),
    (3, '2023-09-20 10:30:00', 200.00),
    (4, '2023-09-20 10:45:00', 50.00),
    (5, '2023-09-20 11:00:00', 120.25),
    (1, '2023-09-20 11:15:00', 45.75),
    (2, '2023-09-20 11:30:00', 80.00),
    (3, '2023-09-20 11:45:00', 60.00),
    (4, '2023-09-20 12:00:00', 30.50),
    (5, '2023-09-20 12:15:00', 95.75);

-- Вставляем данные о деталях заказов в таблицу OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 101, 2, 50.00),
    (1, 102, 1, 25.00),
    (2, 103, 3, 15.50),
    (2, 101, 2, 50.00),
    (3, 104, 1, 100.00),
    (3, 102, 2, 25.00),
    (4, 101, 1, 50.00),
    (4, 105, 4, 12.50),
    (5, 103, 2, 15.50),
    (5, 101, 3, 50.00),
    (6, 104, 1, 100.00),
    (6, 106, 2, 40.00),
    (7, 102, 2, 25.00),
    (7, 107, 1, 75.00),
    (8, 105, 3, 12.50),
    (9, 101, 2, 50.00),
    (9, 103, 1, 15.50),
    (10, 102, 1, 25.00),
    (10, 104, 2, 100.00);

-- Задание 1. Выбираем имя и фамилию клиента с наибольшей общей суммой заказов
SELECT c.FirstName, c.LastName
FROM Customers AS c
JOIN (
    SELECT o.CustomerID, SUM(o.TotalAmount) AS TotalAmount
    FROM Orders AS o
    GROUP BY o.CustomerID
    ORDER BY TotalAmount DESC
    LIMIT 1
) AS top_customer ON c.CustomerID = top_customer.CustomerID;

-- Задание 2. Выбираем номер заказа и общую сумму заказов для клиента с наибольшей общей суммой заказов
SELECT o.OrderID, o.TotalAmount
FROM Orders AS o
WHERE o.CustomerID = (
    SELECT o.CustomerID
    FROM Orders AS o
    GROUP BY o.CustomerID
    ORDER BY SUM(o.TotalAmount) DESC
    LIMIT 1
)
ORDER BY o.TotalAmount DESC;

-- Задание 3. Выводим клиентов, у которых общая сумма заказов превышает среднюю общую сумму заказов всех клиентов.
WITH CustomerTotalAmount AS (
    SELECT
        o.CustomerID,
        SUM(o.TotalAmount) AS total_order_amount
    FROM Orders AS o
    GROUP BY o.CustomerID
),
AvgTotalAmount AS (
    SELECT AVG(total_order_amount) AS AvgAmount
    FROM CustomerTotalAmount
)

SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    cta.total_order_amount AS TotalOrderAmount,
    ROUND(AvgTotalAmount.AvgAmount, 2) AS AvgCustomerAmount
FROM Customers AS c
JOIN CustomerTotalAmount AS cta ON c.CustomerID = cta.CustomerID
CROSS JOIN AvgTotalAmount
WHERE cta.total_order_amount > AvgTotalAmount.AvgAmount
ORDER BY cta.total_order_amount DESC;
