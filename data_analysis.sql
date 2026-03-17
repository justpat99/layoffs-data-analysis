-- Exploratory Data Analysis on Layoffs Dataset
-- Objective: Analyze layoff trends by company, country, and time



use world_layoffs;

-- Preview the cleaned dataset
select *
from layoffs_staging2;

-- What is the maximum number and percentage of layoffs recorded?
select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

-- Which companies laid off 100% of their employees?
-- (Potential company shutdowns)
select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

-- Which companies have the highest total layoffs?
select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

-- What is the time range of the dataset?
select min(`date`), max(`date`)
from layoffs_staging2;

-- Which countries are most affected by layoffs?
select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

-- How have layoffs changed over the years?
select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

-- Which company stages have the most layoffs?
select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

-- Average percentage of layoffs by company
select company, avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

-- Monthly layoffs trend
select substring(`date`, 1, 7) as `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc;


-- Rolling total of layoffs over time
with Rolling_Total as (
select substring(`date`, 1, 7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc
)
select `month`, total_off, sum(total_off) over(order by `month`) as rolling_total
from Rolling_Total;

-- Total layoffs per company per year
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc;

-- Top 5 companies with the highest layoffs each year
with Company_year (company, years, total_laid_off) as (
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
), Company_Year_Rank as (
select *, dense_rank() over(partition by years order by total_laid_off desc) as Ranking
from Company_year
where years is not null
order by Ranking asc)
select *
from Company_Year_Rank
where Ranking <= 5;



-- Key insights:
-- 1. Certain companies experienced complete layoffs (100%), indicating shutdowns
-- 2. Layoffs are concentrated in specific countries such as United States
-- 3. Layoffs increased significantly during certain years
-- 4. Larger companies tend to have higher total layoffs