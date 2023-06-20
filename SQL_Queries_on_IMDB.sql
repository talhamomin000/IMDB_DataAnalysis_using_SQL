
-- Basic SQL queries 

/*
SELECT * FROM title_ratings;
*/

/*
SELECT tconst,primaryTitle,originalTitle, runtimeMinutes, genres 
FROM title_basics;
*/

/*
SELECT distinct(category),tconst FROM title_principal;
*/

/*
SELECT count(*) from title_ratings;

SELECT min(averageRating) as minimum_rating,
	   max(averageRating) as maximum_rating,
	   avg(averageRating) as average_rating,
	   sum(numVotes) as total_no_of_votes
FROM title_ratings;
*


/*
SELECT * FROM title_basics
where startYear>1970 and startYear<2024;
*/

/*
select * from title_basics
where genres in ('Action', 'Comedy', 'Horror');
*/


/*
select * from title_basics
where primaryTitle like 'Batman%' and titleType='movie'
order by startYear;
*/

/*
SELECT * FROM title_basics
where startYear BETWEEN 2000 AND 2023;
*/

/*
select DISTINCT titleType, avg(runtimeMinutes)
FROM title_basics
GROUP by titleType;
*/


-- Queries using Substring

/*
--Retrieve the first 5 characters of the primaryTitle column in the title_basics table:
SELECT SUBSTRING(primaryTitle, 1, 5) AS short_title
FROM title_basics
LIMIT 10;
*/



-- Query using INNER JOIN
/*
select t.primaryTitle,t.startYear as releaseYear, r.averageRating
FROM title_basics as t
INNER JOIN title_ratings as r
on t.tconst=r.tconst
where startYear>1970 and titleType='movie' and runtimeMinutes >60
ORDER by r.averageRating DESC
LIMIT 500;
*/


-- Query using Case Statement
/*
SELECT t.primaryTitle ,t.startYear as releaseYear , averageRating,
CASE WHEN averageRating >=8 THEN 'Excellent'
     WHEN averageRating >=7 THEN 'Very Good'
	 WHEN averageRating >=6 THEN 'Good'
	 ELSE 'Average or Below'
	 END as rating_category
FROM title_basics as t
INNER JOIN title_ratings as r 
on t.tconst=r.tconst
WHERE t.startYear>1970
LIMIT 100;
*/


/*
SELECT 
    CASE 
        WHEN t.startYear >= 1970 AND t.startYear < 1980 THEN '1970s'
        WHEN t.startYear >= 1980 AND t.startYear < 1990 THEN '1980s'
        WHEN t.startYear >= 1990 AND t.startYear < 2000 THEN '1990s'
        WHEN t.startYear >= 2000 AND t.startYear < 2010 THEN '2000s'
        WHEN t.startYear >= 2010 AND t.startYear < 2020 THEN '2010s'
        WHEN t.startYear >= 2020 AND t.startYear < 2030 THEN '2020s'
        ELSE 'other'
    END AS decade,
    AVG(r.averageRating) AS average_rating
FROM title_basics AS t
INNER JOIN title_ratings AS r ON t.tconst = r.tconst
GROUP BY decade;
*/



-- Subqueries in WHERE,FROM,SELECT

/*
-- Find the title with the highest average rating:
SELECT primaryTitle , startYear
FROM title_basics
WHERE tconst = (
	SELECT tconst
	FROM title_ratings
	WHERE averageRating = (
		SELECT max(averageRating)
		FROM title_ratings));
*/

/*		
-- Retrieve the names of people who have worked in titles with a specific genre:
SELECT primaryName
FROM name_basics
WHERE nconst IN (
    SELECT nconst
    FROM title_principal
    WHERE tconst IN (
        SELECT tconst
        FROM title_basics
        WHERE genres LIKE '%Action%')
Limit 50);
*/

/*
-- Retrieve the titles that have more votes than the average number of votes across all titles:
SELECT primaryTitle
FROM title_basics
WHERE tconst IN (
    SELECT tconst
    FROM title_ratings
    WHERE numVotes > (
        SELECT AVG(numVotes)
        FROM title_ratings)
);
*/

/*
-- Subquery in From Clause
SELECT t1.primaryTitle, t2.averageRating
FROM (
    SELECT tconst, primaryTitle
    FROM title_basics
    WHERE titleType = 'movie'
) AS t1
JOIN (
    SELECT tconst, averageRating
    FROM title_ratings
    WHERE numVotes > 1000
) AS t2 ON t1.tconst = t2.tconst;
*/

/*
-- Subquery in SELECT Clause 
SELECT primaryName,(
    SELECT COUNT(*)
    FROM title_basics
    WHERE genres = 'Action'
) AS total_action_movies
FROM name_basics
LIMIT 10;
*/



-- Window Functions

/*
SELECT tb.primaryTitle,tb.startYear as ReleaseYear, tr.averageRating,
rank() OVER(ORDER by tr.numVotes DESC)
FROM title_ratings as tr
INNER JOIN title_basics as tb
on tr.tconst=tb.tconst;
*/



/*
SELECT primaryTitle, startYear, averageRating
FROM (
  SELECT primaryTitle, startYear, averageRating,
         ROW_NUMBER() OVER (ORDER BY averageRating DESC) AS rank
  FROM title_basics
  JOIN title_ratings ON title_basics.tconst = title_ratings.tconst
  WHERE titleType = 'movie'
) AS ranked_movies
WHERE rank <= 10
LIMIT 50;
*/


-- CTE
/*
WITH popular_movies AS (
  SELECT primaryTitle,averageRating
  FROM title_basics
  JOIN title_ratings ON title_basics.tconst = title_ratings.tconst
  WHERE titleType = 'movie' AND numVotes > 10000 AND startYear=2022
)
SELECT primaryTitle, averageRating
FROM popular_movies
ORDER BY averageRating DESC
limit 10;
*/














