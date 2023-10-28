-- The top-rated movies.
SELECT title AS 'Title'
, release_year 'Release year'
, MAX(rating) AS 'Max rating'
FROM imdb_clean
GROUP BY title
, release_year
ORDER BY `Max rating` DESC
LIMIT 10;

-- The highest-grossing movies.
SELECT title AS 'Title'
, MAX(`gross(M)`) AS 'Gross'
FROM imdb_clean
GROUP BY title
ORDER BY MAX(`gross(M)`) DESC
LIMIT 10;

-- Filtered movies by genre and director
SELECT *
FROM imdb_clean
WHERE genre = 'Comedy' AND director = 'James Gunn'
ORDER BY rating DESC;

-- Calculate statistics like average ratings, total gross, or runtime.
SELECT ROUND(AVG(rating),2) AS 'Average rating'
, ROUND(SUM(`gross(M)`),2) AS 'Total gross(M)'
, ROUND(AVG(runtime), 2) AS 'Average runtime'
FROM imdb_clean;

-- Average rating and gross for movies released in each year
SELECT release_year AS 'Year'
, ROUND(AVG(rating),1) AS 'Average Rating'
, ROUND(AVG(`gross(M)`),2) AS 'Average Gross (M)'
FROM imdb_clean
GROUP BY release_year
ORDER BY release_year;

-- The director has the highest-rated movies on average
SELECT director AS 'Director'
, AVG(rating) AS 'Average Rating'
FROM imdb_clean
GROUP BY director
HAVING AVG(rating) = (
    SELECT MAX(avg_rating)
    FROM (SELECT AVG(rating) AS avg_rating
          FROM imdb_clean
          GROUP BY director) AS avg_ratings
);

SELECT MAX(avg_rating)
    FROM (SELECT AVG(rating) AS avg_rating
          FROM imdb_clean
          GROUP BY director) AS avg_ratings;

-- Which genre is the most popular among the top 1000 IMDb movies?
SELECT genre AS 'Genre'
, COUNT(*) AS 'Movie Count'
FROM imdb_clean
GROUP BY genre
ORDER BY COUNT(*) DESC
LIMIT 1;

