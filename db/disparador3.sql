--Disparador no puede ofertar a un árbitro si ese árbitro ya ha aceptado o rechazado una oferta
create or replace TRIGGER aceptadoRechazadoOferta
    BEFORE
    INSERT ON OFERTAS
    FOR EACH ROW
    
    DECLARE 
      contadoraceptada INTEGER;
      contadorrechazada INTEGER;
    
    BEGIN
        SELECT COUNT(*) INTO contadoraceptada FROM OFERTASACEPTADAS WHERE codoferta = :new.codoferta;
        
        SELECT COUNT(*) INTO contadorrechazada FROM OFERTASRECHAZADAS WHERE codoferta = :new.codoferta;
        
        IF(contadoraceptada!=0 or contadorrechazada!=0)
        THEN raise_application_error
        (-20600,:new.codoferta||'No se puede ofertar a un árbitro que ya ha aceptado o rechazado una oferta');
        END IF;
    END;  

drop trigger aceptadoRechazadoOferta

    -- Otra version -- 
    create or replace TRIGGER aceptadoRechazadoOferta
    BEFORE
    INSERT ON GESTIONA
    FOR EACH ROW
    
    DECLARE 
      contadorGestionada INTEGER;
    
    BEGIN
        SELECT COUNT(*) INTO contadorGestionada FROM GESTIONA WHERE codarbitro = :new.codarbitro;

        IF( contadorGestionada != 0 )
        THEN raise_application_error
        (-20600,:new.codarbitro||'No se puede ofertar a un árbitro que ya ha aceptado o rechazado una oferta');
        END IF;
    END;  
