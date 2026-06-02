package sistemamakeup;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    // Método para traer el catálogo vivo desde la BD MySQL
    public List<Producto> obtenerCatalogo() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos";

        try (Connection con = ConexionBD.conectar();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String id = rs.getString("id");
                String nombre = rs.getString("nombre");
                double precio = rs.getDouble("precioBase");
                String marca = rs.getString("marca");
                int stock = rs.getInt("stock");
                String tipo = rs.getString("tipo");
                String atributo = rs.getString("atributoEspecial");

                // Reconstruimos el objeto polimórfico según el tipo en la BD
                if (tipo.equalsIgnoreCase("Rostro")) {
                    lista.add(new ProductoRostro(id, nombre, precio, marca, stock, atributo));
                } else if (tipo.equalsIgnoreCase("Ojos")) {
                    boolean esWaterproof = Boolean.parseBoolean(atributo);
                    lista.add(new ProductoOjos(id, nombre, precio, marca, stock, esWaterproof));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al leer el catálogo de MySQL: " + e.getMessage());
        }
        return lista;
    }
}
