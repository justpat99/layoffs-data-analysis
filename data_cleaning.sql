-- Data Cleaning
-- This script performs data cleaning on layoffs dataset
-- Including duplicate removal, standardization, and handling missing values



-- Prepare the dataset

-- Step 1: Create a new database
drop database if exists world_layoffs;
create database world_layoffs;
use world_layoffs;

-- Step 2: Import table of csv file using code based instead of Table Data Import Wizard
SET GLOBAL local_infile = 1;

CREATE TABLE layoffs (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT,
    percentage_laid_off FLOAT,
    date TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions INT
);

-- Note: Update file path based on your local machine
LOAD DATA LOCAL INFILE '/Users/pat/Documents/Project/MySQL Exploratory Data Analysis/layoffs.csv' 
INTO TABLE layoffs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from layoffs;

-- Step 3: Create a stage table
drop table if exists layoffs_staging;
create table layoffs_staging 
like layoffs;

insert layoffs_staging
select * from layoffs;

select * from layoffs_staging; 



-- Start cleaning data


-- 1. Remove duplicates

-- Step 4: Identify duplicate values using row_number 
with duplicate_cte as (
select *, row_number() over(
partition by company, location,  industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

-- MySQL does not support DELETE from CTE, so I use the next step instead
-- with duplicate_cte as (
-- select *, row_number() over(
-- partition by company, location,  industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
-- from layoffs_staging
-- )
-- delete 
-- from duplicate_cte
-- where row_num > 1;

-- Step 5: Create a new staging table and remove duplicates using row_number
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2;

insert into layoffs_staging2
select *, row_number() over(
partition by company, location,  industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

delete
from layoffs_staging2
where row_num > 1; 

select * from layoffs_staging2
where row_num > 1; 



-- 2. Standardizing data

-- Step 6: Standardize text data (remove leading/trailing spaces)
select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct country
from layoffs_staging2
order by 1;

select distinct country, trim(trailing '.' from country)
from layoffs_staging2;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

-- Step 7: Convert date from TEXT to DATE format
select `date`
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;



-- 3. Null values or blank values

-- Step 8: Fill industry missing values with the existing data of the same company and location
select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

update layoffs_staging2
set industry = null
where industry = '';

select *
from layoffs_staging2
where industry is null
or industry = '';

select *
from layoffs_staging2
where company like 'Bally%';

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
	and t1.location = t2.location
where (t1.industry is null or t1.industry = '') and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null) and t2.industry is not null;

-- Step 9: Remove rows where both total_laid_off and percentage_laid_off are NULL
select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;



-- 4. Remove any rows/columns

-- Step 10: Drop helper column (row_num)
select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;



-- Final cleaned dataset ready for analysis
select * from layoffs_staging2;