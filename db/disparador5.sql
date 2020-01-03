--  Disparador para impedir que no se le pueda asignar a un trabajador un trabajo con menos de 1 hora de diferencia
CREATE OR REPLACE TRIGGER horaDiferencia
    BEFORE
    INSERT ON asignar
    FOR EACH ROW
BEGIN
    SELECT codtrabajador FROM asignar WHERE codtrabajador = :new.codtrabajador;



END
