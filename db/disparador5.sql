--  Disparador para impedir que no se le pueda asignar a un trabajador un trabajo con menos de 1 hora de diferencia
CREATE OR REPLACE TRIGGER horaDiferencia
    BEFORE
    INSERT ON asignar
    FOR EACH ROW
DECLARE
    fechaL INTEGER;
    fechaS INTEGER;
BEGIN
    SELECT to_number(to_char(fechaInicio)),to_number(to_char(fechaFin)) INTO fechaL,fechaS FROM asignar WHERE codtrabajador = :new.codtrabajador;
    if(fechaL - fechaS < 10000) THEN
        raise_application_error(-20600, :new.codtrabajador || 'No se le puede asignar el trabajo con menos de 1 hora de diferencia');
END
