package sistemamakeup;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    // Configuración para MySQL en XAMPP (Puerto por defecto 3306)
    private static final String URL = "jdbc:mysql://localhost:3306/sistema_maquillaje?useSSL=false&serverTimezone=UTC";
    private static final String USER = System.getenv().getOrDefault("MYSQL_USER", "root");
    private static final String PASSWORD = System.getenv().getOrDefault("MYSQL_PASSWORD", "");

    public static Connection conectar() {
        Connection con = null;
        try {
            // Cargar el driver de MySQL en memoria
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("Error: No se encontró el Driver de MySQL.");
        } catch (SQLException e) {
            System.out.println("Error al conectar a MySQL: " + e.getMessage());
        }
        return con;
    }
}