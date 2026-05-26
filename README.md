# Base de Datos – Ejercicio 2: Boliche

## Análisis del Dominio

El boliche necesita registrar:

* Las barras donde se venden consumiciones.
* Las pistas del boliche.
* Las bebidas disponibles.
* Las ventas realizadas.
* Los tickets emitidos.
* El detalle de productos vendidos.
* La cantidad de litros vendidos para reposición.

Además, el sistema debe permitir responder:

1. Cuánto se recaudó en cada barra.
2. Cuál es el monto total recaudado entre todas las barras.
3. En qué barra/s se produjo la mayor recaudación.
4. Cuáles fueron las 5 bebidas más vendidas.
5. Cuántos litros de bebidas deben reponerse.

---

# Modelo Relacional (3FN)

## Entidades principales

* barra
* pista
* bebida
* ticket
* detalle_ticket

La base de datos se encuentra normalizada en Tercera Forma Normal (3FN):

* No existen grupos repetitivos.
* Todos los atributos dependen completamente de la clave primaria.
* No existen dependencias transitivas.

---

# DER (Diagrama Entidad Relación)

[![](https://mermaid.ink/img/pako:eNqVk1Fv2jAQx7-K5WeKkkIJ-C1AqkWUCmXZHqZIkWNfwYLYkeNM2yjfvQ5N2pIFqfVTfPe_u5__do6YKQ6YYNBLQbea5olMJLJr7keRj46vm3qFjzESPM2o1hRtVu-Jn360-OZHSKo80_B_vMoEo0yopvGpnbAJv8d9EwpRms9NqAsYLWxzTnmn-zyYh8veA0Bm5V86gRGFeo8-_lgHUbhAhQZ7qrSSwlAtegQHYbQq00LpWvSG2LKURrF9k4Gygx-Hi1UQ9-AbwfZgLvDjcB1YK9cb9ARsR9Od0vTKvd2vrtj9MdHyG2XoocO1DGL_4SFIr_JxsEUHuAC8RO9haO6km2FUmkvfPu19WWV9-K-v-vn55kYdW48J2oKE2rKP77KrKUAbK2OQ0s4dNcqOMwQxZeltSedFXpOXkP4GySEFiQd4qwXHxOgKBjgHndN6i892J9jsIIcEE_vJqd4nOJEnW1NQ-UupvC3TqtruMHmih9LuqoJTA81P_hbV9US9UJU0mIxH5x6YHPEfTG5n7tB13cnIG8-c6diZTQb4rw1Ph-7teOZ5juO6d95ochrgf-epznDq3Z1eAJBFP1M?type=png)](https://mermaid.live/edit#pako:eNqVk1Fv2jAQx7-K5WeKkkIJ-C1AqkWUCmXZHqZIkWNfwYLYkeNM2yjfvQ5N2pIFqfVTfPe_u5__do6YKQ6YYNBLQbea5olMJLJr7keRj46vm3qFjzESPM2o1hRtVu-Jn360-OZHSKo80_B_vMoEo0yopvGpnbAJv8d9EwpRms9NqAsYLWxzTnmn-zyYh8veA0Bm5V86gRGFeo8-_lgHUbhAhQZ7qrSSwlAtegQHYbQq00LpWvSG2LKURrF9k4Gygx-Hi1UQ9-AbwfZgLvDjcB1YK9cb9ARsR9Od0vTKvd2vrtj9MdHyG2XoocO1DGL_4SFIr_JxsEUHuAC8RO9haO6km2FUmkvfPu19WWV9-K-v-vn55kYdW48J2oKE2rKP77KrKUAbK2OQ0s4dNcqOMwQxZeltSedFXpOXkP4GySEFiQd4qwXHxOgKBjgHndN6i892J9jsIIcEE_vJqd4nOJEnW1NQ-UupvC3TqtruMHmih9LuqoJTA81P_hbV9US9UJU0mIxH5x6YHPEfTG5n7tB13cnIG8-c6diZTQb4rw1Ph-7teOZ5juO6d95ochrgf-epznDq3Z1eAJBFP1M)

---

# Script SQL – Creación de la Base de Datos

```sql
-- =========================================
-- CREACIÓN DE TABLAS
-- PostgreSQL
-- =========================================

CREATE TABLE barra (
    id_barra SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL
);

CREATE TABLE pista (
    id_pista SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE bebida (
    id_bebida SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    precio_unitario NUMERIC(10,2) NOT NULL CHECK (precio_unitario > 0),
    litros_por_unidad NUMERIC(10,2) NOT NULL CHECK (litros_por_unidad > 0),
    stock_unidades INTEGER NOT NULL CHECK (stock_unidades >= 0)
);

CREATE TABLE ticket (
    id_ticket SERIAL PRIMARY KEY,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_barra INTEGER NOT NULL,
    total NUMERIC(10,2) NOT NULL CHECK (total >= 0),

    CONSTRAINT fk_ticket_barra
        FOREIGN KEY (id_barra)
        REFERENCES barra(id_barra)
);

CREATE TABLE detalle_ticket (
    id_detalle SERIAL PRIMARY KEY,
    id_ticket INTEGER NOT NULL,
    id_bebida INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) NOT NULL CHECK (precio_unitario > 0),
    subtotal NUMERIC(10,2) NOT NULL CHECK (subtotal > 0),

    CONSTRAINT fk_detalle_ticket
        FOREIGN KEY (id_ticket)
        REFERENCES ticket(id_ticket),

    CONSTRAINT fk_detalle_bebida
        FOREIGN KEY (id_bebida)
        REFERENCES bebida(id_bebida)
);

```

---

# Script SQL – Inserción de Datos de Ejemplo

```sql
-- =========================================
-- INSERTS DE BARRAS
-- =========================================

INSERT INTO barra (nombre, ubicacion)
VALUES
('Barra Norte', 'Sector Norte'),
('Barra Sur', 'Sector Sur'),
('Barra VIP', 'Sector VIP'),
('Barra Central', 'Sector Central');

-- =========================================
-- INSERTS DE PISTAS
-- =========================================

INSERT INTO pista (nombre, capacidad)
VALUES
('Pista Principal', 500),
('Pista Electrónica', 300),
('Pista Latina', 250),
('Pista Retro', 200),
('Pista VIP', 150);

-- =========================================
-- INSERTS DE BEBIDAS
-- =========================================

INSERT INTO bebida (
    nombre,
    tipo,
    precio_unitario,
    litros_por_unidad,
    stock_unidades
)
VALUES
('Cerveza Quilmes', 'Cerveza', 3500, 1.00, 120),
('Fernet Branca', 'Aperitivo', 8500, 0.75, 80),
('Coca Cola', 'Gaseosa', 2500, 2.25, 100),
('Vodka Smirnoff', 'Destilado', 9000, 0.75, 60),
('Speed', 'Energizante', 3000, 0.25, 140),
('Gin Bombay', 'Destilado', 9500, 0.75, 40),
('Agua Mineral', 'Agua', 1800, 0.50, 90);

-- =========================================
-- INSERTS DE TICKETS
-- =========================================

INSERT INTO ticket (fecha_hora, id_barra, total)
VALUES
('2026-05-25 23:10:00', 1, 9500),
('2026-05-25 23:40:00', 2, 15500),
('2026-05-26 00:05:00', 3, 12000),
('2026-05-26 00:20:00', 4, 18000),
('2026-05-26 01:00:00', 1, 7000);

-- =========================================
-- INSERTS DE DETALLE TICKET
-- =========================================

INSERT INTO detalle_ticket (
    id_ticket,
    id_bebida,
    cantidad,
    precio_unitario,
    subtotal
)
VALUES
(1, 1, 2, 3500, 7000),
(1, 5, 1, 2500, 2500),

(2, 2, 1, 8500, 8500),
(2, 3, 2, 3500, 7000),

(3, 4, 1, 9000, 9000),
(3, 7, 1, 3000, 3000),

(4, 6, 1, 9500, 9500),
(4, 5, 2, 4250, 8500),

(5, 1, 2, 3500, 7000);

```

---

# Consultas SQL Solicitadas

## 1. Cuánto se recaudó en cada barra

```sql
SELECT
    b.nombre AS barra,
    SUM(t.total) AS total_recaudado
FROM barra b
INNER JOIN ticket t
    ON b.id_barra = t.id_barra
GROUP BY b.nombre
ORDER BY total_recaudado DESC;
```

---

## 2. Monto total recaudado entre todas las barras

```sql
SELECT
    SUM(total) AS recaudacion_total
FROM ticket;
```

---

## 3. Barra/s con mayor monto recaudado

```sql
SELECT
    b.nombre,
    SUM(t.total) AS total_recaudado
FROM barra b
INNER JOIN ticket t
    ON b.id_barra = t.id_barra
GROUP BY b.nombre
HAVING SUM(t.total) = (
    SELECT MAX(recaudacion)
    FROM (
        SELECT SUM(total) AS recaudacion
        FROM ticket
        GROUP BY id_barra
    ) AS subconsulta
);
```

---

## 4. Las 5 bebidas más vendidas

```sql
SELECT
    be.nombre AS bebida,
    SUM(dt.cantidad) AS cantidad_vendida
FROM bebida be
INNER JOIN detalle_ticket dt
    ON be.id_bebida = dt.id_bebida
GROUP BY be.nombre
ORDER BY cantidad_vendida DESC
LIMIT 5;
```

---

## 5. Litros de bebidas que deben reponerse

```sql
SELECT
    be.nombre AS bebida,
    SUM(dt.cantidad * be.litros_por_unidad) AS litros_a_reponer
FROM bebida be
INNER JOIN detalle_ticket dt
    ON be.id_bebida = dt.id_bebida
GROUP BY be.nombre
ORDER BY litros_a_reponer DESC;
```

---

# Explicación de la Solución

## Tabla barra

Almacena las 4 barras del boliche desde donde se realizan las ventas.

## Tabla pista

Representa las 5 pistas del boliche.

## Tabla bebida

Contiene todas las bebidas disponibles para la venta.

Incluye:

* Tipo de bebida.
* Precio.
* Litros por unidad.
* Stock disponible.

## Tabla ticket

Representa cada venta realizada en una barra.

Cada ticket:

* Tiene fecha y hora.
* Pertenece a una barra.
* Posee un total.

## Tabla detalle_ticket

Representa el detalle de productos vendidos en cada ticket.

Permite:

* Registrar múltiples bebidas por ticket.
* Calcular cantidades vendidas.
* Obtener litros consumidos.
* Analizar ventas y recaudación.

---

# Cumplimiento de 3FN

La base cumple Tercera Forma Normal porque:

1. Cada tabla posee una clave primaria.
2. Los atributos dependen únicamente de su clave primaria.
3. No existen dependencias parciales.
4. No existen dependencias transitivas.
5. Los datos redundantes fueron eliminados.

---

# Conclusión

La solución propuesta permite:

* Gestionar las ventas del boliche.
* Emitir tickets.
* Controlar consumiciones.
* Analizar recaudaciones.
* Identificar bebidas más vendidas.
* Estimar reposición de stock.
* Mantener integridad y normalización de los datos.
