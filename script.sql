-- script.sql для лабораторной работы 3
-- Создание табличного пространства
CREATE TABLESPACE cln78 LOCATION '/Users/aleksandrbabushkin/ITMO/s7-dbms-lab3/cln78';

-- Устанавливаем табличное пространство для template1
ALTER DATABASE template1 SET TABLESPACE cln78;

-- Создаем основную базу данных
CREATE DATABASE wetredsoup WITH TEMPLATE template0 OWNER aleksandrbabushkin TABLESPACE cln78;

-- Создаем дополнительную роль
CREATE ROLE newrole WITH LOGIN PASSWORD 'pass';

-- Устанавливаем пароль для пользователя
ALTER USER aleksandrbabushkin WITH PASSWORD '44';

-- Подключаемся к новой БД и настраиваем права
\c wetredsoup aleksandrbabushkin

GRANT USAGE ON SCHEMA public TO newrole;
GRANT CREATE ON SCHEMA public TO newrole;
GRANT ALL ON TABLESPACE cln78 TO newrole;

-- Создаем таблицы в табличном пространстве cln78
CREATE TABLE test (
    id SERIAL PRIMARY KEY,
    data_value TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) TABLESPACE cln78;

INSERT INTO test (data_value) VALUES
('Тестовые данные 1'),
('Тестовые данные 2'),
('Тестовые данные 3');

CREATE TABLE test2 (
    id SERIAL PRIMARY KEY,
    info TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) TABLESPACE cln78;

-- Проверка табличных пространств
\c postgres aleksandrbabushkin

-- \pset pager off
-- WITH db_tablespaces AS (
--     SELECT t.spcname, d.datname
--     FROM pg_tablespace t
--     JOIN pg_database d ON d.dattablespace = t.oid
-- )
-- SELECT
--     t.spcname,
--     COALESCE(string_agg(DISTINCT c.relname, E'\n'), 'No objects') AS objects,
--     string_agg(DISTINCT db.datname, ', ') AS databases_in
-- FROM pg_tablespace t
-- LEFT JOIN pg_class c ON c.reltablespace = t.oid OR (c.reltablespace = 0 AND t.spcname = 'pg_default')
-- LEFT JOIN db_tablespaces db ON t.spcname = db.spcname
-- GROUP BY t.spcname
-- ORDER BY t.spcname;