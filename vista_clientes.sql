use sakila; -- Asegura que la consulta se ejecute sobre la base de datos sakila y no otra.

SELECT -- Inicia la definición de las columnas resultantes.
customer_id, -- Selecciona el ID del cliente tal cual viene de la base de datos (dato numérico, no requiere limpieza).
LOWER(first_name) AS first_name, -- Toma el nombre (que suele estar en MAYÚSCULAS en Sakila) y lo normaliza a minúsculas. Esto es crucial para sistemas de frontend o reportes donde "MARY" se ve agresivo y "mary" es más estético. Mantiene el nombre de columna original.
LOWER(last_name) AS last_name, -- Normaliza el apellido a minúsculas.
LOWER(email) AS email, -- Estandariza el correo electrónico a minúsculas. Esto es fundamental para evitar duplicados si en el futuro comparas correos (ej: User@Mail.com vs user@mail.com)
active, -- Mantiene el indicador de estado (1 o 0) sin cambios.
LOWER(address) AS address, -- Normaliza la dirección física a minúsculas.
LOWER(district) AS district, -- Normaliza el distrito/provincia a minúsculas.
postal_code, -- Selecciona el código postal sin modificarlo (es un dato alfanumérico estándar).
LOWER(city) AS city, -- Normaliza el nombre de la ciudad a minúsculas.
LOWER(country) AS country, -- Normaliza el nombre del país a minúsculas.
rental_date, -- Muestra la fecha y hora original del alquiler.
return_date, -- Muestra la fecha y hora original de la devolución.
amount, -- Muestra el dinero pagado en esa transacción.
payment_date, -- Muestra cuándo se realizó el pago.
DATEDIFF(return_date, rental_date) AS rental_duration -- Crea una métrica nueva (columna calculada) que no existe en la base de datos, Lógica: Resta la rental_date a la return_date para obtener un número entero que representa cuántos días tuvo el cliente la película.
FROM vista_customer_activity -- En lugar de hacer 5 JOINs de nuevo, consulta directamente la "tabla virtual" que creaste antes.
WHERE -- Inicia el filtrado de filas.
 rental_date IS NOT NULL -- Asegura que la transacción tenga fecha de inicio.
 AND return_date IS NOT NULL -- Filtra y elimina las películas que aún no han sido devueltas. Solo te interesan ciclos de alquiler cerrados para poder calcular la duración.
 AND amount > 0 -- Elimina transacciones con valor 0.00 o negativo. Esto filtra posibles errores, promociones del 100% o anulaciones, quedándote solo con alquileres que generaron ingresos reales.
 AND rental_date < return_date; -- Filtro de integridad lógica, Asegura que nadie haya devuelto la película antes de alquilarla (lo cual sería un error de datos). Garantiza que el cálculo de DATEDIFF siempre dé un número positivo