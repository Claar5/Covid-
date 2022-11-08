select * 
from vacanation
order  by 3,4;

select *
from deaths
order by 3,4;

---select data that we are going to be using
select location, date2, total_cases, new_cases, total_deaths, population
from deaths
order by 1,2;
---ordered by location and date

---Total death vs Total cases or south africa
---Shows the likelihood of dying if you contract covid in RSA
select location, date2, total_cases, total_deaths, population, (total_deaths / total_cases)*100 as DeathPercentage
from deaths
where location like '%South Africa%'
order by 1,2;

---Total cases vs Population for RSA
select location, date2,  population, total_cases, (total_cases/ population)*100 as Percentage
from deaths
where location like '%South Africa%'
order by 1,2;

---locations highest infection rate in Africa from largest
select location,  population, MAX(total_cases) as HighestInfection,  MAX((total_cases/ population))*100 as Percentage
from deaths
group by location, population
order by HighestInfection desc;

---Highest death rate per Location in Africa
select location, MAX(total_deaths) as TotalDeath
from deaths
where total_deaths is not null
group by location
order by TotalDeath desc;

---https://www.youtube.com/watch?v=qfyynHBFOsM

---New cases rate per new deaths
select date2, SUM(new_cases) as TotalCases,  SUM(new_deaths) as TotalDeaths, (SUM(new_deaths)/SUM(new_cases))*100 as Percentage
from deaths
where continent is not null
group by date2
order by 1,2;
 
 --Overall death rate now
select SUM(new_cases) as TotalCases,  SUM(new_deaths) as TotalDeaths, (SUM(new_deaths)/SUM(new_cases))*100 as Percentage
from deaths
where continent is not null
order by 1,2;

--Total population vs total vaccinations currently

--use cte
with PopvsVac ( Location, Population, PeopleVaccinated)
as(
select dea.location, dea.population, MAX(vac.total_vaccinations) as TotalVaccinated
from deaths dea
join vacanation vac on dea.location = vac.location
and dea.date2 = vac.date3
group by dea.location, dea.population
--order by 1,2
)

select location, population, peoplevaccinated, (PeopleVaccinated/Population)*100
from PopvsVac;

--Temp table
create table PercentVaccinated(
    location varchar(255),
    population int ,
    totalVaccinated int
);

insert into PercentVaccinated
select dea.location, dea.population, MAX(vac.total_vaccinations) as TotalVaccinated
from deaths dea
join vacanation vac on dea.location = vac.location
and dea.date2 = vac.date3
group by dea.location, dea.population
order by 1,2








