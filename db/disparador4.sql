-- -----------------------------------------------------
-- Disparador 4:
-- No se le puede asignar a un trabajador la misma pista 
-- dos veces el mismo día
-- -----------------------------------------------------

CREATE OR REPLACE TRIGGER asignarPista
    BEFORE 
        INSERT ON asignar
    FOR EACH ROW

    DECLARE
        existe INTEGER;

    BEGIN
        SELECT count(*) INTO existe FROM asignar WHERE codtrabajador = :new.codtrabajador AND codpista = :new.codpista AND TO_CHAR(fechaInicio, 'dd-mon-yyyy') = TO_CHAR(:new.fechaInicio, 'dd-mon-yyyy');

    IF(existe != 0)
    THEN
        (-20600,:new.coduser||"No se le puede asignar a un trabajador más de una vez una pista en el mismo día");
    END IF;
END;

