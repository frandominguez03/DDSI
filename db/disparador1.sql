-- Disparador para impedir que el mismo usuario pueda iniciar más de una compra al mismo tiempo

create or replace TRIGGER comprasusuario
    BEFORE
      INSERT ON comprasiniciadas
    FOR EACH ROW
DECLARE
    comprasActivas INTEGER;
    usuario INTEGER;

BEGIN
    SELECT coduser INTO usuario FROM comprasPorUsuariosEnEdicion WHERE codcompra = :new.codcompra;
    SELECT COUNT(X.codcompra) INTO comprasActivas FROM comprasiniciadas X, comprasPorUsuariosEnEdicion Y
                                          WHERE X.codcompra = Y.codcompra AND usuario = Y.coduser;

    IF(comprasActivas > 0)
    THEN raise_application_error
    (-20600,:new.codcompra||'No se puede iniciar mas de una compra a la vez con el mismo usuario');
    END IF;
END;
