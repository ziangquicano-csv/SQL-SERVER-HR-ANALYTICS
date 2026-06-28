CREATE DATABASE BD_Aerolinea;

USE BD_Aerolinea

-- 1. CREAR LA TABLA
IF OBJECT_ID('TB_Aerolineas', 'U') IS NOT NULL
    DROP TABLE TB_Aerolineas;

CREATE TABLE TB_Aerolineas (
    airline_id      INT            PRIMARY KEY,
    airline_name    VARCHAR(100)   NOT NULL,
    alias           VARCHAR(100),
    iata_code       VARCHAR(10),
    icao_code       VARCHAR(10),
    callsign        VARCHAR(100),
    country         VARCHAR(100),
    active          CHAR(1)        -- 'Y' = activa, 'N' = inactiva
);

BULK INSERT TB_Aerolineas
FROM 'C:\Users\Usuario\Downloads\airlines.csv'
WITH(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

SELECT *
FROM TB_Aerolineas;

IF OBJECT_ID('TB_Aeropuertos', 'U') IS NOT NULL
    DROP TABLE TB_Aeropuertos;

CREATE TABLE TB_Aeropuertos (
    id                  INT             PRIMARY KEY,
    ident               VARCHAR(10),
    type                VARCHAR(50),        -- large_airport, small_airport, heliport, etc.
    name                VARCHAR(200)    NOT NULL,
    latitude_deg        DECIMAL(10,6),
    longitude_deg       DECIMAL(10,6),
    elevation_ft        INT,
    continent           VARCHAR(10),
    iso_country         VARCHAR(10),        -- Código de país (US, PE, BR, etc.)
    iso_region          VARCHAR(20),        -- Código de región
    municipality        VARCHAR(100),       -- Ciudad
    scheduled_service   VARCHAR(5),         -- 'yes' o 'no'
    icao_code           VARCHAR(10),
    iata_code           VARCHAR(10),        -- Código IATA (ej: LIM, JFK)
    gps_code            VARCHAR(10),
    local_code          VARCHAR(10),
    home_link           VARCHAR(500),
    wikipedia_link      VARCHAR(500),
    keywords            VARCHAR(500)
);

BULK INSERT TB_Aeropuertos
FROM 'C:\Users\Usuario\Downloads\airports.csv'
WITH(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

SELECT *
FROM TB_Aeropuertos;


IF OBJECT_ID('TB_Rutas', 'U') IS NOT NULL
    DROP TABLE TB_Rutas;

CREATE TABLE TB_Rutas (
    airline_iata        VARCHAR(10),        -- Código IATA de la aerolínea
    airline_name        VARCHAR(100),       -- Nombre de la aerolínea
    airline_country     VARCHAR(100),       -- País de la aerolínea

    src_iata            VARCHAR(10),        -- Código aeropuerto ORIGEN
    src_airport         VARCHAR(200),       -- Nombre aeropuerto origen
    src_city            VARCHAR(100),       -- Ciudad origen
    src_country         VARCHAR(100),       -- País origen
    src_lat             DECIMAL(10,6),      -- Latitud origen
    src_lon             DECIMAL(10,6),      -- Longitud origen

    dst_iata            VARCHAR(10),        -- Código aeropuerto DESTINO
    dst_airport         VARCHAR(200),       -- Nombre aeropuerto destino
    dst_city            VARCHAR(100),       -- Ciudad destino
    dst_country         VARCHAR(100),       -- País destino
    dst_lat             DECIMAL(10,6),      -- Latitud destino
    dst_lon             DECIMAL(10,6),      -- Longitud destino

    codeshare           BIT,                -- 1 = vuelo compartido con otra aerolínea
    stops               INT,                -- 0 = vuelo directo
    equipment           VARCHAR(50),        -- Tipo de avión (ej: CR2, 738)
    distance_km         INT                 -- Distancia en kilómetros
);

BULK INSERT TB_Rutas
FROM 'C:\Users\Usuario\Downloads\routes.csv'
WITH(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
    
SELECT * 
FROM TB_Rutas;
