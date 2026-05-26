-- Cuánto se recaudó en cada barra
SELECT
    b.nombre AS barra,
    SUM(t.total) AS total_recaudado
FROM barra b
INNER JOIN ticket t
    ON b.id_barra = t.id_barra
GROUP BY b.nombre
ORDER BY total_recaudado DESC;

-- Monto total recaudado entre todas las barras
SELECT
    SUM(total) AS recaudacion_total
FROM ticket;

-- Barra/s con mayor monto recaudado
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

-- Las 5 bebidas más vendidas
SELECT
    be.nombre AS bebida,
    SUM(dt.cantidad) AS cantidad_vendida
FROM bebida be
INNER JOIN detalle_ticket dt
    ON be.id_bebida = dt.id_bebida
GROUP BY be.nombre
ORDER BY cantidad_vendida DESC
LIMIT 5;

-- Litros de bebidas que deben reponerse
SELECT
    be.nombre AS bebida,
    SUM(dt.cantidad * be.litros_por_unidad) AS litros_a_reponer
FROM bebida be
INNER JOIN detalle_ticket dt
    ON be.id_bebida = dt.id_bebida
GROUP BY be.nombre
ORDER BY litros_a_reponer DESC;

-- Recaudación por pista
SELECT
    p.nombre AS pista,
    SUM(t.total) AS total_recaudado
FROM pista p
INNER JOIN ticket t
    ON p.id_pista = t.id_pista
GROUP BY p.nombre
ORDER BY total_recaudado DESC;

-- Cantidad de tickets emitidos por pista
SELECT
    p.nombre AS pista,
    COUNT(t.id_ticket) AS cantidad_tickets
FROM pista p
INNER JOIN ticket t
    ON p.id_pista = t.id_pista
GROUP BY p.nombre
ORDER BY cantidad_tickets DESC;
