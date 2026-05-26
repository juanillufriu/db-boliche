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

INSERT INTO ticket (
    fecha_hora,
    id_barra,
    id_pista,
    total
)
VALUES
('2026-05-25 23:10:00', 1, 1, 9500),
('2026-05-25 23:40:00', 2, 2, 15500),
('2026-05-26 00:05:00', 3, 5, 12000),
('2026-05-26 00:20:00', 4, 3, 18000),
('2026-05-26 01:00:00', 1, 1, 7000);

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
