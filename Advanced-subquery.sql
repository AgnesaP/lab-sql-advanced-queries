
USE sakila;
#1.List each pair of actors that have worked together.
SELECT fa.actor_id, fa2.actor_id FROM film_actor fa 
LEFT JOIN  film_actor fa2 ON fa.film_id = fa2.film_id and fa.actor_id <> fa2.actor_id
GROUP BY 1,2
LIMIT 100;

#2.For each film, list actor that has acted in more films.
WITH films AS (
SELECT actor_id, count(distinct film_id) films FROM film_actor
GROUP BY actor_id 
), film_top_actor as (
SELECT fa.film_id, fa.actor_id, ROW_NUMBER() OVER(PARTITION BY fa.film_id  ORDER BY films desc ) RowNumber  FROM film_actor fa 
LEFT JOIN films f ON fa.actor_id=f.actor_id
)
SELECT fta.film_id,f.title, a.actor_id, a.first_name, a.last_name FROM film_top_actor fta 
LEFT JOIN film f ON fta.film_id = f.film_id
LEFT JOIN actor a ON a.actor_id = fta.actor_id
WHERE RowNumber = 1 ;
