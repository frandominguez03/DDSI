-- Script MySQL para la creación de la base de datos y la inserción de datos de prueba
-- Autores
    -- Francisco Beltŕan Sánchez
    -- Pablo Cordero Romero
    -- Francisco Domínguez Lorente
    -- David Gómez Hernández
    -- Miguel Ángel Posadas Arráez


-- -----------------------------------------------------
-- Table `edicion`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `edicion`;

CREATE TABLE IF NOT EXISTS `edicion` (
    `numedicion` INT NOT NULL AUTO_INCREMENT,
    `anoedicion` INT NOT NULL,
    PRIMARY KEY (`numedicion`, `anoedicion`)
);

-- -----------------------------------------------------
-- Table `trabajadores`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `trabajadores`;

CREATE TABLE IF NOT EXISTS `trabajadores` (
    `codtrajador` INT NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(320) NOT NULL,
    `telf` INT NOT NULL,
    `nombre` VARCHAR(150) NOT NULL,
    `apellidos` VARCHAR(400) NOT NULL,
    PRIMARY KEY (`codtrabajador`)
);

-- -----------------------------------------------------
-- Table `pistas`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `pistas`;

CREATE TABLE IF NOT EXISTS `pistas` (
    `codpista` INT NOT NULL AUTO_INCREMENT,
    `ubicacion` VARCHAR(320) NOT NULL,
    `capacidad` INT NOT NULL,
    `numero` TINYINT NOT NULL,
    PRIMARY KEY (`codpista`)
);

-- -----------------------------------------------------
-- Table `partidos`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `partidos`;

CREATE TABLE IF NOT EXISTS `partidos` (
    `idpartido` INT NOT NULL AUTO_INCREMENT,
    `fecha` DATE NOT NULL,
    `resultado` INT NOT NULL,
    PRIMARY KEY (`idpartido`)
);

-- -----------------------------------------------------
-- Table `jugadores`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `jugadores`;

CREATE TABLE IF NOT EXISTS `jugadores` (
    `codjugador` INT NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(320) NOT NULL,
    `telf` INT NOT NULL,
    `nombre` VARCHAR(150) NOT NULL,
    `apellidos` VARCHAR(400) NOT NULL,
    PRIMARY KEY (`codjugador`)
);

-- -----------------------------------------------------
-- Table `arbitros`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `arbitros`;

CREATE TABLE IF NOT EXISTS `arbitros` (
    `codarbitro` INT NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(320) NOT NULL,
    `telf` INT NOT NULL,
    `nombre` VARCHAR(150) NOT NULL,
    `apellidos` VARCHAR(400) NOT NULL,
    PRIMARY KEY (`codarbitro`)
);

-- -----------------------------------------------------
-- Table `usuarios`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE IF NOT EXISTS `usuarios` (
    `coduser` INT NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(320) NOT NULL,
    `nombre` VARCHAR(150) NOT NULL,
    `apellidos` VARCHAR(400) NOT NULL,
    PRIMARY KEY (`coduser`)
);

-- -----------------------------------------------------
-- Table `entradas`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `entradas`;

CREATE TABLE IF NOT EXISTS `entradas` (
    `codentrada` INT NOT NULL AUTO_INCREMENT,
    `tipo` VARCHAR(320) NOT NULL,
    `precio` INT NOT NULL,
    PRIMARY KEY (`coduser`)
);

-- -----------------------------------------------------
-- Table `compras`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `compras`;

CREATE TABLE IF NOT EXISTS `compras` (
    `codcompra` INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`codcompra`)
);

-- -----------------------------------------------------
-- Table `comprasfinalizadas`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `comprasfinalizadas`;

CREATE TABLE IF NOT EXISTS `comprasfinalizadas` (
    `codcompra` INT NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (`codcompra`) REFERENCES `compras` (`codcompra`)
);

-- -----------------------------------------------------
-- Table `comprasiniciadas`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `comprasiniciadas`;

CREATE TABLE IF NOT EXISTS `comprasiniciadas` (
    `codcompra` INT NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (`codcompra`) REFERENCES `compras` (`codcompra`)
);

-- -----------------------------------------------------
-- Table `compraspagadas`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `compraspagadas`;

CREATE TABLE IF NOT EXISTS `compraspagadas` (
    `codcompra` INT NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (`codcompra`) REFERENCES `compras` (`codcompra`)
);

-- -----------------------------------------------------
-- Table `ofertas`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `ofertas`;

CREATE TABLE IF NOT EXISTS `ofertas` (
    `codoferta` INT NOT NULL AUTO_INCREMENT
    `salario` INT NOT NULL,
    PRIMARY KEY (`codoferta`)
);

-- -----------------------------------------------------
-- Table `contraofertas`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `contraofertas`;

CREATE TABLE IF NOT EXISTS `contraofertas` (
    `codcontraoferta` INT NOT NULL AUTO_INCREMENT,
    `salario` INT NOT NULL,
    PRIMARY KEY (`codcontraoferta`)
);

-- -----------------------------------------------------
-- Table `ofertasaceptadas`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `ofertasaceptadas`;

CREATE TABLE IF NOT EXISTS `ofertasaceptadas` (
    `codoferta` INT NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (`codoferta`) REFERENCES `ofertas` (`codoferta`)
);

-- -----------------------------------------------------
-- Table `ofertasrechazadas`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `ofertasrechazadas`;

CREATE TABLE IF NOT EXISTS `ofertasrechazadas` (
    `codoferta` INT NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (`codoferta`) REFERENCES `ofertas` (`codoferta`)
);

-- -----------------------------------------------------
-- Table `contraofertasaceptadas`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `contraofertasaceptadas`;

CREATE TABLE IF NOT EXISTS `contraofertasaceptadas` (
    `codcontraoferta` INT NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (`codcontraoferta`) REFERENCES `contraofertas` (`codcontraoferta`)
);

-- -----------------------------------------------------
-- Table `contraofertasrechazadas`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `contraofertasrechazadas`;

CREATE TABLE IF NOT EXISTS `contraofertasrechazadas` (
    `codcontraoferta` INT NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (`codcontraoferta`) REFERENCES `contraofertas` (`codcontraoferta`)
);
