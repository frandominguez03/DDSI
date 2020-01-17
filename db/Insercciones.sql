INSERT INTO arbitros VALUES('1','manolo@correo.tk','666666666','Manolo','Manolo');
INSERT INTO arbitros VALUES('2','juan@correo.tk','777777777','Juan','Manuel');
INSERT INTO arbitros VALUES('3','luisa@correo.tk','555555555','Luisa','Maria');

INSERT INTO edicion VALUES('5', '1999');
INSERT INTO edicion VALUES('6', '2000');

INSERT INTO ofertas VALUES('1','1','500','5','1999');
INSERT INTO ofertas VALUES('2','1','1000','5','1999');

INSERT INTO ofertasaceptadas VALUES('1');

INSERT INTO ofertas VALUES('3','1','1500','5','1999');
INSERT INTO ofertas VALUES('4','1','1500','6','2000');
INSERT INTO ofertas VALUES('5','2','1500','5','1999');

INSERT INTO ofertasrechazadas VALUES('5');

INSERT INTO ofertas VALUES('6','2','2000','5','1999');


INSERT INTO trabajadores VALUES('0', 'manolo@fda.tl', '234234', 'manolo', 'paco');
INSERT INTO trabajadores VALUES('1', 'asdfmanolo@fda.tl', '32234234', 'wafdmanolo', 'fasdfpaco');

INSERT INTO pistas VALUES('0', 'Calle Rengar', '2', '1234');

INSERT INTO asignar VALUES('5', '5', '1999', '12', TO_DATE('12/03/1999 09:00:00', 'DD/MM/YYYY hh24:mi:ss'), TO_DATE('12/03/1999 11:00:00', 'DD/MM/YYYY hh24:mi:ss'));

INSERT INTO asignar VALUES('5', '5', '1999', '12', TO_DATE('12/03/1999 11:00:00', 'DD/MM/YYYY hh24:mi:ss'), TO_DATE('12/03/1999 15:00:00', 'DD/MM/YYYY hh24:mi:ss'));

INSERT INTO asignar VALUES('5', '5', '1999', '12', TO_DATE('12/03/1999 17:00:00', 'DD/MM/YYYY hh24:mi:ss'), TO_DATE('12/03/1999 19:00:00', 'DD/MM/YYYY hh24:mi:ss'));
