# Proyecto-III-Flujo-de-Datos-de-SQL-a-Python

# Análisis de Actividad del Cliente

Este proyecto implica el análisis de datos de actividad del cliente, realizando limpieza de datos, primero usando SQL Workbench y luego pulir en Google Colab

## Tecnologías Utilizadas

- Python
- pandas (para manipulación y análisis de datos)
- numpy (para operaciones numéricas)
- missingno (para visualizar patrones de datos faltantes)
- matplotlib (para trazado)
- seaborn (para visualización estadística de datos)

## Fuente de Datos

El conjunto de datos principal utilizado es `Customer_Activity.csv`.

## Pasos del Análisis

### Manejo de Valores Faltantes

Se identificaron y abordaron los valores faltantes en la columna `district` (aproximadamente el 3.5% de los datos) rellenándolos con el marcador de posición "dato vacio". Se utilizó la biblioteca `missingno` para visualizar los patrones de datos faltantes antes y después de la imputación.

### Conversión de Tipos de Datos y Normalización de Cadenas

Las columnas de fecha (`rental_date`, `return_date`, `payment_date`) se convirtieron a objetos datetime usando `pd.to_datetime`. Varias columnas de tipo objeto como `first_name`, `last_name`, `email`, `address`, `district`, `city` y `country` se convirtieron al tipo `string`

### Detección de Valores Atípicos

Los valores atípicos en la columna `amount` se identificaron utilizando el método del Rango Intercuartílico (RIC). Se calcularon los límites superior e inferior, y las transacciones fuera de estos límites se marcaron como valores atípicos. También se utilizó un diagrama de caja para inspeccionar visualmente la distribución y los valores atípicos.

### Ingeniería de Características

Se creó una nueva característica, `rental_duration_days`, calculando la diferencia en días entre `return_date` y `rental_date`.

### Visualización de Datos

Se realizaron visualizaciones básicas para comprender la distribución de variables clave:
- Se generó un histograma y un gráfico KDE para la columna `amount` para mostrar su distribución.
- Se creó un diagrama de caja para la columna `amount` para visualizar los valores atípicos.
"""
