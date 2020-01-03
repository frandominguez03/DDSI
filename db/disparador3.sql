--Disparador no puede ofertar a un árbitro si ese árbitro ya ha aceptado o rechazado una oferta--
CREATE OR REPLACE TRIGGER aceptadoRechazadoOferta
    BEFORE
    INSERT ON ofertas
    FOR EACH ROW

    BEGIN
        IF (SELECT FROM ofertasaceptadas WHERE codoferta = :new.codoferta ||SELECT FROM ofertasrechazadas WHERE codoferta = :new.codoferta  )
        THEN raise_application_error
        (-20600,:new.codoferta||"No se puede ofertar a un árbitro que ya ha aceptado o rechazado una oferta");
        END IF;
    END;    