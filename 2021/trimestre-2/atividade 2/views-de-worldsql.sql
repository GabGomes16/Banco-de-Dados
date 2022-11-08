use world;

CREATE VIEW vw_viewCity AS
SELECT ID, Name
FROM city;

SELECT *
FROM vw_viewCity
LIMIT 3;

CREATE OR REPLACE VIEW vw_viewCity AS
SELECT Name
FROM city;

SELECT *
FROM vw_viewCity
LIMIT 3;

CREATE VIEW vw_countryLangCount AS
SELECT Name, Count(Language) AS LangCount
FROM country, countrylanguage
WHERE Code = CountryCode
Group by Name;

SELECT * FROM vw_countryLangCount LIMIT 3;

CREATE TABLE CountryPop
SELECT Name, Population, Continent
FROM country;

CREATE TABLE EuroPop AS
SELECT Name, Population
FROM CountryPop
WHERE Continent = 'Europe';

UPDATE EuroPop
SET Population = Population * 1
WHERE Name = 'San Marino';

SELECT *
FROM EuroPop
WHERE Name = 'San Marino';

CREATE VIEW vw_largePop AS
SELECT Name, Population
FROM CountryPop
WHERE Population >= 100000000
WITH CHECK OPTION;

SELECT *
FROM vw_largePop;