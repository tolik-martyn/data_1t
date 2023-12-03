CREATE TABLE IF NOT EXISTS core_data (
    pickup_datetime TIMESTAMP,
    dropoff_datetime TIMESTAMP,
    passanger_count INT,
    trip_distance FLOAT,
    tip_amount FLOAT,
    total_amount FLOAT
);

INSERT INTO core_data (pickup_datetime, dropoff_datetime, passanger_count, trip_distance, tip_amount, total_amount)
SELECT
    TO_TIMESTAMP(trep_pickup_datetime, 'YYYY-MM-DD HH24:MI:SS') AS pickup_datetime,
    TO_TIMESTAMP(trep_dropoff_datetime, 'YYYY-MM-DD HH24:MI:SS') AS dropoff_datetime,
    passanger_count,
    trip_distance,
    tip_amount,
    total_amount
FROM
    raw_data
WHERE
    passanger_count IS NOT NULL
    AND trip_distance > 0
    AND (tip_amount >= 0 OR tip_amount IS NULL)
    AND total_amount > 0;