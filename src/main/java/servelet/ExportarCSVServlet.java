package servelet;

import Utils.CSVUtils;
import controladores.JuegoJpaController;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelos.Juego;

@WebServlet(name = "ExportCSVServlet", urlPatterns = {"/exportcsvmasbajos", "/exportcsvmasaltos"})
public class ExportarCSVServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getServletPath();
               // Obtener los datos de los juegos según el tipo de orden
        List<Juego> juegos = null;
        switch (action) {
          case "/exportcsvmasbajos":
                juegos = new JuegoJpaController().findJuegoOrderByPrecioAsc();
                break;
          case "/exportcsvmasaltos":
                juegos = new JuegoJpaController().findJuegoOrderByPrecioDesc();
                break;      
        }
 
       

         // Configurar la respuesta HTTP para descargar un archivo CSV
        response.setContentType("text/csv");
        String tipoOrden = action.equals("/exportcsvmasbajos") ? "masbajos" : "masaltos";
        // Configurar el encabezado para que el navegador pregunte dónde guardar el archivo
        response.setHeader("Content-Disposition", "attachment; filename=\"juegos_" + tipoOrden + ".csv\"; filename*=UTF-8''juegos_" + tipoOrden + ".csv");


        // Escribir los datos de los juegos en el cuerpo de la respuesta
        try {
            CSVUtils.exportarJuegos(response.getWriter(), juegos);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al exportar datos a CSV");
        }
    }
}
