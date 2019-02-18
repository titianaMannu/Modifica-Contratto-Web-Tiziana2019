package DAO;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * restituisce connessione al db
 */
public class DBConnect {

    public static Connection getConnection() throws SQLException{
        Connection conn = null;
        Context initContext;
        try {
            initContext= new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            DataSource ds= (DataSource) envContext.lookup("jdbc/FERSA");
            conn = ds.getConnection();

        } catch (NamingException e) {
            e.printStackTrace();
        }

        return conn;
    }

    //semplice implementazione per ottenere una connessione
    public static Connection getSimpleConnection() throws ClassNotFoundException, SQLException{
        Connection conn = null;
        //loading dinamico del driver mysql
        Class.forName("com.mysql.jdbc.Driver");
        //url
        String dburl = "jdbc:mysql://localhost/FERSA?user=modificatore&password=M.odificatore";
        //apertura connessione
        conn = DriverManager.getConnection(dburl);

        return conn;
    }
}
