package servelet;
import controladores.CategoriaJpaController;
import controladores.JuegoJpaController;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Categoria;

import modelos.Juego;

@WebServlet(name = "JuegoServlet", urlPatterns = {"/juegos", "/juegoscrear", "/juegoseditar", "/juegoseliminar"})
public class juegoServelet extends HttpServlet {

    private JuegoJpaController juegoController;
     private CategoriaJpaController categoriaController;


    @Override
    public void init() throws ServletException {
        super.init();
        juegoController = new JuegoJpaController();
         categoriaController = new CategoriaJpaController();

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/juegos":
                mostrarJuegos(request, response);
                break;
            case "/juegoscrear":
                mostrarFormularioCrearJuego(request, response);
                break;
            case "/juegoseditar":
                mostrarFormularioEditarJuego(request, response);
                break;
            case "/juegoseliminar":
                eliminarJuego(request, response);
                break;
            default:
                // Lógica para otras rutas si es necesario
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getServletPath();

        switch (action) {
            case "/juegoscrear":
                crearJuego(request, response);
                break;
            case "/juegoseditar":
                editarJuego(request, response);
                break;
            default:
                // Lógica para otras rutas si es necesario
                break;
        }
    }

    private void mostrarJuegos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Juego> juegos = juegoController.findJuegoEntities();
        request.setAttribute("juegos", juegos);
        RequestDispatcher dispatcher = request.getRequestDispatcher("juegos/index.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioCrearJuego(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           List<Categoria> categorias = categoriaController.findCategoriaEntities();
        request.setAttribute("categorias", categorias);
        RequestDispatcher dispatcher = request.getRequestDispatcher("juegos/crear.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioEditarJuego(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idJuego = Integer.parseInt(request.getParameter("id"));
        Juego juego = juegoController.findJuego(idJuego);
             List<Categoria> categorias = categoriaController.findCategoriaEntities();
        request.setAttribute("categorias", categorias);
        request.setAttribute("juego", juego);
     

        RequestDispatcher dispatcher = request.getRequestDispatcher("juegos/editar.jsp");
        dispatcher.forward(request, response);
    }

private void crearJuego(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    try{
        String nomJuego = request.getParameter("nomJuego");
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
        float precio = Float.parseFloat(request.getParameter("precio"));
        int existencias = Integer.parseInt(request.getParameter("existencias"));
        String imagen = request.getParameter("imagen");
        String clasificacion = request.getParameter("clasificacion");
        
        // Verificar si ya existe un juego con el mismo nombre
        Juego juegoExistente = juegoController.findByNomJuego(nomJuego);
        if (juegoExistente != null) {
            // Si ya existe un juego con el mismo nombre, mostrar mensaje de error
            session.setAttribute("errorMessage", "Ya existe un juego con ese nombre");
            response.sendRedirect("juegos");
            return;
        }
        
        // Obtener el objeto Categoria correspondiente al ID
        Categoria categoria = new Categoria();
        categoria.setIdcategoria(idCategoria);

        Juego juego = new Juego();
        juego.setNomJuego(nomJuego);
        juego.setIdcategoria(categoria);
        juego.setPrecio(precio);
        juego.setExistencias(existencias);
        juego.setImagen(imagen);
        juego.setClasificacion(clasificacion);

        juegoController.create(juego);
        session.setAttribute("successMessage", "Juego creado con éxito");
        response.sendRedirect("juegos");
    }catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("errorMessage", "Error al crear el Juego");
        response.sendRedirect("juegos?error=true");
    }


}

private void editarJuego(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();

    int idJuego = Integer.parseInt(request.getParameter("idJuego"));
    String nomJuego = request.getParameter("nomJuego");
    int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
    float precio = Float.parseFloat(request.getParameter("precio"));
    int existencias = Integer.parseInt(request.getParameter("existencias"));
    String imagen = request.getParameter("imagen");
    String clasificacion = request.getParameter("clasificacion");

    // Obtener el objeto Categoria correspondiente al ID
    Categoria categoria = new Categoria();
    categoria.setIdcategoria(idCategoria);

    Juego juego = new Juego();
    juego.setIdjuego(idJuego);
    juego.setNomJuego(nomJuego);
    juego.setIdcategoria(categoria);
    juego.setPrecio(precio);
    juego.setExistencias(existencias);
    juego.setImagen(imagen);
    juego.setClasificacion(clasificacion);

    try {
        Juego juegoExistente = juegoController.findJuego(idJuego);
        if (juegoExistente != null) {
            // Verificar si el nombre del juego ha sido modificado
            if (!juegoExistente.getNomJuego().equals(nomJuego)) {
                // Si el nombre ha sido modificado, realizar la validación
                // Buscar si el nombre del juego ya existe en la base de datos
                Juego juegoExistenteConMismoNombre = juegoController.findByNomJuego(nomJuego);
                if (juegoExistenteConMismoNombre != null) {
                    session.setAttribute("errorMessage", "El nombre del juego ya existe");
                    response.sendRedirect("juegos?error=true");
                    return; // Terminar la ejecución del método
                }
            }
        }

        // Si no hay problema con el nombre, proceder con la edición
        juegoController.edit(juego);
        session.setAttribute("successMessage", "Juego editado con éxito");
        response.sendRedirect("juegos");
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("errorMessage", "Error al editar el Juego");
        response.sendRedirect("juegos?error=true");
    }
}



    private void eliminarJuego(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            HttpSession session = request.getSession();
        int idJuego = Integer.parseInt(request.getParameter("id"));

        try {
            juegoController.destroy(idJuego);
                session.setAttribute("successMessage", "Juego eliminado con éxito");
            response.sendRedirect("juegos");
        } catch (Exception ex) {
            ex.printStackTrace();
                session.setAttribute("errorMessage", "Error al eliminar el Juego");
            response.sendRedirect("juegos?error=true");
        }
    }
}