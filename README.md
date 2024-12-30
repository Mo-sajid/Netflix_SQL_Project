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

### 1. Count the Number of Movies vs TV Shows?

#### SQL Query:
```sql
SELECT 
    type,
    COUNT(*)
FROM netflix
GROUP BY 1;
```

### 2. Find the Most Common Rating for Movies and TV Shows?

#### SQL Query:
```sql
SELECT
	type,
	rating
from
(
select 
type,
rating,
count(*),
RANK() OVER(PARTITION BY TYPE ORDER BY COUNT(*) DESC) as ranking
from netflix
GROUP BY 1, 2
) AS T1
where
 ranking = 1;
```

### 3.List all the movies released in a specific  year (e.g., 2020)?
#### SQL Query:
```
select * from netflix
 where
 		type = 'Movie'
		 AND
		 release_year = 2020;
```

### 4.Find the top 5 countries with the most content on Netflix?
#### SQL Query:
```
select 
	 unnest(string_to_array(country, ',')) as new_country,
	count(show_id) as total_content
from netflix
group by 1
order by 2 DESC
limit 5

select unnest(string_to_array(country, ',')) as new_country
from netflix;
```

### 5.Identify the longest movie?
#### SQL Query:
```
select * from netflix
where
 		type = 'Movie'
		 AND
		 duration = (select MAX(duration) from netflix);
```

### 6.Find content added in the last five years?
#### SQL Query:
```
select 
		*
		
from netflix
where 
		To_Date(date_added, 'Month DD, YY') >= CURRENT_DATE - interval '5 years';
```

### 7.Find all TV movies/shows by director 'Rajiv Chilaka'?
#### SQL Query:
```
select 
		type,
		director
from netflix
where director like '%Rajiv Chilaka%';
```

### 8.List all TV Show with more then five seasons?
#### SQL Query:
```
select 
		*
from netflix
where 
		type = 'TV Show'
		AND
		SPLIT_PART(duration, ' ', 1)::numeric> 5;
```

### 9.Count the number of content items in each genre?
#### SQL Query:
```
select 
		unnest(string_to_array(listed_in, ',')) as genre,
		count(show_id) as Total_content
from netflix
group by genre;
```

### 10.find each years and find numbers of content release by India on netflix. Return top 5 years with highest avg content release! 
#### SQL Query:
```
SELECT
		EXTRACT(YEAR FROM To_Date(date_added, ' Month DD, YYYY')) as date,		
		count(*) as yearly_content,
		round(
		count(*)::numeric/( Select count(*) from netflix where country = 'India')::numeric * 100
		, 2) as avg_content_for_Year
from netflix
where country = 'India'
group by 1;
```

### 11.List all movies that are?
#### SQL Query:
```
select * from netflix
where
		listed_in like '%Documentaries%'; 
  ```

### 12.Find all content without a director?
#### SQL Query:
```
select * from netflix
where 
		director is null;
```

### 13.How many movies actor 'Salman Khan' appeared in last 10 years?
#### SQL Query:
```
select * from netflix
where 	
		casts ilike '%Salman Khan%'
		and
		release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

### 14. Find the top 10 actors who have appeared in the highest number of movies produced in the India?
#### SQL Query:
```
select 
		unnest(string_to_array(casts, ',')) as actor,
		count(*) as total_content
from netflix
where
		country ilike '%india%'
group by 1
order by 2 DESC
limit 10;
```

### 15.Categorize the content based on the presence of the keyward 'Kill'  and 'Violence' in the description field. Label contain containing these keywards as 'Bad' and all other cntent as good. count how many item fall each category?
#### SQL Query:
```
with new_table
as
(
select 
		*,
		Case
			when
				description ilike '%Kill%' or
				description ilike '%Violence%' then 'Bad_Content'
				else 'Good_Content'
				end Category
from netflix
)
select
		category,
		count(*) as Total_Content
from new_table
group by Category;
```
