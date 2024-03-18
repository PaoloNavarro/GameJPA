package Utils;

import java.io.PrintWriter;
import java.util.List;
import modelos.Juego;



public class CSVUtils {

    public static void exportarJuegos(PrintWriter writer, List<Juego> juegos) {
        // Escribir encabezados CSV
        writer.println("Nombre;Categoría;Precio;Existencias;Calificación");

        // Escribir datos de juegos
        for (Juego juego : juegos) {
            writer.println(
                    juego.getNomJuego() + ";" +
                    juego.getIdcategoria().getCategoria() + ";" +
                    juego.getPrecio() + ";" +
                    juego.getExistencias() + ";" +
                    juego.getClasificacion()
            );
        }
    }
}


