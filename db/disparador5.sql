--  Disparador para impedir que no se le pueda asignar a un trabajador un trabajo con menos de 1 hora de diferencia
CREATE OR REPLACE TRIGGER horaDiferencia
    BEFORE
    INSERT ON asignar
    FOR EACH ROW
DECLARE
    fechaL INTEGER;
    fechaS INTEGER;
BEGIN
    SELECT * INTO fechaL,fechaS FROM asignar WHERE codtrabajador = :new.codtrabajador 
    AND year(fechaInicio) = year(:new.fechaInicio) AND year(fechaFin) = year(:new.fechaFin) AND month(fechaInicio) = month(:new.fechaInicio) 
    AND month(fechaFin) = month(:new.fechaFin) AND day(fechaInicio) = day(:new.fechaInicio) AND day(fechaFin) = day(:new.fechaFin);
    if(fechaL - fechaS < 10000) THEN
        raise_application_error(-20600, :new.codtrabajador || 'No se le puede asignar el trabajo con menos de 1 hora de diferencia');
END
