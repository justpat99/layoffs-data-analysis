# Layoffs Data Analysis

This project analyzes global layoffs data using MySQL, focusing on data cleaning and exploratory data analysis to uncover trends across companies, countries, and time.

## Objectives

- Identify layoff trends over time
- Analyze which companies and countries are most effected
- Explore layoff patterns across different company stages

## Data Cleaning

- Removed duplicate records using ROW_NUMBER
- Standardized text data (company, country, industry)
- Converted date format from TEXT to DATE
- Handled missing values

## Exploratory Data Analysis

- Total layoffs by company and country
- Yearly and monthly trends
- Top companies with highest layoffs per year
- Rolling total of layoffs over time
- Analysis by company stages

## Key Insights

- Layoffs peaked significantly in 2022, which means economic was affeced during the pandemic.
- The United Stages experienced the highest number of layoffs.
- Many companies had 100% layoffs, indicating possible shutdowns.
- The tech industry and well-funded companies were affected.

## Tools Used

MySQL (Data Cleaning & Analysis)

## Files

- `data_cleaning.sql` - Data preparation and cleaning
- `data_analysis.sql` - Exploratory data analysis queries
- `layoffs.csv` - Dataset used

## Credits

This project is based on a tutorial by Alex The Analysis.
Tutorial Link: [Data Cleaning](https://youtu.be/4UltKCnnnTA?si=hAZP9khcc-zJdKz2) and [Data Analysis](https://youtu.be/QYd-RtK58VQ?si=kPlLL51iGJ-ArXBp).
I followed the tutorial to understand the data cleaning and exploratory data analysis process, and added my own explanations and improvements.
