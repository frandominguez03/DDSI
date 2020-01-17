
--  Disparador para impedir que no se le pueda asignar a un trabajador un trabajo con menos de 1 hora de diferencia
CREATE OR REPLACE TRIGGER horaDiferencia
    BEFORE
    INSERT ON ASIGNAR
    FOR EACH ROW
DECLARE
  CURSOR horas IS SELECT fechaInicio, fechaFin FROM asignar WHERE codtrabajador = :new.codtrabajador 
    and TO_CHAR(fechaInicio,'YYY-MM-DD') = TO_CHAR(:new.fechaInicio,'YYY-MM-DD') and TO_CHAR(fechaFin,'YYY-MM-DD') = TO_CHAR(:new.fechaFin,'YYY-MM-DD');
BEGIN
    FOR fecha IN horas LOOP
      IF fecha.fechaFin + 1/24 > :new.fechaInicio 
        THEN raise_application_error(-20600, :new.codtrabajador || 'No se le puede asignar el trabajo con menos de 1 hora de diferencia');
      END IF;
    END LOOP;
END;


