-- Intro to PostgreSQL
SELECT * FROM country;
code, name, continent, region, surfacearea, indepyear, population, lifeexpectancy, gnp, gnpold, localname, governmentform, headofstate, capital, code2
-- Challenges: SQL Country Database

-- WHERE
-- What is the population of the US? (HINT: starts with 2, ends with 000)
-- Notes: WHERE returns a boolean value, can logical AND and OR operators
SELECT code, population FROM country WHERE code='USA';

-- What is the area of the US? (starts with 9, ends with million square miles)
SELECT code, surfacearea FROM country WHERE code='USA';

-- List the countries in Africa that have a population smaller than 30,000,000 and a life expectancy of more than 45? (all 37 of them)
SELECT name, continent, population, lifeexpectancy FROM country WHERE continent='Africa' AND population < 30000000 AND lifeexpectancy > 45;

-- Which countries are something like a republic? (are there 122 or 143 countries or ?)
SELECT name, governmentform FROM country WHERE governmentform LIKE 'Republic';

SELECT name, governmentform FROM country WHERE governmentform LIKE '%Republic%';


-- Which countries are some kind of republic and achieved independence after 1945?
SELECT name, governmentform, indepyear FROM country WHERE governmentform LIKE '%Republic%' AND indepyear > 1945;

-- Which countries achieved independence after 1945 and are not some kind of republic?
SELECT name, governmentform, indepyear FROM country WHERE NOT governmentform LIKE '%Republic%' AND indepyear > 1945;


-- ORDER BY
-- Which fifteen countries have the lowest life expectancy?
SELECT name, lifeexpectancy FROM country ORDER BY lifeexpectancy LIMIT 15;

-- Which fifteen countries have the highest life expectancy?
SELECT name, lifeexpectancy FROM country WHERE lifeexpectancy IS NOT NULL ORDER BY lifeexpectancy DESC LIMIT 15;

-- Which five countries have the lowest population density (density = population / surfacearea)?
SELECT name, population, surfacearea, population / surfacearea AS density FROM country WHERE population != 0 ORDER BY density LIMIT 5;

-- Which countries have the highest population density?
SELECT name, population, surfacearea, population / surfacearea AS density FROM country ORDER BY density DESC LIMIT 5;

-- Which is the smallest country, by area and population (first by area, then by population)?
SELECT name, surfacearea, population FROM country WHERE population != 0 ORDER BY surfacearea LIMIT 1;

SELECT name, surfacearea, population FROM country WHERE population != 0 ORDER BY population LIMIT 1;

-- Which is the biggest country, by area and population (first by area, then by population)?
SELECT name, surfacearea, population FROM country ORDER BY population DESC LIMIT 1;

SELECT name, surfacearea, population FROM country ORDER BY surfacearea DESC LIMIT 1;


-- GROUP BY
-- Which region has the highest average gnp?
SELECT region, avg(gnp) AS avggnp FROM country GROUP BY region ORDER BY avggnp DESC LIMIT 1;

-- Who is the most influential head of state measured by population?
SELECT headofstate, sum(population) FROM country GROUP BY headofstate ORDER BY sum DESC LIMIT 1;

-- Who is the most influential head of state measured by surface area?
SELECT headofstate, sum(surfacearea) FROM country GROUP BY headofstate ORDER BY sum DESC LIMIT 1;

-- What are the most common forms of government? (hint: use count(*))
SELECT governmentform, count(*) FROM country GROUP BY governmentform ORDER BY count DESC LIMIT 5;

-- What are the forms of government for the top ten countries by surface area?
WITH top_ten AS SELECT name, surfacearea, governmentform FROM country ORDER BY surfacearea DESC LIMIT 10 SELECT name, governmentform FROM country

-- What are the forms of government for the top ten richest nations? (technically most productive)
-- What are the forms of government for the top ten richest per capita nations? (technically most productive)


-- Stretch Challenges
-- What year is this country database from? Cross reference various pieces of information to determine the age of this database.
-- How many countries are in North America?
SELECT region, count(name) FROM country WHERE region='North America' GROUP BY region

-- Which countries gained their independence before 1963?

-- What is the total population of all continents?
-- What is the average life expectancy for all continents?
-- Which countries have the letter ‘z’ in the name? How many?
-- WITH
-- Of the smallest 10 countries, which has the biggest gnp? (hint: use WITH and LIMIT)
-- Of the smallest 10 countries, which has the biggest per capita gnp?
-- Of the biggest 10 countries, which has the biggest gnp?
-- Of the biggest 10 countries, which has the biggest per capita gnp?
-- What is the sum of surface area of the 10 biggest countries in the world? The 10 smallest?
