-- Disparador para que no haya mas de 2 tenistas en un partido
create or replace TRIGGER tenistaspartido
    BEFORE
    INSERT ON JUEGAN
    FOR EACH ROW
DECLARE
    cuentatenistas INTEGER;

BEGIN
    SELECT count(*) INTO cuentatenistas FROM JUEGAN WHERE idpartido = :new.idpartido;

    IF(cuentatenistas > 1)
    THEN raise_application_error
    (-20600,:new.idpartido||'No puede haber mas de dos tenistas en un partido');
    END IF;
END; 