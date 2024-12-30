# Netflix Movies and TV Shows Data  Analysis using SQL
![Netflix Logo](https://github.com/Mo-sajid/Netflix_SQL_Project/blob/main/Netflix%20Logo.jpg)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions

## Objective
- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset
The data for this project is sourced from the Kaggle dataset:
- Dataset Link: [Netflix Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)


# Netflix Database Schema

This repository contains the schema and usage examples for the `netflix` database, which stores data about Netflix shows and movies.

## Schema

```sql
CREATE TABLE netflix
(
    show_id VARCHAR(6),	
    type  VARCHAR(10),
    title VARCHAR(120),
    director VARCHAR(220),
    casts VARCHAR(820),
    country VARCHAR(130),
    date_added VARCHAR(25),
    release_year INT,
    rating VARCHAR(15),
    duration VARCHAR(12),
    listed_in VARCHAR(90),
    description VARCHAR(270)
);
```


## Business Problems and Solutions

This section highlights business problems related to Netflix's content catalog and the SQL solutions to address them.

### Problem: How many Movies and TV Shows are available in the database?

#### SQL Query:
```sql
SELECT 
    type,
    COUNT(*)
FROM netflix
GROUP BY 1;



