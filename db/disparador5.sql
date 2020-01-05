--  Disparador para impedir que no se le pueda asignar a un trabajador un trabajo con menos de 1 hora de diferencia
CREATE OR REPLACE TRIGGER horaDiferencia
    BEFORE
    INSERT ON ASIGNAR
    FOR EACH ROW
DECLARE
  totalHoras INTEGER;
BEGIN
    SELECT TO_DATE(fechaInicio,'YYYY-MM-DD HH:MM:SS') - TO_DATE(fechaFin,'YYYY-MM-DD HH:MM:SS') INTO totalHoras FROM asignar WHERE codtrabajador = :new.codtrabajador;
    
    IF(totalHoras < 10000)
      THEN raise_application_error(-20600, :new.codtrabajador || 'No se le puede asignar el trabajo con menos de 1 hora de diferencia');
    END IF;
END;


