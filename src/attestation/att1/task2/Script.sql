CREATE TABLE IF NOT EXISTS IT_vacancies_full
(
  Ids UInt32,
  Employer String,
  Name String,
  Salary Nullable(Boolean),
  "From" Nullable(Float32),
  "To" Nullable(Float32),
  Experience String,
  Schedule String,
  Keys String,
  Description String,
  Area String,
  Professional_roles String,
  Specializations String,
  Profarea_names String,
  Published_at DateTime
)
ENGINE = MergeTree()
ORDER BY (Area, Ids);

-- удалены столбцы, которые в схеме не отображены
ALTER TABLE IT_vacancies_full DROP COLUMN Professional_roles;
ALTER TABLE IT_vacancies_full DROP COLUMN Specializations;
ALTER TABLE IT_vacancies_full DROP COLUMN Profarea_names;

-- удалены вакансии, в которых не указана заработная плата.
ALTER TABLE IT_vacancies_full DELETE WHERE NOT Salary;

-- код для извлечения информации о средней заработной плате вакансий и местоположении, где вакансии наиболее распространены
SELECT
    Area AS Location,
    AVG(COALESCE("From", "To")) AS AverageSalary,
    COUNT(*) AS VacancyCount
FROM IT_vacancies_full
WHERE Salary = 1 -- Условие, где Salary = True (1)
GROUP BY Area
ORDER BY VacancyCount DESC;