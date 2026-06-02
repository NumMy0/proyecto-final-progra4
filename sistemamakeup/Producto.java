package sistemamakeup;

public abstract class Producto implements Descontable {
    // Atributos encapsulados (privados)
    private String id;
    private String nombre;
    private double precioBase;
    private String marca;
    private int stock;

    // Constructor
    public Producto(String id, String nombre, double precioBase, String marca, int stock) {
        this.id = id;
        this.nombre = nombre;
        this.precioBase = precioBase;
        this.marca = marca;
        this.stock = stock;
    }

    // Método abstracto que cada hijo implementará de forma distinta
    public abstract double calcularPrecioFinal();

    // Método concreto para mostrar información básica
    public void mostrarInformacion() {
        System.out.print("ID: " + id + " | " + nombre + " (" + marca + ") - Precio Base: $" + precioBase);
    }

    // Métodos Getters y Setters (Encapsulamiento)
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public double getPrecioBase() { return precioBase; }
    public void setPrecioBase(double precioBase) { this.precioBase = precioBase; }

    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
}