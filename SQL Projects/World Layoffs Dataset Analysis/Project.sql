-- Data Cleaning and Exploratory Data Analysis in SQL

-- remove duplicates
-- standardize data
-- null values and blank values
-- remove any columns

select * from layoffs;

create table layoffs_staging
like layoffs;

insert layoffs_staging
select * from layoffs;

select *,
ROW_NUMBER() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging;

with duplicate_cte as
(
select *,
ROW_NUMBER() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging)
select * from duplicate_cte 
where row_num > 1; 

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
  `row_num` INT -- Adding the row_num column here
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2;

insert into layoffs_staging2
select *,
ROW_NUMBER() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging;

select * from layoffs_staging2
where row_num > 1;

delete from layoffs_staging2
where row_num > 1;

select * from layoffs_staging2
where row_num > 1;


-- standardizing data

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct(industry) from layoffs_staging2
order by 1;

select * from layoffs_staging2
where industry like 'crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct(location) from layoffs_staging2
order by 1;

select distinct(country) from layoffs_staging2
where country like 'United State%';

update layoffs_staging2
set country = 'United States'
where country like 'United State%';

-- another way to remove a dot or another character from the end of column values
select distinct(country), trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country);

select date, 
str_to_date(date, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set date = str_to_date(date, '%m/%d/%Y');

alter table layoffs_staging2
modify column date DATE;

select * from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

select * from layoffs_staging2
where industry is null or industry = '';

select * from layoffs_staging
where company = 'Airbnb';

select * from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company and t1.location = t2.location
where t1.industry = '' or t1.industry is null and t2.industry is not null;

update layoffs_staging2
set industry = null
where industry = '';


select t1.industry, t2.industry from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company and t1.location = t2.location
where (t1.industry is null) and (t2.industry is not null);

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null and t2.industry is not null;

select * from layoffs_staging2
where industry is null or industry = '';

select * from layoffs_staging2;

select count(*) from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

delete from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;


alter table layoffs_staging2
drop column row_num;


-- exploratory data analysis

select max(total_laid_off), max(percentage_laid_off) from layoffs_staging2;


select company, sum(total_laid_off)
from layoffs_staging2 
group by company
order by 2 desc;

select min(date), max(date)
from layoffs_staging2;

select industry, sum(total_laid_off)
from layoffs_staging2 
group by industry
order by 2 desc;

select country, sum(total_laid_off)
from layoffs_staging2 
group by country
order by 2 desc;

select year(date), sum(total_laid_off)
from layoffs_staging2 
group by year(date)
order by 2 desc;

select stage, sum(total_laid_off)
from layoffs_staging2 
group by stage
order by 2 desc;

select substring(date,1,7) as month, sum(total_laid_off) as total_layoffs
from layoffs_staging2
where substring(date,1,7) is not null
group by month
order by month;

with rolling_total as
(select substring(date,1,7) as month, sum(total_laid_off) as total_layoffs
from layoffs_staging2
where substring(date,1,7) is not null
group by month
order by month)
select month, total_layoffs, sum(total_layoffs) over(order by month) as rolling_sum
from rolling_total;

select company, year(date), sum(total_laid_off) from layoffs_staging2
group by company, year(date)
order by company;

with company_year(company, year, total_layoffs) as
(select company, year(date), sum(total_laid_off) from layoffs_staging2
group by company, year(date)
), company_year_rank as
(select *,
dense_rank() over(partition by year order by total_layoffs desc) AS ranking
from company_year
where year is not null)
select * from company_year_rank
where ranking <=5