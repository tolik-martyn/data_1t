CREATE TABLE IF NOT EXISTS percentage_max_min_data (
    date DATE,
    percentage_zero FLOAT,
    max_amount_zero FLOAT,
    min_amount_zero FLOAT,
    percentage_1p FLOAT,
    max_amount_1p FLOAT,
    min_amount_1p FLOAT,
    percentage_2p FLOAT,
    max_amount_2p FLOAT,
    min_amount_2p FLOAT,
    percentage_3p FLOAT,
    max_amount_3p FLOAT,
    min_amount_3p FLOAT,
    percentage_4p_plus FLOAT,
    max_amount_4p_plus FLOAT,
    min_amount_4p_plus FLOAT
);

INSERT INTO percentage_max_min_data (date, percentage_zero, max_amount_zero, min_amount_zero,
                                     percentage_1p, max_amount_1p, min_amount_1p,
                                     percentage_2p, max_amount_2p, min_amount_2p,
                                     percentage_3p, max_amount_3p, min_amount_3p,
                                     percentage_4p_plus, max_amount_4p_plus, min_amount_4p_plus)
SELECT
    date_trunc('day', dropoff_datetime) AS date,
    COUNT(CASE WHEN passanger_count = 0 THEN 1 END) * 100.0 / COUNT(*) AS percentage_zero,
    MAX(CASE WHEN passanger_count = 0 THEN total_amount END) AS max_amount_zero,
    MIN(CASE WHEN passanger_count = 0 THEN total_amount END) AS min_amount_zero,
    COUNT(CASE WHEN passanger_count = 1 THEN 1 END) * 100.0 / COUNT(*) AS percentage_1p,
    MAX(CASE WHEN passanger_count = 1 THEN total_amount END) AS max_amount_1p,
    MIN(CASE WHEN passanger_count = 1 THEN total_amount END) AS min_amount_1p,
    COUNT(CASE WHEN passanger_count = 2 THEN 1 END) * 100.0 / COUNT(*) AS percentage_2p,
    MAX(CASE WHEN passanger_count = 2 THEN total_amount END) AS max_amount_2p,
    MIN(CASE WHEN passanger_count = 2 THEN total_amount END) AS min_amount_2p,
    COUNT(CASE WHEN passanger_count = 3 THEN 1 END) * 100.0 / COUNT(*) AS percentage_3p,
    MAX(CASE WHEN passanger_count = 3 THEN total_amount END) AS max_amount_3p,
    MIN(CASE WHEN passanger_count = 3 THEN total_amount END) AS min_amount_3p,
    COUNT(CASE WHEN passanger_count >= 4 THEN 1 END) * 100.0 / COUNT(*) AS percentage_4p_plus,
    MAX(CASE WHEN passanger_count >= 4 THEN total_amount END) AS max_amount_4p_plus,
    MIN(CASE WHEN passanger_count >= 4 THEN total_amount END) AS min_amount_4p_plus
FROM
    core_data
GROUP BY
    date_trunc('day', dropoff_datetime)
ORDER BY
    date;