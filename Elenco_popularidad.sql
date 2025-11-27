use sakila; -- usa base de datos sakila

CREATE OR REPLACE VIEW Elenco_popularidad AS -- crear vista, tiene replace para que cada vez que exista se cree una nueva cada vez

SELECT -- Seleccionar los deseados
a.actor_id,-- pillamos id de la tabla actor
LOWER(a.first_name) AS first_name, -- pillar nombres y apellidos, hacerlo minuscula
LOWER(a.last_name) AS last_name, -- pillar nombres y apellidos, hacerlo minuscula
CONCAT(LOWER(a.first_name), " ", LOWER(a.last_name)) AS a_full_name, -- Juntar nombre y apellido y hacerlo minuscula
f.film_id, -- seleccionar el id de film
f.title -- seleccionar el titulo

FROM actor a

JOIN film_actor fa ON a.actor_id = fa.actor_id -- para relacionar los actores, con sus peliculas
JOIN film f ON fa.film_id = f.film_id -- para sacar informacion de las peliculas

GROUP BY -- para eliminar duplicados
	a.actor_id,
    a.first_name,
    a.last_name,
    f.film_id,
    f.title;
    
    SELECT * FROM Elenco_popularidad -- mostrar la vista