-- Parcial 1 - Laboratorio de Programacion 3
-- Base de datos de la Tienda Online

IF DB_ID('tienda') IS NULL
    CREATE DATABASE tienda;
GO

USE tienda;
GO

-- Tabla 2: categorias (se crea primero porque productos la referencia)
CREATE TABLE categorias (
    idCategoria  INT IDENTITY(1,1) PRIMARY KEY,
    descripcion  VARCHAR(50) NOT NULL
);
GO

-- Tabla 1: productos (idCategoria es la clave foranea hacia categorias)
CREATE TABLE productos (
    idProducto   INT IDENTITY(1,1) PRIMARY KEY,
    nombre       VARCHAR(80)   NOT NULL,
    precio       DECIMAL(10,2) NOT NULL,
    idCategoria  INT NOT NULL,
    CONSTRAINT FK_productos_categorias
        FOREIGN KEY (idCategoria) REFERENCES categorias(idCategoria)
);
GO

-- Datos de demostracion
INSERT INTO categorias (descripcion) VALUES
    ('Electronica'),
    ('Hogar'),
    ('Indumentaria'),
    ('Libros'),
    ('Deportes');
GO

INSERT INTO productos (nombre, precio, idCategoria) VALUES
    ('Auriculares Bluetooth',  35999.00, 1),
    ('Teclado mecanico',       58500.00, 1),
    ('Lampara de escritorio',  18750.00, 2),
    ('Set de sabanas',         42300.00, 2),
    ('Remera de algodon',      12900.00, 3),
    ('Zapatillas urbanas',     89900.00, 3),
    ('Novela de ciencia ficcion', 15400.00, 4),
    ('Pelota de futbol N5',    27800.00, 5);
GO

-- Verificacion: consulta con JOIN (la misma que usara la pagina de consulta)
SELECT p.idProducto, p.nombre, p.precio, c.descripcion AS categoria
FROM productos AS p
JOIN categorias AS c ON c.idCategoria = p.idCategoria;
GO
