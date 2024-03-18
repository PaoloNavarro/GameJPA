<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<title>Editar juego</title>
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


<form action="juegoseditar" method="post"  onsubmit="return validarFormulario()">
    <h1>Editar Juego</h1>

    <input type="hidden" id="idJuego" name="idJuego" value="${juego.idjuego}">

    <label for="nomJuego">Nombre del Juego:</label>
    <input type="text" id="nomJuego" name="nomJuego" value="${juego.nomJuego}" required><br><br>

    <label for="idCategoria">Categoría:</label>
    <select id="idCategoria" name="idCategoria" required>
        <c:forEach var="categoria" items="${categorias}">
            <option value="${categoria.idcategoria}" ${categoria.idcategoria eq juego.idcategoria.idcategoria ? 'selected' : ''}>${categoria.categoria}</option>
        </c:forEach>
    </select><br><br>
        <label for="clasificacion">Clasificación:</label>
    <select id="clasificacion" name="clasificacion" required>
       <option value="EC">Early Childhood (EC)</option>
        <option value="E">Everyone (E)</option>
        <option value="E10+">Everyone 10+ (E10+)</option>
        <option value="T">Teen (T)</option>
        <option value="M">Mature (M)</option>
        <option value="AO">Adults Only (AO)</option>
         <option value="RP">Ratin pending (RP)</option>
    </select><br><br>

    <label for="precio">Precio:</label>
    <input type="number" id="precio" name="precio" value="${juego.precio}" required min="0" step="0.01"><br><br>

    <label for="existencias">Existencias:</label>
    <input type="number" id="existencias" name="existencias" value="${juego.existencias}" required min="0"><br><br>

    <label for="imagen">Imagen:</label>
    <input type="url" id="imagen" name="imagen" value="${juego.imagen}" onchange="mostrarImagen(this.value)"><br><br>
      <div id="imagenPreviewContainer" style="display: none;">
            <img id="imagenPreview" src="#" alt="Vista previa de la imagen" style="margin-top: 10px; margin-bottom: 10px; max-width: 100px;">
        </div>


    <input type="submit" value="Guardar Cambios">
</form>
<div class="error-message" id="errorMessage"></div>

<%@ include file="/layout/footer.jsp" %>

<script>
    function validarFormulario() {
        var errorMessage = document.getElementById("errorMessage");
        errorMessage.innerHTML = "";

        var nomJuego = document.getElementById("nomJuego").value;
        var idCategoria = document.getElementById("idCategoria").value;
        var precio = document.getElementById("precio").value;
        var existencias = document.getElementById("existencias").value;

        // Validación de nombre del juego
        if (nomJuego.trim() === "") {
            errorMessage.innerHTML = "El nombre del juego no puede estar vacío.";
            return false;
        }

        // Validación de categoría
        if (idCategoria.trim() === "") {
            errorMessage.innerHTML = "Por favor, seleccione una categoría.";
            return false;
        }

        // Validación de precio
        if (isNaN(parseFloat(precio)) || precio < 0) {
            errorMessage.innerHTML = "El precio debe ser un número positivo.";
            return false;
        }

        // Validación de existencias
        if (isNaN(parseInt(existencias)) || existencias < 0) {
            errorMessage.innerHTML = "Las existencias deben ser un número positivo.";
            return false;
        }

        // Puedes agregar más validaciones según tus necesidades

        return true; // Devuelve true si la validación es exitosa
    }
        function mostrarVistaPreviaImagen() {
        var inputURLImagen = document.getElementById("imagen");
        var imagenPreview = document.getElementById("imagenPreview");
        var imagenPreviewContainer = document.getElementById("imagenPreviewContainer");

        // Mostrar la imagen de vista previa si la URL de la imagen es válida
        if (inputURLImagen.value && inputURLImagen.checkValidity()) {
            imagenPreview.src = inputURLImagen.value;
            imagenPreviewContainer.style.display = "block"; // Mostrar el contenedor de la imagen de vista previa
        } else {
            imagenPreview.src = "#"; // Restablecer la imagen de vista previa
            imagenPreviewContainer.style.display = "none"; // Ocultar el contenedor de la imagen de vista previa
        }
    }
     window.onload = function() {
        mostrarVistaPreviaImagen();
    };
    
</script>