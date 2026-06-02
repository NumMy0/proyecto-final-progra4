package sistemamakeup;

public class ProductoRostro extends Producto {
    private String tipoPiel; // Ej: Grasa, Seca, Mixta

    public ProductoRostro(String id, String nombre, double precioBase, String marca, int stock, String tipoPiel) {
        super(id, nombre, precioBase, marca, stock); // Llama al constructor de la clase padre
        this.tipoPiel = tipoPiel;
    }

    // Sobrescritura del método abstracto (Polimorfismo)
    @Override
    public double calcularPrecioFinal() {
        // Los productos de rostro pagan un 10% adicional por arancel de cuidado dermatológico
        return getPrecioBase() * 1.10;
    }

    // Sobrescritura del método de la interfaz Descontable
    @Override
    public void aplicarDescuento(double porcentaje) {
        double descuento = getPrecioBase() * (porcentaje / 100);
        setPrecioBase(getPrecioBase() - descuento);
    }

    @Override
    public void mostrarInformacion() {
        super.mostrarInformacion();
        System.out.println(" | [Rostro - Tipo Piel: " + tipoPiel + "] -> Precio con Impuesto: $" + String.format("%.2f", calcularPrecioFinal()));
    }

    // Getter y Setter
    public String getTipoPiel() { return tipoPiel; }
    public void setTipoPiel(String tipoPiel) { this.tipoPiel = tipoPiel; }
}
