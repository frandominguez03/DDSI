<?php
include_once "dbcon.php";
/*
 *  @brief Funcion que acepta una oferta dada  
 *  @param idOferta (El id de la oferta a aceptar)
 *  @return Devuelve true si se acepta y false en caso contrario (ya sea porque no exista la oferta, ya esté aceptada o se encuentre rechazada)
 */
function aceptarOferta($idOferta):bool
{
    //Inicio la conexión a la base de datos
    $conexion = new DBCon();
    

    //Buscamos en la tabla ofertas, la oferta identificada por el id que se pasa como parámetro
    $consulta = conexion->prepare("SELECT * FROM `ofertas` WHERE `codoferta` = $idOferta;")
    if($consulta && $consulta->execute() && Sconsulta->store_result())
    {
        //Almacenamos en oferta el resultado de la consulta anterior
        $oferta = $consulta->get_result();
        //Cerramos la conexión con la base de datos
        $consulta->close();
        //Buscamos si la oferta buscada se encuentra en la tabla de ofertas rechazadas
        $consulta = $conexion->prepare("SELECT COUNT(*) FROM `ofertasrechazadas` WHERE `codoferta` = $idOferta;");
        if($consulta && $consulta->execute() && Sconsulta->store_result())
        {
            $resultado = -1;
            $resultado = $consulta->get_result();
            $consulta->close();
            if($resultado == 0)
            {
                //Si el resultado es 0 es que la oferta existe y no ha sido rechazada
                $insercion = $conexion->("INSERT INTO `ofertasaceptadas` VALUES (?);");
                if($insercion && $insercion->bind_param($idOferta) && $insercion->execute())
                    return true;
                else
                    throw new Exception("La oferta ya habia sido aceptada", 201902);   
                    
                $insercion->close();
            }else
                throw new Exception("La oferta ya ha sido rechazada", 201902);
        }

    }else
        throw new Exception("La oferta indicada no existe", 201902);
    
    //Cierro la conexión con la base de datos
    $consulta->close();
    return false; 
}

?>