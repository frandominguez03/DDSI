-- Disparador para impedir que el mismo usuario pueda iniciar más de una compra al mismo tiempo
create or replace TRIGGER compraSimultanea
    BEFORE
    INSERT ON COMPRASPORUSUARIOSENEDICION
    FOR EACH ROW
DECLARE
    cuentainicializada INTEGER;
    cuentafinalizada INTEGER;

BEGIN
    SELECT count(*) INTO cuentainicializada FROM comprasiniciadas WHERE codcompra = :new.codcompra;
    SELECT count(*) INTO cuentafinalizada FROM comprasfinalizadas WHERE codcompra = :new.codcompra;

    IF(cuentainicializada > cuentafinalizada)
    THEN raise_application_error
    (-20600,:new.coduser||'No se puede iniciar mas de una compra a la vez');
    END IF;
END;