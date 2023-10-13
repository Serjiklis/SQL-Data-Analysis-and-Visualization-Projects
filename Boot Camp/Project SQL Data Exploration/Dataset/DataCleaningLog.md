## Data Cleaning Log

### Author: SerhiiM
### Dataset:  [Coronavirus (COVID-19) Deaths](https://ourworldindata.org/covid-deaths)

### **Operation Details:** 
**Data preparation in Excel - "ovid-covid-data.csv"**
1. moved column 'population'
2. deleted columns after Z 
3. deleted value = 0, columns F->Z, row 2->55
4. Save as "CovidVactination.csv"
5. "ovid-covid-data.csv" (original) and "CovidVactination.csv" imported in MySql.

 **MySql data cleaning**
 
1. "When importing a CSV file into MySQL, I had to specify text cell formats for all values to prevent errors. 
    After this process, I discovered some cells with missing values. To avoid data type errors, I chose to fill these empty cells with the value 'NULL' to indicate the absence of a value."
   **Queries:**
```sql
-- Replace empty values with NULL 

UPDATE CovidDeaths
SET
    total_cases = CASE WHEN total_cases = '' THEN NULL ELSE total_cases END,
    continent = CASE WHEN continent = '' THEN NULL ELSE continent END,
    new_cases = CASE WHEN new_cases = '' THEN NULL ELSE new_cases END,
    new_cases_smoothed = CASE WHEN new_cases_smoothed = '' THEN NULL ELSE new_cases_smoothed END,
    new_deaths = CASE WHEN new_deaths = '' THEN NULL ELSE new_deaths END,
    new_vaccinations = CASE WHEN new_vaccinations = '' THEN NULL ELSE new_vaccinations END,
    total_deaths = CASE WHEN total_deaths = '' THEN NULL ELSE total_deaths END;
```
```sql
-- Change the data type of the column
ALTER TABLE CovidDeaths
    MODIFY COLUMN date DATE,
    MODIFY COLUMN iso_code VARCHAR(50),
    MODIFY COLUMN continent  VARCHAR(50),
    MODIFY COLUMN population BIGINT,
    MODIFY COLUMN location VARCHAR(50),
    MODIFY COLUMN total_cases BIGINT,
    MODIFY COLUMN new_cases INT,
    MODIFY COLUMN new_cases_smoothed FLOAT,
    MODIFY COLUMN new_deaths INT,
    MODIFY COLUMN new_vaccinations INT,
    MODIFY COLUMN total_deaths INT;
```

```Sql
-- Replace empty values with NULL 

UPDATE CovidVactinations
SET
    total_cases = CASE WHEN total_cases = '' THEN NULL ELSE total_cases END,
    continent = CASE WHEN continent = '' THEN NULL ELSE continent END,
    new_cases = CASE WHEN new_cases = '' THEN NULL ELSE new_cases END,
    new_cases_smoothed = CASE WHEN new_cases_smoothed = '' THEN NULL ELSE new_cases_smoothed END,
    new_deaths = CASE WHEN new_deaths = '' THEN NULL ELSE new_deaths END,
    total_deaths = CASE WHEN total_deaths = '' THEN NULL ELSE total_deaths END,
    new_vaccinations = CASE WHEN new_vaccinationss = '' THEN NULL ELSE new_vaccinations END;
```

```sql
-- Change the data type of the column
ALTER TABLE  CovidVactinations
    MODIFY COLUMN date DATE,
    MODIFY COLUMN iso_code VARCHAR(50),
    MODIFY COLUMN continent  VARCHAR(50),
    MODIFY COLUMN population BIGINT,
    MODIFY COLUMN location VARCHAR(50),
    MODIFY COLUMN total_cases BIGINT,
    MODIFY COLUMN new_cases INT,
    MODIFY COLUMN new_cases_smoothed FLOAT,
    MODIFY COLUMN new_deaths INT,
    MODIFY COLUMN total_deaths INT,
    MODIFY COLUMN new_vaccinations INT;
```