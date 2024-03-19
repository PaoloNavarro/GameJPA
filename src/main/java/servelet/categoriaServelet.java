package servelet;
import controladores.CategoriaJpaController;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import modelos.Categoria;

@MultipartConfig
@WebServlet(name = "CategoriaServlet", urlPatterns = {"/categorias", "/categoriascrear", "/categoriaseditar", "/categoriaseliminar"})
public class categoriaServelet extends HttpServlet {

    private CategoriaJpaController categoriaController;
    private   String pathfiles;
     private File uploads;
     private String[] extens = {".ico",".png",".jpg","jpge",".webp"};
     


    @Override
    public void init() throws ServletException {
        super.init();
        categoriaController = new CategoriaJpaController();
         pathfiles = "C:\\Users\\X1\\Documents\\NetBeansProjects\\LaboratorioJuego\\src\\main\\webapp\\uploads\\";
         uploads = new File(pathfiles);
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
                            String photo;
                            String nombreCategoria = request.getParameter("categoria");
                           Part part = request.getPart("imagen");
                                  //vemos si envio imagen
                            if(part == null){
                                 session.setAttribute("errorMessage", "No selecciono imagen");
                                response.sendRedirect("categorias");
                                return;
                            }
                            if(isExtension(part.getSubmittedFileName(),extens)){
                                 photo = saveFile(part, uploads);

                            }else{
                               session.setAttribute("errorMessage", "Error con la  imagen");
                                response.sendRedirect("categorias");
                                return;
                            }
                            photo = photo.replace("\\", "/");
                               if (categoriaController.findCategoriaByNombre(nombreCategoria) != null) {
                                    // Si la categoría ya existe, mostrar un mensaje de error y redirigir de vuelta al formulario
                                    session.setAttribute("errorMessage", "¡La categoría ya existe!");
                                    response.sendRedirect("categoriascrear");
                                    return; // Terminar la ejecución del método
                                }
                               
                             Categoria categoria = new Categoria();
                            categoria.setCategoria(nombreCategoria);
                            categoria.setImagenCat(photo);
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

    // Obtener la categoría existente
    Categoria categoria = categoriaController.findCategoria(idCategoria);
    String nombreOriginal = categoria.getCategoria();

    // Verificar si el nuevo nombre es diferente del nombre original
    if (!nombreCategoria.equals(nombreOriginal)) {
        // El nombre ha cambiado, buscar si ya existe una categoría con el nuevo nombre
        Categoria categoriaExistente = categoriaController.findCategoriaByNombre(nombreCategoria);
        if (categoriaExistente != null) {
            // Ya existe una categoría con el nuevo nombre, mostrar mensaje de error
            session.setAttribute("errorMessage", "Ya existe una categoría con ese nombre");
            response.sendRedirect("categorias");
            return;
        }
    }

    // Actualizar el nombre de la categoría
    categoria.setCategoria(nombreCategoria);

    try {
        // Obtener la imagen de la categoría
        Part imagenPart = request.getPart("imagen");
        String imagen = categoria.getImagenCat(); // Obtener la imagen existente

        // Verificar si se proporcionó una nueva imagen
        if (imagenPart != null && imagenPart.getSize() > 0) {
            // Si se cargó un nuevo archivo, guardar la imagen y actualizar la ruta
            imagen = saveFile(imagenPart, uploads); // Utiliza tu método para guardar el archivo
        }
        imagen = imagen.replace("\\", "/");

        // Actualizar la ruta de la imagen de la categoría
        categoria.setImagenCat(imagen);

        // Proceder con la edición de la categoría
        categoriaController.edit(categoria);
        session.setAttribute("successMessage", "Categoría editada con éxito");
        response.sendRedirect("categorias");
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("errorMessage", "Error al editar la Categoría");
        response.sendRedirect("categorias?error=true");
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
    public String saveFile(Part part, File pathUploads){
        String pathAbsolute ="";
                try{
                    Path path = Paths.get(part.getSubmittedFileName());
                    String filename =  path.getFileName().toString();
                    InputStream input = part.getInputStream();
                    if(input != null){
                        File file = new File(pathUploads, filename);
                        pathAbsolute = file.getAbsolutePath();
                        Files.copy(input, file.toPath());
                    }
                }catch(Exception e){
                    e.printStackTrace();
                }
                return pathAbsolute;
    }
    private boolean isExtension(String filename, String[] extensions){
        for(String et: extensions){
            if(filename.toLowerCase().endsWith(et)){
                return true;
            }
        }
                return false;
    }
}
