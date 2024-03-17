package servelet;
import controladores.CategoriaJpaController;
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

@WebServlet(name = "CategoriaServlet", urlPatterns = {"/categorias", "/categoriascrear", "/categoriaseditar", "/categoriaseliminar"})
public class categoriaServelet extends HttpServlet {

    private CategoriaJpaController categoriaController;
    

    @Override
    public void init() throws ServletException {
        super.init();
        categoriaController = new CategoriaJpaController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/categorias":
                mostrarCategorias(request, response);
                break;
            case "/categoriascrear":
                mostrarFormularioCrearCategoria(request, response);
                break;
            case "/categoriaseditar":
                mostrarFormularioEditarCategoria(request, response);
                break;
            case "/categoriaseliminar":
                eliminarCategoria(request, response);
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
            case "/categoriascrear":
                crearCategoria(request, response);
                break;
            case "/categoriaseditar":
                editarCategoria(request, response);
                break;
            default:
                // Lógica para otras rutas si es necesario
                break;
        }
    }

    private void mostrarCategorias(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Categoria> categorias = categoriaController.findCategoriaEntities();
        request.setAttribute("categorias", categorias);
        RequestDispatcher dispatcher = request.getRequestDispatcher("categorias/index.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioCrearCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("categorias/crear.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioEditarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idCategoria = Integer.parseInt(request.getParameter("id"));
        Categoria categoria = categoriaController.findCategoria(idCategoria);
        request.setAttribute("categoria", categoria);
        RequestDispatcher dispatcher = request.getRequestDispatcher("categorias/editar.jsp");
        dispatcher.forward(request, response);
    }

    private void crearCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                        HttpSession session = request.getSession();
                        try{
                            String nombreCategoria = request.getParameter("categoria");
                            String urlCategoria = request.getParameter("imagen");
                            Categoria categoria = new Categoria();
                            categoria.setCategoria(nombreCategoria);
                            categoria.setImagenCat(urlCategoria);
                            categoriaController.create(categoria);
                             session.setAttribute("successMessage", "Categoria creada con éxito");
                            response.sendRedirect("categorias");
                        }catch(Exception ex){
                                 session.setAttribute("errorMessage", "Error al crear al Categoria");
                            response.sendRedirect("categorias");
                        }
        
    }

    private void editarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                HttpSession session = request.getSession();

        int idCategoria = Integer.parseInt(request.getParameter("idCategoria1"));
        String nombreCategoria = request.getParameter("categoria");
        String imagen = request.getParameter("imagen");
        Categoria categoria = categoriaController.findCategoria(idCategoria);
        categoria.setCategoria(nombreCategoria);
        categoria.setImagenCat(imagen);
        try {
            categoriaController.edit(categoria);
        
            session.setAttribute("successMessage", "Categoria editada con éxito");
              response.sendRedirect("categorias");


        } catch (Exception ex) {
            ex.printStackTrace();
        response.sendRedirect("juegos?error=true");
        }
    }

    private void eliminarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                        HttpSession session = request.getSession();

        int idCategoria = Integer.parseInt(request.getParameter("id"));
        

        try {
            categoriaController.destroy(idCategoria);
                        session.setAttribute("successMessage", "Categoria eliminada con éxito");

            response.sendRedirect("categorias");
        } catch (Exception ex) {
            ex.printStackTrace();
            session.setAttribute("errorMessage", "Error al eliminada al Categoria");
            response.sendRedirect("categorias?error=true");
        }
    }
}
