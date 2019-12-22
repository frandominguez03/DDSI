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
-- Table `comprasPorUsuariosEnEdicion`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `comprasPorUsuariosEnEdicion`;

CREATE TABLE IF NOT EXISTS `comprasPorUsuariosEnEdicion` (
    `codcompra` INT NOT NULL AUTO_INCREMENT,
    `coduser` INT NOT NULL AUTO_INCREMENT,
    `numedicion` INT NOT NULL AUTO_INCREMENT,
    `anoedicion` INT NOT NULL,
    FOREIGN KEY (`coduser`) REFERENCES `usuarios` (`coduser`),
    FOREIGN KEY (`numedicion`,`anoedicion`) REFERENCES `edicion` (`numedicion`,`anoedicion`),
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
    FOREIGN KEY (`codcompra`) REFERENCES `comprasfinalizadas` (`codcompra`)
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

-- -----------------------------------------------------
-- Table `arbitra`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `arbitra`

CREATE TABLE IF NOT EXISTS `arbitra`(
    `codarbitro` INT NOT NULL AUTO_INCREMENT,
    `idpartido` INT NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (`codarbitro`) REFERENCES `arbitros` (`codarbitro`),
    FOREIGN KEY (`idpartido`) REFERENCES `partidos` (`idpartido`),
    PRIMARY KEY(`codarbitro`,`idpartido`)
);

-- -----------------------------------------------------
-- Table `gestiona`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `gestiona`

CREATE TABLE IF NOT EXISTS `gestiona`(
    `codarbitro` INT NOT NULL AUTO_INCREMENT,
    `codoferta` INT NOT NULL AUTO_INCREMENT
    FOREIGN KEY (`codarbitro`) REFERENCES `arbitros` (`codarbitro`),
    FOREIGN KEY (`codoferta`) REFERENCES `ofertas` (`codoferta`),
    PRIMARY KEY(`codarbitro`,`codoferta`)
);

-- -----------------------------------------------------
-- Table `ofertar`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `ofertar`

CREATE TABLE IF NOT EXISTS `ofertar`(
    `codoferta` INT NOT NULL AUTO_INCREMENT
    `codcontraoferta` INT NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (`codoferta`) REFERENCES `ofertas` (`codoferta`),
    FOREIGN KEY (`codcontraoferta`) REFERENCES `contraofertas` (`codcontraoferta`)
    PRIMARY KEY(`codoferta`)
);

-- -----------------------------------------------------
-- Table `contraofertar`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `contraofertar`

CREATE TABLE IF NOT EXISTS `contraofertar`(
    `codoferta` INT NOT NULL AUTO_INCREMENT
    `codcontraoferta` INT NOT NULL AUTO_INCREMENT,
    FOREIGN KEY (`codoferta`) REFERENCES `ofertas` (`codoferta`),
    FOREIGN KEY (`codcontraoferta`) REFERENCES `contraofertas` (`codcontraoferta`)
    PRIMARY KEY(`codcontraoferta`)
);

-- -----------------------------------------------------
-- Table `contrato`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `contrato`

CREATE TABLE IF NOT EXISTS `contrato`(
    `codoferta` INT NOT NULL AUTO_INCREMENT
    `numedicion` INT NOT NULL AUTO_INCREMENT,
    `anoedicion` INT NOT NULL,
    FOREIGN KEY (`codoferta`) REFERENCES `ofertas` (`codoferta`),
    FOREIGN KEY (`numedicion`,`anoedicion`) REFERENCES `edicion` (`numedicion`,`anoedicion`),
    PRIMARY KEY(`codoferta`)
);

-- -----------------------------------------------------
-- Table `contiene`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `contiene`

CREATE TABLE IF NOT EXISTS `contiene`(
    `codcompra` INT NOT NULL AUTO_INCREMENT
    `codentrada` INT NOT NULL AUTO_INCREMENT,
    `cantiad` INT NOT NULL,
    FOREIGN KEY (`codcompra`) REFERENCES `compras` (`codcompra`),
    FOREIGN KEY (`codentrada`) REFERENCES `entradas` (`codentrada`),
    PRIMARY KEY(`codcompra`,`codentrada`)
);

-- -----------------------------------------------------
-- Table `trabaja`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `trabaja`

CREATE TABLE IF NOT EXISTS `trabaja`(
    `codtrabajador` INT NOT NULL AUTO_INCREMENT
    `numedicion` INT NOT NULL AUTO_INCREMENT,
    `anoedicion` INT NOT NULL,
    FOREIGN KEY (`codtrabajador`) REFERENCES `trabajadores` (`codtrabajador`),
    FOREIGN KEY (`numedicion`,`anoedicion`) REFERENCES `edicion` (`numedicion`,`anoedicion`),
    PRIMARY KEY(`codtrabjador`,`numedicion`,`anoedicion`)
);

-- -----------------------------------------------------
-- Table `participan`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `participan`

CREATE TABLE IF NOT EXISTS `participan`(
    `codjugador` INT NOT NULL AUTO_INCREMENT
    `numedicion` INT NOT NULL AUTO_INCREMENT,
    `anoedicion` INT NOT NULL,
    FOREIGN KEY (`codjugador`) REFERENCES `jugadores` (`codjugador`),
    FOREIGN KEY (`numedicion`,`anoedicion`) REFERENCES `edicion` (`numedicion`,`anoedicion`),
    PRIMARY KEY(`codjugador`,`numedicion`,`anoedicion`)
);

-- -----------------------------------------------------
-- Table `asignar`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `asignar`

CREATE TABLE IF NOT EXISTS `asignar`(
    `codtrabajador` INT NOT NULL AUTO_INCREMENT
    `numedicion` INT NOT NULL AUTO_INCREMENT,
    `anoedicion` INT NOT NULL,
    `codpista` INT NOT NULL AUTO_INCREMENT,
    `fechaInicio` DATE NOT NULL,
    `fechaFin` DATE NOT NULL,
    FOREIGN KEY (`codtrabajador`) REFERENCES `trabajadores` (`codtrabajador`),
    FOREIGN KEY (`codpista`) REFERENCES `pistas` (`codpista`),
    FOREIGN KEY (`numedicion`,`anoedicion`) REFERENCES `edicion` (`numedicion`,`anoedicion`),
    PRIMARY KEY(`codtrabajador`,`numedicion`,`anoedicion`,`codpista`,`fechaInicio`)
);

-- -----------------------------------------------------
-- Table `juegan`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `juegan`

CREATE TABLE IF NOT EXISTS `juegan`(
    `codjugador` INT NOT NULL AUTO_INCREMENT
    `numedicion` INT NOT NULL AUTO_INCREMENT,
    `idpartido` INT NOT NULL AUTO_INCREMENT,
    `anoedicion` INT NOT NULL,
    FOREIGN KEY (`codjugador`) REFERENCES `jugadores` (`codjugador`),
    FOREIGN KEY (`idpartido`) REFERENCES `partidos` (`idpartido`),
    FOREIGN KEY (`numedicion`,`anoedicion`) REFERENCES `edicion` (`numedicion`,`anoedicion`),
    PRIMARY KEY(`codjugador`,`numedicion`,`anoedicion`,`idpartido`)
);