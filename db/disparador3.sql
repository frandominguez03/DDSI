--Disparador no puede ofertar a un árbitro si ese árbitro ya ha aceptado o rechazado una oferta
create or replace TRIGGER aceptadoRechazadoOferta
    BEFORE
    INSERT ON OFERTAS
    FOR EACH ROW
    
    DECLARE 
      contadorAcept INTEGER;
      contadorRech INTEGER;
    
    BEGIN
        SELECT COUNT(*) INTO contadorAcept FROM (SELECT * FROM OFERTAS O, OFERTASACEPTADAS O_ACEPT WHERE O.codoferta = O_ACEPT.codoferta  ) WHERE codarbitro = :new.codarbitro AND numedicion = :new.numedicion AND anoedicion = :new.anoedicion;
        SELECT COUNT(*) INTO contadorRech FROM (SELECT * FROM OFERTAS O, OFERTASRECHAZADAS O_RECH WHERE O.codoferta = O_RECH.codoferta  ) WHERE codarbitro = :new.codarbitro AND numedicion = :new.numedicion AND anoedicion = :new.anoedicion;

        
        IF( contadorAcept > 0 OR contadorRech > 0 )
        THEN raise_application_error
        (-20600,:new.codoferta||'No se puede ofertar a un árbitro que ya ha aceptado o rechazado una oferta');
        END IF;
    END;  

