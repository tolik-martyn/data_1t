-- Запрос для итоговой витрины
WITH tmp AS (
    SELECT
        o.name AS company,
        c.year_subs AS year_subs,
        CAST(MONTHS_BETWEEN(c.Subscription_Date, p.Date_of_birth) AS INT) DIV 12 AS diff
    FROM customers c
        JOIN people p ON c.row_nbr = p.row_nbr
        JOIN organizations o ON c.company = o.name
),

tmp_2 AS (
    SELECT
        tmp.company,
        tmp.year_subs,
        a.age_grp,
        COUNT(a.age_grp) AS cnt
    FROM tmp, age_group a
    WHERE tmp.diff BETWEEN a.low_thr AND a.high_thr
    GROUP BY tmp.company, tmp.year_subs, a.age_grp
    HAVING COUNT(tmp.diff) > 0
),

tmp_3 AS (
    SELECT
        company,
        year_subs,
        age_grp,
        MAX(cnt) OVER (PARTITION BY company, year_subs) AS cnt
    FROM tmp_2
)

SELECT
    company AS Company,
    year_subs AS Year,
    CONCAT_WS(', ', COLLECT_SET(age_grp)) AS Age_group
FROM tmp_3
GROUP BY company, year_subs
ORDER BY Company, Year;