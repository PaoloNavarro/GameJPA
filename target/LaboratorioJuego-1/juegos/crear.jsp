<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<title>Crear Juego</title>
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

<form id="formulario" action="juegoscrear" method="post" enctype="multipart/form-data">
    <h1>Crear Juego</h1>

    <label for="nomJuego">Nombre del Juego:</label>
    <input type="text" id="nomJuego" name="nomJuego" required><br><br>

    <label for="idCategoria">Categoría:</label>
    <select id="idCategoria" name="idCategoria" required>
            <c:forEach items="${categorias}" var="categoria">
                <option value="${categoria.idcategoria}">${categoria.idcategoria}</option>
             </c:forEach>
    </select><br><br>
     <label for="clasificacion">Clasificación:</label>
    <select id="clasificacion" name="clasificacion" required>
        <option value="EC"> Early Childhood E</option>
        <option value="E">Everyone (E)</option>
        <option value="E10+">Everyone 10+ (E10+)</option>
        <option value="T">Teen (T)</option>
        <option value="M">Mature (M)</option>
        <option value="AO">Adults Only (AO)</option>
         <option value="RP">Ratin pending (RP)</option>

    </select><br><br>

    <label for="precio">Precio:</label>
    <input type="number" id="precio" name="precio" required min="0" step="0.01"><br><br>

    <label for="existencias">Existencias:</label>
    <input type="number" id="existencias" name="existencias" required min="0"><br><br>
     <c:set var="uploadPath" value="uploads/" />

    <label for="imagen">Imagen:</label>
    <input type="file" id="imagen" name="imagen" required accept="image/*" onchange="mostrarImagenVistaPrevia()">
    

    <div id="imagenPreviewContainer" style="display: none;">
         <img id="imagenPreview" src="#" alt="Vista previa de la imagen" style="margin-top: 10px ; margin-bottom: 5px; max-width: 100px;">
     </div>
        <input  type="submit" value="Guardar juego">

</form>

<%@ include file="/layout/footer.jsp" %>

<script>
   

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
    }
}

</script>
