# Layoffs Data Analysis

This project analyzes global layoffs data using MySQL.
The goal is to clean the dataset and explore trends in layoffs across companies, countries, and time.

## Data Cleaning using MySQL

- Removed duplicate records using ROW_NUMBER
- Standardized text data (company, country, industry)
- Converted date format from TEXT to DATE
- Handled missing values

## Exploratory Data Analysis

- Layoffs by company
- Layoffs by country
- Yearly and monthly trends
- Top companies with highest layoffs
- Rolling total of layoffs over time

## Insights

- Some companies had 100% layoffs, which means they were possible to shut down
- Layoffs are concentrated in certain countries (e.g., United States)
- Layoffs increased during specific years
- Companies with higher funding tend to have larger layoffs

## Files

- `data_cleaning.sql` - Data preparation and cleaning
- `data_analysis.sql` - Exploratory data analysis queries
- `layoffs.csv` - Dataset used

## Credits

This project is based on a tutorial by Alex The Analysis.
Tutorial Link: [Data Cleaning](https://youtu.be/4UltKCnnnTA?si=hAZP9khcc-zJdKz2) and [Data Analysis](https://youtu.be/QYd-RtK58VQ?si=kPlLL51iGJ-ArXBp).
I followed the tutorial to understand the data cleaning and exploratory data analysis process, and added my own explanations and improvements.
