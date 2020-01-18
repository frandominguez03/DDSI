package ddsi1;
import java.sql.*;
import java.sql.SQLException.*;
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
        
        con = DriverManager.getConnection("jdbc:oracle:thin:@oracle0.ugr.es:1521/practbd.oracle0.ugr.es", "x5936034","x5936034");
        
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
    
    public void mostrarPartidosPista(int codpista) throws Exception{
        stmt = con.createStatement();
        ResultSet rset = stmt.executeQuery("SELECT IDPARTIDO FROM PARTIDOSENPISTA where CODPISTA = " + codpista + " ");
        
        while (rset.next ()){
            System.out.println( rset.getInt(1));
        }
    }
    
    public void getTipoEntrada(int codentrada) throws Exception{
        stmt = con.createStatement();
        ResultSet rset = stmt.executeQuery("SELECT * FROM ENTRADAS where CODENTRADA = " + codentrada + " ");
        
        while (rset.next ()){
            System.out.println( rset.getInt(1) + " " + rset.getString(2)+ " " + rset.getInt(3));
        }
    }
    
    public boolean ofertar(float salario, int codarbitro, int numedicion, int anoedicion) throws Exception{
        stmt = con.createStatement();
        ResultSet rset = stmt.executeQuery("SELECT MAX(CODOFERTA) FROM OFERTAS");
        int codoferta = rset.getInt(1)+1;
        
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
