<?php
include_once "dbcon.php";

/* Gestión de los formularios */
if($_SERVER["REQUEST_METHOD"] == "POST")
{
    if(!empty($_POST["codentrada"]) && !empty($_POST["tipoentrada"]) && !empty($_POST["precioentrada"]))
    {
        anadeTipoEntrada($_POST["codentrada"], $_POST["tipoentrada"], $_POST["precioentrada"]);
    }
}

/*
 *  @brief Funcion que acepta una oferta dada  
 *  @param idOferta (El id de la oferta a aceptar)
 *  @return Devuelve true si se acepta y false en caso contrario (ya sea porque no exista la oferta, ya esté aceptada o se encuentre rechazada)
 */
function aceptarOferta($idOferta):bool
{
    //Inicio la conexión a la base de datos
    $conexion = new DBCon();

    //Buscamos si la oferta que se pasa por parámetro se encuentra en la tabla de ofertas rechazadas
    $consulta = $conexion->prepare("SELECT COUNT(*) FROM `ofertasrechazadas` WHERE `codoferta` = $idOferta;");
    if($consulta && $consulta->execute() && $consulta->store_result())
    {
        $resultado = -1;
        $resultado = $consulta->get_result();
        $consulta->close();
        if($resultado == 0)
        {
            //Si el resultado es 0 es que la oferta existe y no ha sido rechazada
            $insercion = $conexion->prepare("INSERT INTO `ofertasaceptadas` VALUES (?);");
            if($insercion && $insercion->bind_param("i", $idOferta) && $insercion->execute())
                return true;
            else
                throw new Exception("La oferta ya habia sido aceptada", 201902);   
                
            $insercion->close();
        }else
            throw new Exception("La oferta ya ha sido rechazada", 201902);
    }
    
    return false; 
}

/*
 * @brief Introduce un nuevo tipo de entrada en la base de datos
 * @param int codentrada
 * @param string tipo
 * @param float precio
 * @return bool (exito o no)
 * @throws Exception
 */
function anadeTipoEntrada($codentrada, $tipo, $precio):bool
{
    //Inicio la conexión a la base de datos
    $con = new DBCon();
    
    $insercion = $this->con->prepare("INSERT INTO `entradas` (`codentrada`, `tipo`, `tipo`) VALUES (?, ?, ?);");
    if($insercion && $insercion->bind_param("isi", $codentrada, $tipo, $precio) && $insercion->execute())
        return true;
    
    else
        throw new Exception("Error al insertar en la base de datos", 201902);
    
    $insercion->close();

    $con->close();
    return false;
}


/*
 * @brief Asigna una pista y un horario a un trabajador
 * @param int codjugador
 * @param int numedicion
 * @param int anoedicion
 * @param int codpista
 * @param date fechaInicio
 * @param date fechaFin
 * @return bool (exito o no)
 * @throws Exception
 */
function asignarTrabajador($codjugador, $numedicion, $anoedicion, $codpista, $fechainicio, $fechafin):bool
{
    //Inicio la conexión a la base de datos
    $con = new DBCon();
    
    $insercion = $this->con->prepare("INSERT INTO `asignar` (`codjugador`, `numedicion`, `anoedicion`,`codpista`,`fechainicio`,`fechafin`) VALUES (?, ?, ?, ?, ?, ?);");
    if($insercion && $insercion->bind_param($codjugador, $numedicion, $anoedicion, $codpista, $fechainicio, $fechafin) && $insercion->execute())
        return true;
    
    else
        throw new Exception("Error al insertar en la base de datos", 201902);
    
    $insercion->close();

    $con->close();
    return false;
}

/*
 * @brief Muestra los partidos de una pista
 * @param int codpista
 */
function mostrarPartidoPista($codpista){
    //Inicio la conexión a la base de datos
    $con = new DBCon();

    $consulta= $this->con->prepare("SELECT 'idpartido' FROM 'partidosenpista' WHERE 'codpista' = ?;");

    if($consulta && $consulta->bind_param("i",$codpista) && $consulta->execute()){
        echo $consulta;
        return true;
    }
    
    else 
        throw new Exception("Error al realizar la consulta", 201902);

    $consulta->close();
    $con->close();

    return false;
}

/*
 *  @brief Se realiza una oferta a un árbitro
 *  @param float salario Salario ofrecido al árbitro
 *  @param int codarbitro Código del árbitro
 */

function ofertar($salario, $codarbitro){
    $con = new DBcon();
    $codoferta = 1;

    // Toma el mayor código para añadir el siguiente
    $consultaCod = $this->con->prepare("SELECT MAX(codcompra) FROM 'ofertas'");

    if($consultaCod && $consultaCod->execute() && $consultaCod->store_result())
        $codoferta = $consultaCod->get_result();

    $consultaCod->close();
    $codoferta++;

    // Inserta la oferta en la base de datos
    $insercionOf = $this->con->prepare("INSERT INTO `ofertas` (`codoferta`, `salario`) VALUES (?, ?);");
    if($insercionOf && $insercionOf->bind_param($codoferta, $salario) && $insercionOf->execute()){
        $insercionOf->close();
        
        $insercionGest = $this->con->prepare("INSERT INTO `gestiona` (`codarbitro`, `codoferta`) VALUES (?, ?);");
        if($insercionGest && $insercionGest->bind_param($codarbitro, $codoferta) && $insercionGest->execute()){

            $insercionGest->close();
            $con->close();

            return true;
        }
        
        else
            throw new Exception("Error al asociar la oferta con el arbitro", 201902);
    }
    
    else
        throw new Exception("Error al insertar la oferta en la base de datos", 201902);
    
    $insercionOf->close();
    $con->close();

    return false;
}

?>