package ddsi;
import java.sql.*;
import java.sql.SQLException.*;
import java.util.Scanner;
import oracle.jdbc.driver.*;

public class DDSI {
    Connection con;
    Statement stmt;
    PreparedStatement pstmt;
    
    public DDSI() {
        super();
    }
    
    public void initialize() throws Exception {
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        
        con = DriverManager.getConnection("jdbc:oracle:thin:@oracle0.ugr.es:1521/practbd.oracle0.ugr.es", "x7035152","x7035152");
        
        con.setAutoCommit (false);
        
        System.out.println("I am connected");
    }
    
    public boolean addTipoEntrada(int codentrada, String tipo, int precio) throws Exception {
        try
        {
            pstmt = con.prepareStatement("INSERT INTO ENTRADAS VALUES(?,?,?)");
            pstmt.setInt(1, codentrada);
            pstmt.setString(2, tipo);
            pstmt.setInt(3, precio);
            pstmt.executeUpdate();
            con.commit();
            return true; // return OK
        }
        
        catch (SQLException e)
        {
            System.out.println("Error al insertar tipo de entrada" + e);
            return false; // return error
        }
    }
    
    public boolean asignarTrabajador(int codtrabajador, int numedicion, int anoedicion, int codpista, Timestamp fechaInicio, Timestamp fechaFin) throws Exception{
        try
        {
            pstmt = con.prepareStatement("INSERT INTO asignar VALUES(?,?,?,?,?,?)");
            pstmt.setInt(1, codtrabajador);
            pstmt.setInt(2, numedicion);
            pstmt.setInt(3, anoedicion);
            pstmt.setInt(4, codpista);
            pstmt.setTimestamp(5, fechaInicio);
            pstmt.setTimestamp(6, fechaFin);
            pstmt.executeUpdate();
            con.commit();
            return true; // return OK
        }
        
        catch (SQLException e)
        {
            System.out.println("Error al asignar trabajador" + e);
            return false; // return error
        }  
    }
    
    public void mostrarTrabajadoresAsignados()throws Exception{
        stmt = con.createStatement();
        ResultSet rset = stmt.executeQuery("SELECT * FROM asignar");
        
        while (rset.next()){
            System.out.println( rset.getInt(1) + " " + rset.getInt(2) + " " + rset.getInt(3) + " " + rset.getInt(4) + " " + rset.getString(5) + " " + rset.getString(6));
        }
    }
    
    public String mostrarPartidosPista(int codpista) throws Exception{
        stmt = con.createStatement();
        ResultSet rset = stmt.executeQuery("SELECT IDPARTIDO FROM PARTIDOSENPISTA where CODPISTA = " + codpista + " ");
        
        String salida = "Los partidos jugados en la pista "+ codpista + " son:\n";
        
        while (rset.next ()){
            salida += "Partido "+rset.getInt(1)+"\n";
        }

        return salida;
    }
    
    public void getTipoEntrada(int codentrada) throws Exception{
        stmt = con.createStatement();
        ResultSet rset = stmt.executeQuery("SELECT * FROM ENTRADAS where CODENTRADA = " + codentrada + " ");
        
        while (rset.next ()){
            System.out.println( rset.getInt(1) + " " + rset.getString(2)+ " " + rset.getInt(3));
        }
    }
    
    public boolean ofertar(int codoferta, float salario, int codarbitro, int numedicion, int anoedicion) throws Exception{      
        try
        {
            pstmt = con.prepareStatement("INSERT INTO OFERTAS VALUES(?,?,?,?,?)");
            pstmt.setInt(1, codoferta);
            pstmt.setInt(2, codarbitro);
            pstmt.setFloat(3, salario);
            pstmt.setInt(4, numedicion);
            pstmt.setInt(5, anoedicion);
            pstmt.executeUpdate();
            con.commit();
            return true;
        }
        
        catch (SQLException e)
        {
            System.out.println("Error al insertar en ofertas" + e);
            return false;
        }
    }

    public boolean gestionaOferta( int idArbitro) throws Exception 
    {
        int numEdicion, anoEdicion, idOferta;
        Scanner capt = new Scanner(System.in);
        System.out.println("Introduzca su código de árbitro : ");
        //idArbitro = capt.nextInt();
        idArbitro = 4;
        System.out.println("Bienvenido árbitro número "+idArbitro+" , introduzca el número de edición y el año para el que quiere realizar la consulta");
        //numEdicion = capt.nextInt();
        //anoEdicion = capt.nextInt();
        numEdicion = 5;
        anoEdicion = 1999;
        
        if(this.mostrarOfertasDisponibles(idArbitro, numEdicion, anoEdicion))
        {
        System.out.println("Introduce el código de la oferta que quieres aceptar ");
        //idOferta = capt.nextInt();
        idOferta = 10;
        if(this.aceptarOferta(idOferta,idArbitro,numEdicion,anoEdicion))
        {
                System.out.println("Se ha aceptado la oferta "+idOferta+" correctamente!");
                return true;
            }else 
            {
                System.out.println("Lo sentimos ha habido un error... Contacta con el administrador del sistema para más información");
                return false;   
            }
        }else{
            System.out.println("No puedes gestionar ofertas para la edición introducida");
            return false;
        }
        
    }
    
    public boolean puedeGestionar(int idArbitro, int numEdicion, int anoEdicion) throws Exception 
    {
        int contadorAcept = 0;
        int contadorRech = 0;
        stmt = con.createStatement();
        ResultSet rset = stmt.executeQuery("SELECT * FROM OFERTAS O, OFERTASACEPTADAS O_ACEPT WHERE O.codoferta = O_ACEPT.codoferta AND codarbitro = "+idArbitro+" AND numedicion = "+numEdicion+" AND anoedicion = "+anoEdicion+"");
        while (rset.next ()){
            contadorAcept++;
        }
        
        ResultSet rset2 = stmt.executeQuery("SELECT * FROM OFERTAS O, OFERTASRECHAZADAS O_RECH WHERE O.codoferta = O_RECH.codoferta AND codarbitro = "+idArbitro+" AND numedicion = "+numEdicion+" AND anoedicion = "+anoEdicion+"");

        while (rset2.next ()){
            contadorRech++;
        }
        
        if(contadorAcept > 0 || contadorRech > 0){
            return false; //Se ha aceptado o rechazado una oferta
        }
        else
            return true; //No se ha aceptado o rechazado ninguna oferta
    }
    
    public boolean mostrarOfertasDisponibles(int idArbitro,int numEdicion, int anoEdicion) throws Exception
    {
        if(this.puedeGestionar(idArbitro, numEdicion, anoEdicion)) 
        {
            stmt = con.createStatement();
            ResultSet rset = stmt.executeQuery("SELECT * FROM OFERTAS WHERE codarbitro = "+idArbitro+" AND numedicion = "+numEdicion+" AND anoedicion = "+anoEdicion+"");
            while (rset.next ()){
                System.out.println( rset.getInt(1) + " " + rset.getInt(2)+ " " + rset.getInt(3));
            }
            return true;
        }else
            return false;    
            
    }
    public boolean aceptarOferta(int idOferta,int idArbitro, int numEdicion, int anoEdicion) throws Exception 
    {
        int contador = 0;
        stmt = con.createStatement();
        ResultSet rset = stmt.executeQuery("SELECT * FROM OFERTAS WHERE codarbitro = "+idArbitro+" AND numedicion = "+numEdicion+" AND anoedicion = "+anoEdicion+"");
        while (rset.next ()){
            contador++;
        }
        if(contador > 0)
        {
            pstmt = con.prepareStatement("INSERT INTO ofertasaceptadas VALUES(?)");
            pstmt.setInt(1, idOferta);
            pstmt.executeUpdate();
            con.commit();
            return true;
        }else
            return false;
    }


    public static void main(String[] args) throws Exception {
        DDSI inst1 = new DDSI();
        
        inst1.initialize();
        
        boolean result = inst1.addTipoEntrada(1, "Tipo1", 33);
        if (!result){
        System.out.println("ERROR");
        return;
        }
        System.out.println("-Tipo added");
        
        inst1.getTipoEntrada(1);
    }
}
