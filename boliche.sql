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
    id_pista INTEGER NOT NULL,
    total NUMERIC(10,2) NOT NULL CHECK (total >= 0),

    CONSTRAINT fk_ticket_barra
        FOREIGN KEY (id_barra)
        REFERENCES barra(id_barra),

    CONSTRAINT fk_ticket_pista
        FOREIGN KEY (id_pista)
        REFERENCES pista(id_pista)
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
