package servelet;

import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.HorizontalAlignment;
import com.itextpdf.layout.property.UnitValue;
import controladores.JuegoJpaController;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelos.Juego;

@WebServlet(name = "ExportPDFServlet", urlPatterns = {"/exportpdfmasbajos", "/exportpdfmasaltos"})
public class ExportarPDFServlet extends HttpServlet {

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
    String action = request.getServletPath();

    // Obtener los datos de los juegos según el tipo de orden
    List<Juego> juegos = null;
    switch (action) {
        case "/exportpdfmasbajos":
            juegos = new JuegoJpaController().findJuegoOrderByPrecioAsc();
            break;
        case "/exportpdfmasaltos":
            juegos = new JuegoJpaController().findJuegoOrderByPrecioDesc();
            break;
    }

    // Configurar la respuesta HTTP para descargar un archivo PDF
    response.setContentType("application/pdf");
    String tipoOrden = action.equals("/exportpdfmasbajos") ? "más bajos" : "más altos";
    response.setHeader("Content-Disposition", "attachment; filename=\"juegos_" + tipoOrden + ".pdf\"");

    // Generar el PDF con los datos de los juegos
    try (PdfWriter writer = new PdfWriter(response.getOutputStream());
         PdfDocument pdf = new PdfDocument(writer);
         Document document = new Document(pdf)) {

        // Agregar la imagen al encabezado
        com.itextpdf.layout.element.Image img = new com.itextpdf.layout.element.Image(ImageDataFactory.create("https://i.ibb.co/Zxs7tg0/consola-de-juego.png"));
        img.setWidth(40);
        document.add(img);

        // Agregar el título al encabezado
        Paragraph title = new Paragraph("GameCategoryWEB - Juegos " + tipoOrden);
        title.setFontSize(20);
        document.add(title);

        // Crear la tabla para los datos de los juegos
        Table table = new Table(5);
        table.setWidth(UnitValue.createPercentValue(100)); // Establecer ancho de tabla al 100% de la página
        table.addCell(new Cell().add(new Paragraph("Nombre")));
        table.addCell(new Cell().add(new Paragraph("Categoría")));
        table.addCell(new Cell().add(new Paragraph("Precio")));
        table.addCell(new Cell().add(new Paragraph("Existencias")));
        table.addCell(new Cell().add(new Paragraph("Calificación")));
        // Agregar los datos de los juegos a la tabla
        for (Juego juego : juegos) {
            table.addCell(new Cell().add(new Paragraph(juego.getNomJuego())));
            table.addCell(new Cell().add(new Paragraph(juego.getIdcategoria().getCategoria())));
            table.addCell(new Cell().add(new Paragraph(String.valueOf(juego.getPrecio()))));
            table.addCell(new Cell().add(new Paragraph(String.valueOf(juego.getExistencias()))));
            table.addCell(new Cell().add(new Paragraph(juego.getClasificacion())));
        }

        // Agregar la tabla al documento PDF y centrarla
        document.add(table.setMarginTop(20).setHorizontalAlignment(HorizontalAlignment.CENTER));
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().println("Error al generar el PDF");
    }
}


}
