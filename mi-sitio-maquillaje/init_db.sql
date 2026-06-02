-- init_db.sql
-- Script de inicialización para MySQL / XAMPP
-- Crea la BD `sistema_maquillaje`, la tabla `productos` y datos de prueba.

CREATE DATABASE IF NOT EXISTS sistema_maquillaje CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sistema_maquillaje;

-- Tabla productos (campos compatibles con el DAO y columnas básicas solicitadas)
CREATE TABLE IF NOT EXISTS productos (
  id VARCHAR(50) PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  marca VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  precioBase DOUBLE NOT NULL,
  stock INT DEFAULT 0,
  tipo VARCHAR(50) DEFAULT 'Rostro',
  atributoEspecial VARCHAR(200) DEFAULT ''
);

-- Tabla clientes (opcional, usada por el Observer)
CREATE TABLE IF NOT EXISTS clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE
);

-- Datos de ejemplo para productos (5 registros)
REPLACE INTO productos (id, nombre, marca, precio, precioBase, stock, tipo, atributoEspecial) VALUES
('P001', 'Paleta de Sombras - Sunset', 'GlamColor', 15.00, 15.00, 20, 'Ojos', 'true'),
('P002', 'Base Hidratante 30ml', 'SkinCare', 20.50, 20.50, 15, 'Rostro', 'Mixta'),
('P003', 'Delineador Waterproof', 'EyePro', 8.75, 8.75, 30, 'Ojos', 'true'),
('P004', 'Polvo Compacto', 'MatFinish', 12.00, 12.00, 10, 'Rostro', 'Seca'),
('P005', 'Mascara Volumen', 'LashMax', 11.25, 11.25, 25, 'Ojos', 'false');

-- Datos de ejemplo para clientes
REPLACE INTO clientes (nombre, email) VALUES
('Ana Ruiz', 'ana.ruiz@example.com'),
('Pedro López', 'pedro.lopez@example.com');

-- Fin de script
