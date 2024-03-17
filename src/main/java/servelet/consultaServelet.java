package servelet;

import controladores.JuegoJpaController;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelos.Juego;

@WebServlet(name = "ConsultaServlet", urlPatterns = {"/consultar", "/reporte"})
public class consultaServelet extends HttpServlet {

    private JuegoJpaController juegoController;

    @Override
    public void init() throws ServletException {
        super.init();
        juegoController = new JuegoJpaController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/consultar":
                generarReporteMasCaro(request, response);
                break;
            case "/reporte":
                generarReporteMasBarato(request, response);
                break;
            default:
                // Acción desconocida
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void generarReporteMasCaro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Juego> juegos = juegoController.findJuegoOrderByPrecioDesc();
        request.setAttribute("juegos", juegos);
        request.getRequestDispatcher("consulta/reporte_mas_caro.jsp").forward(request, response);
    }

    private void generarReporteMasBarato(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Juego> juegos = juegoController.findJuegoOrderByPrecioAsc();
        request.setAttribute("juegos", juegos);
        request.getRequestDispatcher("consulta/reporte_mas_barato.jsp").forward(request, response);
    }
}
