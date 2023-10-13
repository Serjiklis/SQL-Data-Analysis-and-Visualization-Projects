-- Select Data that we are going to be using

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1,2
LIMIT 300;

-- Total Cases vs Total Death

SELECT  location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths
WHERE location LIKE 'Ukraine'
ORDER BY total_cases desc;

-- Total Cases vs Population
SELECT  location, date, total_cases, population, ( total_cases/ population)*100 as  TotalCasesPercentage, total_deaths
FROM CovidDeaths
WHERE location LIKE 'Ukraine'
ORDER BY total_cases desc;

-- Countries with Higest Infection Rate compared Population
SELECT  location, max(total_cases) HighestInfectionCount, max(population),  (max(total_cases)/ max(population))*100 as Percent,  (max(total_deaths)/max(total_cases))*100 as DeathPercentage
FROM CovidDeaths
GROUP BY location
ORDER BY Percent DESC;


-- Total deaths by continent
SELECT continent, max(total_deaths)
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent;

-- Chesk values
SELECT location, max(total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From CovidDeaths
where continent is not null
order by 1,2;

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
       SUM(CV.new_vaccinations) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date)
            AS RollingPeopleVactination
FROM CovidDeaths AS CD
JOIN CovidVactinations CV
    ON CD.location = CV.location
    AND CD.date = CV.date
where CD.continent is not null and CD.new_vaccinations  is not null
ORDER BY 1,2,3;

-- USE CTE
WITH PopvsVac ( continent, location, date, population, new_vaccinations,RollingPeopleVactination)
AS (
        SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
               SUM(CV.new_vaccinations) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date)
                   AS RollingPeopleVactination
        FROM CovidDeaths AS CD
                 JOIN CovidVactinations CV
                      ON CD.location = CV.location
                          AND CD.date = CV.date
        where CD.continent is not null and CD.new_vaccinations  is not null
        ORDER BY 1,2,3
    )
    SELECT *, (RollingPeopleVactination/population)*100
    FROM PopvsVac;

-- TEMP TABLE
DROP TABLE IF EXISTS PercentPopulationVaccinated;

CREATE TEMPORARY TABLE PercentPopulationVaccinated
(
    Continent VARCHAR(50),
    Location VARCHAR(50),
    Date DATE,
    Population BIGINT,
    New_vaccinations INT,
    RollingPeopleVaccinated INT
);

INSERT INTO PercentPopulationVaccinated
    SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
    SUM(CV.new_vaccinations) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date)
    AS RollingPeopleVactination
FROM CovidDeaths AS CD
    JOIN CovidVactinations CV
ON CD.location = CV.location
    AND CD.date = CV.date;

Select *, (RollingPeopleVaccinated/Population)*100
From PercentPopulationVaccinated
where continent is not null and new_vaccinations  is not null;

-- Creating Views to store data for later visualizations

Create View PercentPopulationVaccinated AS
Select CD.continent, CD.location, CD.date, CD.population,  CV.new_vaccinations
     , SUM(CD.new_vaccinations) OVER (Partition by CD.Location Order by CD.location, CD.Date) as RollingPeopleVaccinated
From CovidDeaths CD
Join CovidVactinations CV
	On CD.location = CV.location
	and CD.date = CV.date
where CD.continent is not null;

CREATE VIEW GlobalNumbers AS
Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From CovidDeaths
where continent is not null
order by 1,2;

CREATE VIEW TotalDeathsContinent AS
SELECT continent, max(total_deaths)
FROM CovidDeaths
    WHERE continent IS NOT NULL
    GROUP BY continent;





