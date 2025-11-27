use sakila;

CREATE OR REPLACE VIEW peliculas_catalogo AS

SELECT
    f.film_id,
    LOWER(TRIM(f.title)) AS title, -- Esto convierte a minusculas
    LOWER(TRIM(f.description)) AS description,
    f.length,
    f.rating,
    LOWER(l.name) AS language,
    c.category_id,
    LOWER(c.name) AS category,
    i.inventory_id
    
    FROM film f
    JOIN language l ON f.language_id = l.language_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id;


SELECT
film_id,  
LOWER(TRIM(title)) AS title,
LOWER(TRIM(description)) AS description,
length,
rating,
language,
category_id,
category,
inventory_id
FROM peliculas_catalogo
WHERE
rating IS NOT NULL
AND length > 0
AND inventory_id IS NOT NULL
    