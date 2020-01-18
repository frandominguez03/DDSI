package ddsi1;
import java.sql.*;
import java.sql.SQLException.*;
import oracle.jdbc.driver.*;

public class DDSI {
    Connection con;
    
    public DDSI() {
        super();
    }
    
    public void initialize() throws Exception {
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        
        con = DriverManager.getConnection("jdbc:oracle:thin:@oracle0.ugr.es:1521/practbd.oracle0.ugr.es", "x5936034","x5936034");
        
        con.setAutoCommit (false);
        
        System.out.println("I am connected");
    }

    public static void main(String[] args) throws Exception {
        DDSI inst1 = new DDSI();
        
        inst1.initialize();
    }
}
