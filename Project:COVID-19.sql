--Data Exploration
Select *
From PortfolioProject..CovidDeaths
order by 3,4;

Select *
From PortfolioProject..CovidVaccinations
order by 3,4;

Select Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
order by 1,2;

--Percentage of total COVID-19 cases resulting in death over time, by country
Select location, date, total_cases, total_deaths,
ROUND((CONVERT(float, total_deaths)/NULLIF(CONVERT(float, total_cases),0))*100,2) AS DeathPercentage
FROM PortfolioProject..CovidDeaths
order by 1,2;

--Total cases per capita over time, by country
Select location, date, total_cases, population,
ROUND((NULLIF(CONVERT(float, total_cases),0)/POPULATION)*100,2) AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
order by 1,2;

--Countries with the highest COVID-19 infection rates relative to their populations
SELECT
    location,
    population,
	MAX(total_cases) AS HighestInfectionCount,
    ROUND(MAX(CAST(total_cases AS float) / NULLIF(population, 0)) * 100,2) AS PercentPopulation
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulation DESC;

--Continents ranked by total COVID-19 deaths, summed from each country's highest reported count.
WITH Max_death AS (Select Location,continent, Max(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by location,continent)
SELECT continent, SUM(TotalDeathCount) AS Total_death_by_continent
FROM Max_death
GROUP BY continent
ORDER BY Total_death_by_continent desc;

 -- Global Numbers
 SELECT
    continent,
    total_deaths,
    total_cases,
    CASE
        WHEN total_cases = 0 THEN 0
        ELSE ROUND(SUM(CONVERT(float, total_deaths) / total_cases) * 100,2)
    END AS DeathPercentage
FROM
    PortfolioProject..CovidDeaths
WHERE
    continent IS NOT NULL
GROUP BY
    continent,total_deaths,total_cases;

Select continent, SUM(new_cases) AS total_cases, SUM(new_deaths) as total_deaths, ROUND((SUM(New_deaths)/NULLIF(SUM(New_Cases),0))*100, 2) AS DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null
Group by continent
order by DeathPercentage desc;


--COVID-19 vaccination rates by Country(Using CTEs and Joins)
WITH PopvsVAC (Continent, location, Date, Population, new_vaccinations, Cumulativevaccination) 
AS (
    SELECT 
        dea.continent, 
        dea.location,
        vac.date, 
        dea.population, 
        vac.new_vaccinations, 
        SUM(CAST(vac.new_vaccinations AS float)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.date) AS Cumulativevaccination
    FROM PortfolioProject..CovidDeaths dea
    JOIN PortfolioProject..CovidVaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT 
    Continent,
    location,
    Population,
    MAX(Cumulativevaccination) AS TotalVaccinations,
    ROUND((MAX(Cumulativevaccination) / Population) * 100, 2) AS PercentPopulationVaccinated
FROM PopvsVAC
GROUP BY Continent, location, Population
ORDER BY PercentPopulationVaccinated DESC;

--Tracking cumulative COVID-19 vaccination percentages by location over time using temporary tables.
DROP TABLE IF exists #Percentpopulationvaccinated
Create Table #Percentpopulationvaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
Cumulativevaccination numeric
)
INSERT INTO #Percentpopulationvaccinated
Select dea.continent, dea.location ,vac.date, dea.population, vac.new_vaccinations, 
(SUM(CAST(vac.new_vaccinations as float)) OVER (Partition by dea.Location order by dea.location,dea.date) as Cumulativevaccination
--,(Cumulativevaccination/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
    On dea.location =vac.location
	and dea.date =vac.date
where dea.continent is not null
--order by 2,3

Select *, (Cumulativevaccination/Population)*100 as CumVaccPercent
From #Percentpopulationvaccinated;

--Creating view to store data for visualizations
CREATE VIEW Total_deaths_per_continent AS 
SELECT continent, SUM(TotalDeathCount) AS Total_death_by_continent
FROM (
    SELECT Location, continent, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
    FROM PortfolioProject..CovidDeaths
    WHERE continent IS NOT NULL
    GROUP BY location, continent
) AS Max_death
GROUP BY continent;
