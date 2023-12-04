CREATE TABLE IF NOT EXISTS tip_data (
    passanger_count_group INT,
    trip_distance_group VARCHAR(16),
    avg_tip_amount FLOAT
);

INSERT INTO tip_data (passanger_count_group, trip_distance_group, avg_tip_amount)
SELECT
    passanger_count AS passanger_count_group,
    CASE
        WHEN trip_distance < 10 THEN '0-10'
        WHEN trip_distance < 20 THEN '10-20'
        WHEN trip_distance < 30 THEN '20-30'
        WHEN trip_distance < 40 THEN '30-40'
        WHEN trip_distance < 50 THEN '40-50'
        WHEN trip_distance < 60 THEN '50-60'
        WHEN trip_distance < 70 THEN '60-70'
        WHEN trip_distance < 80 THEN '70-80'
        WHEN trip_distance < 90 THEN '80-90'
        WHEN trip_distance < 100 THEN '90-100'
        ELSE 'более 100'
    END AS trip_distance_group,
    AVG(tip_amount) AS avg_tip_amount
FROM
    core_data
GROUP BY
    passanger_count,
    trip_distance_group
ORDER BY
    passanger_count,
    trip_distance_group;