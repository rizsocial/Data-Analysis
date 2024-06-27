## SQL Project: World Layoffs Dataset Analysis
### Project Overview
This project involves importing, cleaning, normalizing, and analyzing a dataset on global layoffs. The dataset, containing approximately 2300 rows, was imported into MySQL Workbench for thorough examination and manipulation.

### Data Cleaning:

- Identify and delete duplicate rows to ensure data integrity.
- Normalize the data by performing the following tasks:
  - Trim leading and trailing whitespace from all columns.
  - Correct misspelled categorical values.
  - Remove extraneous characters (e.g., dots) from the end of column values.
  - Convert dates stored as text into proper date format using STR_TO_DATE.
  - Replace null and blank values with appropriate defaults or delete them if necessary.
  - Remove any entire columns deemed unnecessary for analysis.

### Exploratory Data Analysis (EDA)

- Basic Metrics:
  - Calculate the total number of layoffs.
  - Determine the percentage of layoffs relative to the dataset.
  - Detailed Analysis by Category:
- Break down total layoffs by various dimensions:
  - Stage of Company: Identify how layoffs vary across different stages of companies.
  - Company Name: Analyze layoffs on a per-company basis.
  - Industry: Examine layoffs by industry to spot trends.
  - Country: Investigate the geographical distribution of layoffs.
  - Year (2020-2023): Assess layoffs across the years to understand temporal patterns.
  - Month: Conduct a monthly analysis to identify peak periods.
 
![1](https://github.com/rizsocial/Data-Analysis/blob/main/SQL%20Projects/World%20Layoffs%20Dataset%20Analysis/2.png)
![5](https://github.com/rizsocial/Data-Analysis/blob/main/SQL%20Projects/World%20Layoffs%20Dataset%20Analysis/5.png]
![12](https://github.com/rizsocial/Data-Analysis/blob/main/SQL%20Projects/World%20Layoffs%20Dataset%20Analysis/12.png)
![14](https://github.com/rizsocial/Data-Analysis/blob/main/SQL%20Projects/World%20Layoffs%20Dataset%20Analysis/14.png)

