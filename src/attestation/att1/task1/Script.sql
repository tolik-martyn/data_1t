-- Задание 1. Используя СУБД Postgres напишите запрос, который формирует таблицы соответствующие по структуре и типу полей из входных csv-файлов.
CREATE TABLE IF NOT EXISTS austin_bikeshare_trips (
    bikeid REAL,
    checkout_time TIME,
    duration_minutes INT,
    end_station_id REAL,
    end_station_name VARCHAR(255),
    month REAL,
    start_station_id REAL,
    start_station_name VARCHAR(255),
    start_time TIMESTAMP,
    subscriber_type VARCHAR(255),
    trip_id BIGSERIAL PRIMARY KEY,
    year REAL
);

CREATE TABLE IF NOT EXISTS austin_bikeshare_stations (
    latitude numeric(9,5),
    location VARCHAR(255),
    longitude numeric(9,5),
    name VARCHAR(255),
    station_id BIGSERIAL PRIMARY KEY,
    status VARCHAR(255)
);

-- Задание 2. Наполните только что созданные таблицы данными из файлов
COPY austin_bikeshare_trips(bikeid, checkout_time, duration_minutes, end_station_id, end_station_name, month, start_station_id, start_station_name, start_time, subscriber_type, trip_id, year)
FROM '/docker-entrypoint-initdb.d/austin_bikeshare_trips.csv'
DELIMITER ','
CSV HEADER;

UPDATE austin_bikeshare_trips
SET
    bikeid = ROUND(bikeid)::integer,
    end_station_id = ROUND(end_station_id)::integer,
    month = ROUND(month)::integer,
    start_station_id = ROUND(start_station_id)::integer,
    year = ROUND(year)::integer;

COPY austin_bikeshare_stations(latitude, location, longitude, name, station_id, status)
FROM '/docker-entrypoint-initdb.d/austin_bikeshare_stations.csv'
DELIMITER ','
CSV HEADER;

-- Задание 3. Напишите sql-запрос, который формирует таблицы для каждого года.
SELECT
	t."year" AS "Год",
    s.station_id AS "Уникальный идентификатор станции",
    COUNT(CASE WHEN t.start_station_id = s.station_id THEN 1 END) AS "Количество начавшихся поездок",
    COUNT(CASE WHEN t.end_station_id = s.station_id THEN 1 END) AS "Количество завершенных поездок",
    COUNT(CASE WHEN t.start_station_id = s.station_id OR t.end_station_id = s.station_id THEN 1 END) AS "Общее количество поездок",
    AVG(CASE WHEN t.start_station_id = s.station_id THEN t.duration_minutes END) AS "Средняя продолжительность начавшихся поездок",
    AVG(CASE WHEN t.end_station_id = s.station_id THEN t.duration_minutes END) AS "Средняя продолжительность завершенных поездок"
FROM
    austin_bikeshare_trips t
LEFT JOIN
    austin_bikeshare_stations s
ON
    t.start_station_id = s.station_id OR t.end_station_id = s.station_id
WHERE
    t."year" IS NOT NULL
    AND s.station_id IS NOT NULL
GROUP BY
    t."year", s.station_id
ORDER BY
    t."year", s.station_id;

-- Задание 4. При написании предыдущего запроса учитывайте условия.
SELECT
	t."year" AS "Год",
    s.station_id AS "Уникальный идентификатор станции",
    COUNT(CASE WHEN t.start_station_id = s.station_id THEN 1 END) AS "Количество начавшихся поездок",
    COUNT(CASE WHEN t.end_station_id = s.station_id THEN 1 END) AS "Количество завершенных поездок",
    COUNT(CASE WHEN t.start_station_id = s.station_id OR t.end_station_id = s.station_id THEN 1 END) AS "Общее количество поездок",
    AVG(CASE WHEN t.start_station_id = s.station_id THEN t.duration_minutes END) AS "Средняя продолжительность начавшихся поездок",
    AVG(CASE WHEN t.end_station_id = s.station_id THEN t.duration_minutes END) AS "Средняя продолжительность завершенных поездок"
FROM
    austin_bikeshare_trips t
LEFT JOIN
    austin_bikeshare_stations s
ON
    t.start_station_id = s.station_id OR t.end_station_id = s.station_id
WHERE
    t."year" IS NOT NULL
    AND s.station_id IS NOT NULL
    AND s.status = 'active'
GROUP BY
    t."year", s.station_id
ORDER BY
    "Год", "Средняя продолжительность начавшихся поездок";

-- Задание 5. Названия 10 станций с самым высоким показателем средней продолжительности начавшихся поездок за 2016 год.
SELECT
    s."name" AS "Название станции",
    AVG(CASE WHEN t.start_station_id = s.station_id THEN t.duration_minutes END) AS "Средняя продолжительность начавшихся поездок"
FROM
    austin_bikeshare_trips t
LEFT JOIN
    austin_bikeshare_stations s
ON
    t.start_station_id = s.station_id
WHERE
    s.station_id IS NOT NULL
	AND t."year" = 2016
GROUP BY
    s."name"
ORDER BY
    "Средняя продолжительность начавшихся поездок" DESC
LIMIT 10;
