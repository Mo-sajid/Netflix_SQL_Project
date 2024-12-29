-- Netflix Projects--
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
)
select * from netflix;

select
 count(*)  as Total_count
from netflix;

select
 DISTINCT type
from netflix;

------------ 1.Count the number of movies as TV show?----------------

select 
 type,
 count(*) as Total_Content
from netflix
group by type;

------------- 2.Find the most common Rating movies and TV Shows---------------

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
 ranking = 1

 ------- 3.List all the movies released in a specific  year (e.g., 2020) ----
 select * from netflix
 where
 		type = 'Movie'
		 AND
		 release_year = 2020

--------- 4.Find the top 5 countries with the most content on Netflix--------
select 
	 unnest(string_to_array(country, ',')) as new_country,
	count(show_id) as total_content
from netflix
group by 1
order by 2 DESC
limit 5

select unnest(string_to_array(country, ',')) as new_country
from netflix  

-------- 5.Identify the longest movie?-------------
select * from netflix
where
 		type = 'Movie'
		 AND
		 duration = (select MAX(duration) from netflix)

--------- 6.Find content added in the last five years---------------
select 
		*
		
from netflix
where 
		To_Date(date_added, 'Month DD, YY') >= CURRENT_DATE - interval '5 years'

----- 7.Find all TV movies/shows by director 'Rajiv Chilaka'?---------
select 
		type,
		director
from netflix
where director like '%Rajiv Chilaka%'

-- ---- 8.List all TV Show with more then five seasons
select 
		*
from netflix
where 
		type = 'TV Show'
		AND
		SPLIT_PART(duration, ' ', 1)::numeric> 5

---------- 9.Count the number of content items in each genre? ----------
select 
		unnest(string_to_array(listed_in, ',')) as genre,
		count(show_id) as Total_content
from netflix
group by genre

-------- 10.find each years and find numbers of content release by India on netflix. 
----Return top 5 years with highest avg content release! ----------
SELECT
		EXTRACT(YEAR FROM To_Date(date_added, ' Month DD, YYYY')) as date,		
		count(*) as yearly_content,
		round(
		count(*)::numeric/( Select count(*) from netflix where country = 'India')::numeric * 100
		, 2) as avg_content_for_Year
from netflix
where country = 'India'
group by 1


--------- 11.List all movies that are  -------------
select * from netflix
where
		listed_in like '%Documentaries%'


---------- 12.Find all content without a director -------
select * from netflix
where 
		director is null

----------- 13.How many movies actor 'Salman Khan' appeared in last 10 years! -------
select * from netflix
where 	
		casts ilike '%Salman Khan%'
		and
		release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10

------------ 14. Find the top 10 actors who have appeared in  the highest number of movies produced in the India.

select 
		unnest(string_to_array(casts, ',')) as actor,
		count(*) as total_content
from netflix
where
		country ilike '%india%'
group by 1
order by 2 DESC
limit 10
 
		 