-- Disparador para impedir que el mismo usuario pueda iniciar más de una compra al mismo tiempo
CREATE OR REPLACE TRIGGER compraSimultanea
    BEFORE
    INSERT ON comprasPorUsuariosEnEdicion
    FOR EACH ROW
DECLARE
    cuentainicializada INTEGER;
    cuentafinalizada INTEGER;

BEGIN
    SELECT count(*) INTO cuentainicializada FROM comprasiniciadas WHERE coduser = :new.coduser;
    SELECT count(*) INTO cuentafinalizada FROM comprasfinalizadas WHERE coduser = :new.coduser;

    IF(cuentainicializada > cuentafinalizada)
    THEN raise_application_error
    (-20600,:new.coduser||"No se puede iniciar más de una compra a la vez");
    END IF;
END;
