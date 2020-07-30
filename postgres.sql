-- Intro to PostgreSQL
SELECT * FROM country;
code, name, continent, region, surfacearea, indepyear, population, lifeexpectancy, gnp, gnpold, localname, governmentform, headofstate, capital, code2
-- Challenges: SQL Country Database

-- WHERE
-- What is the population of the US? (HINT: 278357000)
-- Notes: WHERE returns a boolean value, can logical AND and OR operators
SELECT code, population FROM country WHERE code='USA';

-- What is the area of the US? (HINT: 9.36352e+06)
SELECT code, surfacearea FROM country WHERE code='USA';

-- Which countries gained their independence before 1963?
SELECT name, indepyear FROM country WHERE indepyear < 1963

-- List the countries in Africa that have a population smaller than 30,000,000 and a life expectancy of more than 45? (HINT: 37 entries)
SELECT name, continent, population, lifeexpectancy FROM country WHERE continent='Africa' AND population < 30000000 AND lifeexpectancy > 45;

-- Which countries are something *like* a republic? (HINT: Are there 122 or 143?)
SELECT name, governmentform FROM country WHERE governmentform LIKE 'Republic';

SELECT name, governmentform FROM country WHERE governmentform LIKE '%Republic%';

-- Which countries are some kind of republic and achieved independence after 1945? (HINT: 92 entries)
SELECT name, governmentform, indepyear FROM country WHERE governmentform LIKE '%Republic%' AND indepyear > 1945;

-- Which countries achieved independence after 1945 and are *not* some kind of republic? (HINT: 27 entries)
SELECT name, governmentform, indepyear FROM country WHERE NOT governmentform LIKE '%Republic%' AND indepyear > 1945;


-- ORDER BY
-- Which fifteen countries have the lowest life expectancy? (HINT: starts with Zambia, ends with Sierra Leonne)
SELECT name, lifeexpectancy FROM country ORDER BY lifeexpectancy LIMIT 15;

-- Which fifteen countries have the highest life expectancy? (HINT: starts with Andorra, ends with Spain)
SELECT name, lifeexpectancy FROM country WHERE lifeexpectancy IS NOT NULL ORDER BY lifeexpectancy DESC LIMIT 15;

-- Which five countries have the lowest population density (density = population / surfacearea)? (HINT: starts with Greenland)
SELECT name, population, surfacearea, population / surfacearea AS density FROM country WHERE population != 0 ORDER BY density LIMIT 5;

-- Which countries have the highest population density?(HINT: starts with Macao)
SELECT name, population, surfacearea, population / surfacearea AS density FROM country ORDER BY density DESC LIMIT 5;

-- Which is the smallest country, by area and population (first by area - .4, then by population - 50)?
-- area
SELECT name, surfacearea, population FROM country WHERE population != 0 ORDER BY surfacearea LIMIT 1;

-- population
SELECT name, surfacearea, population FROM country WHERE population != 0 ORDER BY population LIMIT 1;

-- Which is the biggest country, by area and population (first by area - 1.70754e+07, then by population - 1277558000)?
-- area
SELECT name, surfacearea, population FROM country ORDER BY surfacearea DESC LIMIT 1;

-- population
SELECT name, surfacearea, population FROM country ORDER BY population DESC LIMIT 1;

-- Subqueries: WITH

-- What are the forms of government for the top ten countries by surface area? (HINT: Number 10 is Kazakstan)
WITH top_ten AS (SELECT name, surfacearea, governmentform FROM country ORDER BY surfacearea DESC LIMIT 10) SELECT name, governmentform FROM top_ten;

-- What are the forms of government for the top ten richest nations? (technically most productive)
WITH top_ten AS (SELECT name, gnp, governmentform FROM country ORDER BY gnp DESC LIMIT 10) SELECT name, governmentform FROM top_ten


-- Aggregate Functions: GROUP BY
-- Which region has the highest average gnp? (HINT: North America)
SELECT region, avg(gnp) AS avggnp FROM country GROUP BY region ORDER BY avggnp DESC LIMIT 1;

-- Who is the most influential head of state measured by population? (HINT: Jiang Zemin)
SELECT headofstate, sum(population) FROM country GROUP BY headofstate ORDER BY sum DESC LIMIT 1;

-- Who is the most influential head of state measured by surface area? (HINT: Elisabeth II)
SELECT headofstate, sum(surfacearea) FROM country GROUP BY headofstate ORDER BY sum DESC LIMIT 1;

-- What is the average life expectancy for all continents?
SELECT continent, avg(lifeexpectancy) FROM country GROUP BY continent

-- What are the most common forms of government? (HINT: use `count(*)`)
SELECT governmentform, count(*) FROM country GROUP BY governmentform ORDER BY count DESC LIMIT 5;

-- How many countries are in North America?
SELECT region, count(name) FROM country WHERE region='North America' GROUP BY region

-- What is the total population of all continents?
SELECT continent, sum(population) FROM country GROUP BY continent


-- Stretch Challenges

-- Which countries have the letter ‘z’ in the name? How many?
-- names
SELECT name FROM country WHERE name LIKE '%z%'

-- total
WITH total AS (SELECT name FROM country WHERE name LIKE '%z%') SELECT count(*) FROM total

-- Of the smallest 10 countries by area, which has the biggest gnp? (HINT: Macao)
WITH smallest AS (SELECT name, surfacearea, gnp FROM country ORDER BY surfacearea LIMIT 10) SELECT name, gnp FROM smallest ORDER BY gnp DESC LIMIT 1

-- Of the smallest 10 countries by population, which has the biggest per capita gnp?
WITH smallest AS (SELECT name, population, gnp FROM country WHERE population != 0 ORDER BY population LIMIT 10) SELECT name, gnp / population AS per_capita FROM smallest ORDER BY per_capita DESC LIMIT 1

-- Of the biggest 10 countries by area, which has the biggest gnp?
WITH biggest AS (SELECT name, surfacearea, gnp FROM country ORDER BY surfacearea DESC LIMIT 10) SELECT name, gnp FROM biggest ORDER BY gnp DESC LIMIT 1

-- Of the biggest 10 countries by population, which has the biggest per capita gnp?
WITH biggest AS (SELECT name, population, gnp FROM country ORDER BY population DESC LIMIT 10) SELECT name, gnp / population AS per_capita FROM biggest ORDER BY per_capita DESC LIMIT 1

-- What is the sum of surface area of the 10 biggest countries in the world by surface area? The 10 smallest by surface area?
-- biggest
WITH biggest AS (SELECT name, surfacearea FROM country ORDER BY surfacearea DESC LIMIT 10) SELECT sum(surfacearea) FROM biggest

-- smallest
WITH smallest AS (SELECT name, surfacearea FROM country ORDER BY surfacearea LIMIT 10) SELECT sum(surfacearea) FROM smallest

-- What year is this country database from? Cross reference various pieces of information to determine the age of this database.
-- 2003-2004
