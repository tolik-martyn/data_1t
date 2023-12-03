CREATE TABLE IF NOT EXISTS tip_data (
    passanger_count_group INT,
    trip_distance_group INT,
    avg_tip_amount FLOAT
);

INSERT INTO tip_data (passanger_count_group, trip_distance_group, avg_tip_amount)
SELECT
    passanger_count AS passanger_count_group,
    CASE
        WHEN trip_distance < 10 THEN 1
        WHEN trip_distance < 20 THEN 2
        WHEN trip_distance < 30 THEN 3
        WHEN trip_distance < 40 THEN 4
        WHEN trip_distance < 50 THEN 5
        WHEN trip_distance < 60 THEN 6
        WHEN trip_distance < 70 THEN 7
        WHEN trip_distance < 80 THEN 8
        WHEN trip_distance < 90 THEN 9
        WHEN trip_distance < 100 THEN 10
        ELSE 11
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