-- Prueba disparador 1

INSERT INTO edicion VALUES('5', '1999');
INSERT INTO usuarios VALUES('58', 'manolo@mail.com', 'Manolillo', 'Pies de plata');

INSERT INTO comprasPorUsuariosEnEdicion VALUES('123', '58', '5', '1999');
INSERT INTO comprasiniciadas VALUES('123');

INSERT INTO comprasPorUsuariosEnEdicion VALUES('124', '58', '5', '1999');
INSERT INTO comprasiniciadas VALUES('124');
-- Prueba disparador 3 --
INSERT INTO arbitros VALUES('1','manolo@correo.tk','666666666','Manolo','Manolo');
INSERT INTO arbitros VALUES('2','juan@correo.tk','777777777','Juan','Manuel');
INSERT INTO arbitros VALUES('3','luisa@correo.tk','555555555','Luisa','Maria');
INSERT INTO arbitros VALUES('4','manuela@correo.tk','444444444','Manuela','Carmena');


INSERT INTO edicion VALUES('5', '1999');
INSERT INTO edicion VALUES('6', '2000');

INSERT INTO ofertas VALUES('1','1','500','5','1999');
INSERT INTO ofertas VALUES('2','1','1000','5','1999');

INSERT INTO ofertasaceptadas VALUES('1');

INSERT INTO ofertas VALUES('3','1','1500','5','1999');
INSERT INTO ofertas VALUES('4','1','1500','6','2000');
INSERT INTO ofertas VALUES('5','2','1500','5','1999');

INSERT INTO ofertasrechazadas VALUES('5');
INSERT INTO ofertas VALUES('6','3','1500','5','1999');
INSERT INTO ofertas VALUES('7','3','1500','5','1999');
INSERT INTO ofertas VALUES('8','3','1500','5','1999');
INSERT INTO ofertas VALUES('9','3','1500','5','1999');
INSERT INTO ofertasrechazadas VALUES('9');

-- Prueba disparador 4


INSERT INTO trabajadores VALUES('5', 'manolo@fda.tl', '234234', 'manolo', 'paco');
INSERT INTO trabajadores VALUES('6', 'asdfmanolo@fda.tl', '32234234', 'wafdmanolo', 'fasdfpaco');

INSERT INTO pistas VALUES('12', 'paquillo', '2', '1234');

-- Prueba disparador 5

INSERT INTO asignar VALUES('5', '5', '1999', '12', TO_DATE('12/03/1999 09:00:00', 'DD/MM/YYYY hh24:mi:ss'), TO_DATE('12/03/1999 10:00:00', 'DD/MM/YYYY hh24:mi:ss'));
INSERT INTO asignar VALUES('5', '5', '1999', '12', TO_DATE('12/03/1999 19:00:00', 'DD/MM/YYYY hh24:mi:ss'), TO_DATE('12/03/1999 20:00:00', 'DD/MM/YYYY hh24:mi:ss'));
INSERT INTO asignar VALUES('5', '5', '1999', '12', TO_DATE('12/03/1999 14:01:00', 'DD/MM/YYYY hh24:mi:ss'), TO_DATE('12/03/1999 15:00:00', 'DD/MM/YYYY hh24:mi:ss'));
INSERT INTO asignar VALUES('5', '5', '1999', '12', TO_DATE('12/03/1999 16:00:00', 'DD/MM/YYYY hh24:mi:ss'), TO_DATE('12/03/1999 17:00:00', 'DD/MM/YYYY hh24:mi:ss'));
INSERT INTO asignar VALUES('5', '5', '1999', '12', TO_DATE('12/03/1999 21:00:00', 'DD/MM/YYYY hh24:mi:ss'), TO_DATE('12/03/1999 22:00:00', 'DD/MM/YYYY hh24:mi:ss'));

-- Prueba Funcion Aceptar Oferta--
INSERT INTO ofertas VALUES('10','4','1500','5','1999');
INSERT INTO ofertas VALUES('11','4','1500','5','1999');
INSERT INTO ofertas VALUES('12','4','1500','5','1999');


-- Prueba disparador 2 

    -- Este da error
    INSERT INTO partidos VALUES('1',TO_DATE('12/03/1999 09:00:00', 'DD/MM/YYYY hh24:mi:ss'), 0);

    INSERT INTO jugadores VALUES('1','paco@gmail.com','643616263','paco','elmaquina');
    INSERT INTO jugadores VALUES('2','manolo@gmail.com','643616263','manolo','eltitan');
    INSERT INTO jugadores VALUES('3','juan@gmail.com','643616263','juan','elbestia');

    INSERT INTO edicion VALUES('5', '1999');

    INSERT INTO juegan VALUES('1','5','1','1999');
    INSERT INTO juegan VALUES('2','5','1','1999');
    INSERT INTO juegan VALUES('3','5','1','1999');

    -- Este esta bien
    INSERT INTO partidos VALUES('2',TO_DATE('13/03/1999 09:00:00', 'DD/MM/YYYY hh24:mi:ss'), 1);

    INSERT INTO juegan VALUES('1','5','2','1999');
    INSERT INTO juegan VALUES('2','5','2','1999');
    
    INSERT INTO partidosenpista VALUES('1','12');