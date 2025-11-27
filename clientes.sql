use sakila; -- Cambia el contexto de ejecución actual a la base de datos sakila. Asegura que todas las tablas mencionadas a continuación (como customer, rental, etc.) se busquen dentro de este esquema y no en otro.
CREATE VIEW vista_customer_activity AS -- No ejecuta la consulta para mostrar resultados inmediatos, sino que guarda la lógica de la consulta bajo el nombre vista_customer_activity. A partir de ahora, podrás hacer SELECT * FROM vista_customer_activity como si fuera una tabla real, sin tener que escribir todos los JOINs de nuevo
SELECT -- Inicia la proyección de datos.
c.customer_id,
c.first_name,
c.last_name,
c.email,
c.active,
-- Extrae la identidad y estado del cliente directamente de la tabla customer (alias c). Incluye su ID único, nombre completo, contacto y si su cuenta está activa o dada de baja
a.address,
a.district,
a.postal_code,
-- Extrae la ubicación física específica de la tabla address (alias a).
ci.city, -- Obtiene el nombre de la ciudad de la tabla city (alias ci).
co.country, -- Obtiene el nombre del país de la tabla country (alias co).
r.rental_date,
r.return_date,
-- Extrae el ciclo de vida del alquiler de la tabla rental (alias r). Muestra cuándo se llevó la película y cuándo la devolvió.
p.amount,
p.payment_date
-- Extrae los datos financieros asociados a ese alquiler específico desde la tabla payment (alias p), mostrando cuánto pagó y cuándo ocurrió la transacción.

FROM customer c -- Establece la tabla customer como la fuente principal de datos y le asigna el alias c para abreviar su referencia en el resto del código.
 JOIN address a ON c.address_id = a.address_id -- Cruza los clientes con sus direcciones. Utiliza la columna address_id que existe en ambas tablas para asegurar que a cada cliente se le asigne su dirección correcta y no la de otro.
 JOIN city ci ON a.city_id = ci.city_id -- Escala geográficamente. Toma la dirección (tabla a) y busca a qué ciudad pertenece usando el city_id. Esto permite traducir un número (ID de ciudad) al nombre real de la ciudad (ci.city).
 JOIN country co ON ci.country_id = co.country_id -- Escala al nivel superior geográfico. Toma la ciudad obtenida en la línea anterior y la enlaza con la tabla country para obtener el nombre del país.
 JOIN rental r ON c.customer_id = r.customer_id -- Une al cliente con su historial de alquileres.
 JOIN payment p ON p.rental_id = r.rental_id; -- Enlaza el alquiler específico (rental) con su pago correspondiente (payment). No une por cliente, sino por rental_id. Esto asegura que el monto (p.amount) corresponda exactamente a ese alquiler de película en particular, y no a otro pago del mismo cliente.