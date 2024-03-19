<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<title>Editar Categoria</title>
<%@ include file="/layout/header.jsp" %>
<style>
    /* Agrega estilos CSS aquí */
    form {
        max-width: 900px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    label {
        font-weight: bold;
    }

    input[type="text"],
    input[type="number"],
    input[type="url"],
    select,
    textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    input[type="checkbox"] {
        margin-top: 5px;
    }

    input[type="submit"] {
        display: block;
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        text-align: center;
        text-decoration: none;
        font-weight: bold;
    }
      #imagenPreviewContainer {
        text-align: center; /* Centrar contenido horizontalmente */
    }
</style>


<form action="categoriaseditar" method="post" enctype="multipart/form-data" >
    <h1>Editar Categoría</h1>

    <input type="hidden" id="idCategoria1" name="idCategoria1" value="${categoria.idcategoria}">

    <label for="categoria">Nombre de la Categoría:</label>
    <input type="text" id="categoria" name="categoria" value="${categoria.categoria}" required><br><br>

        <label for="imagen">Imegen</label>
       <input type="file" id="imagen" name="imagen"  accept="image/*" onchange="mostrarImagenVistaPrevia()">
  
        <div id="imagenPreviewContainer" style="display: none;">
            <img id="imagenPreview" src="#" alt="Vista previa de la imagen" style="margin-top: 10px; margin-bottom: 10px; max-width: 100px;">
        </div>
    <input type="submit" value="Guardar Cambios">
</form>
<div class="error-message" id="errorMessage"></div>

<%@ include file="/layout/footer.jsp" %>
<script>
    window.onload = function() {
        // Obtener el valor de juego.imagen
        var juegoImagen = "${categoria.imagenCat}";

        // Verificar si el valor de juego.imagen está presente
        if (juegoImagen) {
            // Obtener la imagen de vista previa
            var imagenPreview = document.getElementById("imagenPreview");
            var imagenPreviewContainer = document.getElementById("imagenPreviewContainer");

            // Obtener la parte de la ruta después del último '/'
            var lastSegment = juegoImagen.substring(juegoImagen.lastIndexOf('/') + 1);

            // Construir la ruta completa para la imagen de vista previa
            var uploadPath = "uploads/";
            var imagePath = uploadPath + lastSegment;

            // Mostrar la imagen de vista previa
            imagenPreview.src = imagePath;
            imagenPreviewContainer.style.display = "block"; // Mostrar el contenedor de la imagen de vista previa
        }
    };
</script>
<script>
    // Función para mostrar la imagen de vista previa al pegar una URL en el campo de entrada de la URL de la imagen
     function mostrarImagenVistaPrevia() {
        var fileInput = document.getElementById("imagen");
        var imagenPreview = document.getElementById("imagenPreview");
        var imagenPreviewContainer = document.getElementById("imagenPreviewContainer");
        var file = fileInput.files[0];
        var reader = new FileReader();

        reader.onload = function(e) {
            imagenPreview.src = e.target.result;
            imagenPreviewContainer.style.display = "block"; // Mostrar el contenedor de la imagen de vista previa
        };

        if (file) {
            reader.readAsDataURL(file);
        } else {
            // Si no se selecciona un archivo, establecer el valor del campo de archivo con la ruta de la imagen de juego
            fileInput.value = "${categoria.imagenCat}";
            // Mostrar la imagen de juego como vista previa
            imagenPreview.src = "${categoria.imagenCat}";
            imagenPreviewContainer.style.display = "block"; // Mostrar el contenedor de la imagen de vista previa
        }
    }
</script>