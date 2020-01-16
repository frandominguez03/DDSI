-- Script MySQL para la creación de la base de datos y la inserción de datos de prueba
-- Autores
    -- Francisco Beltŕan Sánchez
    -- Pablo Cordero Romero
    -- Francisco Domínguez Lorente
    -- David Gómez Hernández
    -- Miguel �?ngel Posadas Arráez


-- -----------------------------------------------------
-- Table edicion
-- -----------------------------------------------------

CREATE TABLE  edicion (
    numedicion INT NOT NULL ,
    anoedicion INT NOT NULL,
    PRIMARY KEY (numedicion, anoedicion)
);

-- -----------------------------------------------------
-- Table trabajadores
-- -----------------------------------------------------

CREATE TABLE  trabajadores (
    codtrabajador INT NOT NULL PRIMARY KEY,
    email VARCHAR(320) NOT NULL,
    telf INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    apellidos VARCHAR(400) NOT NULL
);

-- -----------------------------------------------------
-- Table pistas
-- -----------------------------------------------------

CREATE TABLE  pistas (
    codpista INT NOT NULL PRIMARY KEY,
    ubicacion VARCHAR(320) NOT NULL,
    capacidad INT NOT NULL,
    numero INT NOT NULL
);

-- -----------------------------------------------------
-- Table partidos
-- -----------------------------------------------------

CREATE TABLE  partidos (
    idpartido INT NOT NULL PRIMARY KEY,
    fecha DATE NOT NULL,
    resultado INT NOT NULL
);

-- -----------------------------------------------------
-- Table jugadores
-- -----------------------------------------------------

CREATE TABLE  jugadores (
    codjugador INT NOT NULL PRIMARY KEY,
    email VARCHAR(320) NOT NULL,
    telf INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    apellidos VARCHAR(400) NOT NULL
);

-- -----------------------------------------------------
-- Table arbitros
-- -----------------------------------------------------

CREATE TABLE  arbitros (
    codarbitro INT NOT NULL PRIMARY KEY,
    email VARCHAR(320) NOT NULL,
    telf INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    apellidos VARCHAR(400) NOT NULL
);

-- -----------------------------------------------------
-- Table usuarios
-- -----------------------------------------------------

CREATE TABLE  usuarios (
    coduser INT NOT NULL PRIMARY KEY,
    email VARCHAR(320) NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    apellidos VARCHAR(400) NOT NULL
);

-- -----------------------------------------------------
-- Table entradas
-- -----------------------------------------------------

CREATE TABLE  entradas (
    codentrada INT NOT NULL PRIMARY KEY,
    tipo VARCHAR(320) NOT NULL,
    precio INT NOT NULL
);

-- -----------------------------------------------------
-- Table comprasPorUsuariosEnEdicion
-- -----------------------------------------------------

CREATE TABLE  comprasPorUsuariosEnEdicion (
    codcompra INT NOT NULL PRIMARY KEY,
    coduser INT NOT NULL ,
    numedicion INT NOT NULL ,
    anoedicion INT NOT NULL,
    FOREIGN KEY (coduser) REFERENCES usuarios (coduser),
    FOREIGN KEY (numedicion,anoedicion) REFERENCES edicion (numedicion,anoedicion)
);

-- -----------------------------------------------------
-- Table comprasfinalizadas
-- -----------------------------------------------------

CREATE TABLE  comprasfinalizadas (
    codcompra INT NOT NULL PRIMARY KEY,
    FOREIGN KEY (codcompra) REFERENCES comprasPorUsuariosEnEdicion (codcompra)
);

-- -----------------------------------------------------
-- Table comprasiniciadas
-- -----------------------------------------------------

CREATE TABLE  comprasiniciadas (
    codcompra INT NOT NULL PRIMARY KEY,
    FOREIGN KEY (codcompra) REFERENCES comprasPorUsuariosEnEdicion (codcompra)
);

-- -----------------------------------------------------
-- Table compraspagadas
-- -----------------------------------------------------

CREATE TABLE  compraspagadas (
    codcompra INT NOT NULL PRIMARY KEY,
    FOREIGN KEY (codcompra) REFERENCES comprasfinalizadas (codcompra)
);

-- -----------------------------------------------------
-- Table ofertas
-- -----------------------------------------------------

CREATE TABLE  ofertas (
    codoferta INT NOT NULL PRIMARY KEY,
    salario INT NOT NULL
);

-- -----------------------------------------------------
-- Table contraofertas
-- -----------------------------------------------------

CREATE TABLE  contraofertas (
    codcontraoferta INT NOT NULL PRIMARY KEY,
    salario INT NOT NULL
);

-- -----------------------------------------------------
-- Table ofertasaceptadas
-- -----------------------------------------------------

CREATE TABLE  ofertasaceptadas (
    codoferta INT NOT NULL ,
    FOREIGN KEY (codoferta) REFERENCES ofertas (codoferta)
);

-- -----------------------------------------------------
-- Table ofertasrechazadas
-- -----------------------------------------------------

CREATE TABLE  ofertasrechazadas (
    codoferta INT NOT NULL ,
    FOREIGN KEY (codoferta) REFERENCES ofertas (codoferta)
);

-- -----------------------------------------------------
-- Table contraofertasaceptadas
-- -----------------------------------------------------

CREATE TABLE  contraofertasaceptadas (
    codcontraoferta INT NOT NULL ,
    FOREIGN KEY (codcontraoferta) REFERENCES contraofertas (codcontraoferta)
);

-- -----------------------------------------------------
-- Table contraofertasrechazadas
-- -----------------------------------------------------

CREATE TABLE  contraofertasrechazadas (
    codcontraoferta INT NOT NULL ,
    FOREIGN KEY (codcontraoferta) REFERENCES contraofertas (codcontraoferta)
);

-- -----------------------------------------------------
-- Table arbitra
-- -----------------------------------------------------

CREATE TABLE  arbitra(
    codarbitro INT NOT NULL ,
    idpartido INT NOT NULL ,
    FOREIGN KEY (codarbitro) REFERENCES arbitros (codarbitro),
    FOREIGN KEY (idpartido) REFERENCES partidos (idpartido),
    PRIMARY KEY(codarbitro,idpartido)
);

-- -----------------------------------------------------
-- Table gestiona
-- -----------------------------------------------------

CREATE TABLE  gestiona(
    codarbitro INT NOT NULL ,
    codoferta INT NOT NULL ,
    FOREIGN KEY (codarbitro) REFERENCES arbitros (codarbitro),
    FOREIGN KEY (codoferta) REFERENCES ofertas (codoferta),
    PRIMARY KEY(codarbitro,codoferta)
);

-- -----------------------------------------------------
-- Table ofertar
-- -----------------------------------------------------

CREATE TABLE  ofertar(
    codoferta INT NOT NULL PRIMARY KEY,
    codcontraoferta INT NOT NULL ,
    FOREIGN KEY (codoferta) REFERENCES ofertas (codoferta),
    FOREIGN KEY (codcontraoferta) REFERENCES contraofertas (codcontraoferta)
);

-- -----------------------------------------------------
-- Table contraofertar
-- -----------------------------------------------------

CREATE TABLE  contraofertar(
    codoferta INT NOT NULL PRIMARY KEY,
    codcontraoferta INT NOT NULL ,
    FOREIGN KEY (codoferta) REFERENCES ofertas (codoferta),
    FOREIGN KEY (codcontraoferta) REFERENCES contraofertas (codcontraoferta)
);

-- -----------------------------------------------------
-- Table contrato
-- -----------------------------------------------------

CREATE TABLE  contrato(
    codoferta INT NOT NULL PRIMARY KEY,
    numedicion INT NOT NULL ,
    anoedicion INT NOT NULL,
    FOREIGN KEY (codoferta) REFERENCES ofertas (codoferta),
    FOREIGN KEY (numedicion,anoedicion) REFERENCES edicion (numedicion,anoedicion)
);

-- -----------------------------------------------------
-- Table contiene
-- -----------------------------------------------------

CREATE TABLE  contiene(
    codcompra INT NOT NULL ,
    codentrada INT NOT NULL ,
    cantidad INT NOT NULL,
    FOREIGN KEY (codcompra) REFERENCES comprasPorUsuariosEnEdicion (codcompra),
    FOREIGN KEY (codentrada) REFERENCES entradas (codentrada),
    PRIMARY KEY(codcompra,codentrada)
);

-- -----------------------------------------------------
-- Table trabaja
-- -----------------------------------------------------

CREATE TABLE trabaja(
    codtrabajador INT NOT NULL,
    numedicion INT NOT NULL ,
    anoedicion INT NOT NULL,
    PRIMARY KEY(codtrabajador,numedicion,anoedicion),
    FOREIGN KEY (codtrabajador) REFERENCES trabajadores (codtrabajador),
    FOREIGN KEY (numedicion,anoedicion) REFERENCES edicion (numedicion,anoedicion)
);

-- -----------------------------------------------------
-- Table participan
-- -----------------------------------------------------

CREATE TABLE  participan(
    codjugador INT NOT NULL ,
    numedicion INT NOT NULL ,
    anoedicion INT NOT NULL,
    FOREIGN KEY (codjugador) REFERENCES jugadores (codjugador),
    FOREIGN KEY (numedicion,anoedicion) REFERENCES edicion (numedicion,anoedicion),
    PRIMARY KEY(codjugador,numedicion,anoedicion)
);

-- -----------------------------------------------------
-- Table asignar
-- -----------------------------------------------------

CREATE TABLE  asignar(
    codtrabajador INT NOT NULL ,
    numedicion INT NOT NULL ,
    anoedicion INT NOT NULL,
    codpista INT NOT NULL ,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    FOREIGN KEY (codtrabajador) REFERENCES trabajadores (codtrabajador),
    FOREIGN KEY (codpista) REFERENCES pistas (codpista),
    FOREIGN KEY (numedicion,anoedicion) REFERENCES edicion (numedicion,anoedicion),
    PRIMARY KEY(codtrabajador,numedicion,anoedicion,codpista,fechaInicio)
);

-- -----------------------------------------------------
-- Table juegan
-- -----------------------------------------------------

CREATE TABLE  juegan(
    codjugador INT NOT NULL ,
    numedicion INT NOT NULL ,
    idpartido INT NOT NULL ,
    anoedicion INT NOT NULL,
    FOREIGN KEY (codjugador) REFERENCES jugadores (codjugador),
    FOREIGN KEY (idpartido) REFERENCES partidos (idpartido),
    FOREIGN KEY (numedicion,anoedicion) REFERENCES edicion (numedicion,anoedicion),
    PRIMARY KEY(codjugador,numedicion,anoedicion,idpartido)
);


CREATE TABLE  partidosenpista(
    idpartido INT NOT NULL PRIMARY KEY,
    codpista INT NOT NULL ,
    FOREIGN KEY (idpartido) REFERENCES partidos (idpartido),
    FOREIGN KEY (codpista) REFERENCES pistas (codpista),
);