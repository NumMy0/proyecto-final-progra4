package sistemamakeup;

import com.sun.net.httpserver.Headers;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.stream.Collectors;

public class RestServer {
    public static void main(String[] args) throws IOException {
        int port = 8080;
        HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);

        server.createContext("/api/productos", new ProductosHandler());
        server.createContext("/api/clientes", new ClientesHandler());

        server.setExecutor(null);
        System.out.println("REST server listening on http://localhost:" + port + "\nAPI endpoints: /api/productos, /api/clientes");
        server.start();
    }

    // Helper to add CORS and common headers
    private static void addCorsHeaders(Headers headers) {
        headers.add("Access-Control-Allow-Origin", "*");
        headers.add("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        headers.add("Access-Control-Allow-Headers", "Content-Type, Accept");
        headers.add("Content-Type", "application/json; charset=utf-8");
    }

    private static String readRequestBody(InputStream is) throws IOException {
        return new String(is.readAllBytes(), StandardCharsets.UTF_8);
    }

    // Handler for productos
    static class ProductosHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            String method = exchange.getRequestMethod();
            Headers respHeaders = exchange.getResponseHeaders();
            addCorsHeaders(respHeaders);

            if ("OPTIONS".equalsIgnoreCase(method)) {
                exchange.sendResponseHeaders(204, -1);
                return;
            }

            if ("GET".equalsIgnoreCase(method)) {
                ProductoDAO dao = new ProductoDAO();
                List<Producto> lista = dao.obtenerCatalogo();

                String json = lista.stream().map(p -> {
                    String tipo = "Producto";
                    String atributo = "";
                    if (p instanceof ProductoRostro) {
                        tipo = "Rostro";
                        atributo = ((ProductoRostro) p).getTipoPiel();
                    } else if (p instanceof ProductoOjos) {
                        tipo = "Ojos";
                        atributo = Boolean.toString(((ProductoOjos) p).isEsAPruebaDeAgua());
                    }

                    return "{"
                            + "\"id\":\"" + escape(p.getId()) + "\"," 
                            + "\"nombre\":\"" + escape(p.getNombre()) + "\"," 
                            + "\"precioBase\":" + p.getPrecioBase() + ","
                            + "\"marca\":\"" + escape(p.getMarca()) + "\"," 
                            + "\"stock\":" + p.getStock() + ","
                            + "\"tipo\":\"" + tipo + "\"," 
                            + "\"atributoEspecial\":\"" + escape(atributo) + "\""
                            + "}";
                }).collect(Collectors.joining(",", "[", "]"));

                byte[] resp = json.getBytes(StandardCharsets.UTF_8);
                exchange.sendResponseHeaders(200, resp.length);
                try (OutputStream os = exchange.getResponseBody()) {
                    os.write(resp);
                }
            } else {
                exchange.sendResponseHeaders(405, -1);
            }
        }
    }

    // Handler for clientes (GET list, POST insert)
    static class ClientesHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            String method = exchange.getRequestMethod();
            Headers respHeaders = exchange.getResponseHeaders();
            addCorsHeaders(respHeaders);

            if ("OPTIONS".equalsIgnoreCase(method)) {
                exchange.sendResponseHeaders(204, -1);
                return;
            }

            ClienteDAO dao = new ClienteDAO();

            if ("GET".equalsIgnoreCase(method)) {
                List<Cliente> lista = dao.obtenerClientesSuscritos();
                String json = lista.stream().map(c -> {
                    return "{"
                            + "\"id\":" + c.getId() + ","
                            + "\"nombre\":\"" + escape(c.getNombre()) + "\"," 
                            + "\"email\":\"" + escape(c.getEmail()) + "\""
                            + "}";
                }).collect(Collectors.joining(",", "[", "]"));

                byte[] resp = json.getBytes(StandardCharsets.UTF_8);
                exchange.sendResponseHeaders(200, resp.length);
                try (OutputStream os = exchange.getResponseBody()) {
                    os.write(resp);
                }
                return;
            }

            if ("POST".equalsIgnoreCase(method)) {
                String body = readRequestBody(exchange.getRequestBody()).trim();
                // Very small JSON parsing, expecting {"nombre":"...","email":"..."}
                String nombre = extractJsonValue(body, "nombre");
                String email = extractJsonValue(body, "email");

                if (nombre == null || email == null) {
                    String msg = "{\"error\":\"nombre y email requeridos\"}";
                    byte[] resp = msg.getBytes(StandardCharsets.UTF_8);
                    exchange.sendResponseHeaders(400, resp.length);
                    try (OutputStream os = exchange.getResponseBody()) { os.write(resp); }
                    return;
                }

                Cliente cliente = new Cliente(nombre, email);
                dao.insertarCliente(cliente);

                String res = "{\"ok\":true, \"mensaje\":\"cliente registrado\"}";
                byte[] resp = res.getBytes(StandardCharsets.UTF_8);
                exchange.sendResponseHeaders(201, resp.length);
                try (OutputStream os = exchange.getResponseBody()) { os.write(resp); }
                return;
            }

            exchange.sendResponseHeaders(405, -1);
        }
    }

    // Minimal JSON value extractor for flat objects (no nested, no escaped quotes handling)
    private static String extractJsonValue(String json, String key) {
        if (json == null) return null;
        String pattern = "\"" + key + "\"\s*:\s*\"";
        int idx = json.indexOf(pattern);
        if (idx == -1) return null;
        int start = idx + pattern.length();
        int end = json.indexOf('"', start);
        if (end == -1) return null;
        return json.substring(start, end);
    }

    private static String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n");
    }
}
