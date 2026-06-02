package sistemamakeup;

public class ProductoOjos extends Producto {
    private boolean esAPruebaDeAgua;

    public ProductoOjos(String id, String nombre, double precioBase, String marca, int stock, boolean esAPruebaDeAgua) {
        super(id, nombre, precioBase, marca, stock);
        this.esAPruebaDeAgua = esAPruebaDeAgua;
    }

    // Sobrescritura con lógica diferente a la clase ProductoRostro
    @Override
    public double calcularPrecioFinal() {
        // Los productos de ojos tienen un recargo fijo de $2.0 por empaque de protección
        return getPrecioBase() + 2.0;
    }

    @Override
    public void aplicarDescuento(double porcentaje) {
        double descuento = getPrecioBase() * (porcentaje / 100);
        setPrecioBase(getPrecioBase() - descuento);
    }

    @Override
    public void mostrarInformacion() {
        super.mostrarInformacion();
        String waterproof = esAPruebaDeAgua ? "Sí" : "No";
        System.out.println(" | [Ojos - Waterproof: " + waterproof + "] -> Precio con Empaque: $" + String.format("%.2f", calcularPrecioFinal()));
    }

    // Getter y Setter
    public boolean isEsAPruebaDeAgua() { return esAPruebaDeAgua; }
    public void setEsAPruebaDeAgua(boolean esAPruebaDeAgua) { this.esAPruebaDeAgua = esAPruebaDeAgua; }
}