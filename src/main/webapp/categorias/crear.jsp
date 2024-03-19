<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<title>Crear categorias</title>
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
         margin-top: 15px;
    }
     #imagenPreviewContainer {
        text-align: center; /* Centrar contenido horizontalmente */
    }
</style>

<form action="categoriascrear" method="post"  enctype="multipart/form-data">
    <h1>Crear Categoría</h1>

    <label for="categoria">Nombre de la Categoría:</label>
    <input type="text" id="categoria" name="categoria" required><br>

    <label for="imagen">Imagen:</label>
    <input style="margin-top: 15px;" type="file" id="imagen" name="imagen" required accept="image/*" onchange="mostrarImagenVistaPrevia()">

    <div id="imagenPreviewContainer" style="display: none;">
        <img id="imagenPreview" src="#" alt="Vista previa de la imagen" style="margin-top: 10px ; max-width: 100px;">
    </div>
    
    <input  type="submit" value="Guardar Categoría">
</form>


<%@ include file="/layout/footer.jsp" %>

<script>
    function validarFormulario() {
        var nomJuego = document.getElementById("nomJuego").value;
        var idCategoria = document.getElementById("idCategoria").value;
        var precio = document.getElementById("precio").value;
        var existencias = document.getElementById("existencias").value;
        var imagen = document.getElementById("imagen").value;

        if (nomJuego.trim() === "") {
            alert("Por favor, ingrese el nombre del juego.");
            return false;
        }

        if (idCategoria.trim() === "") {
            alert("Por favor, seleccione una categoría.");
            return false;
        }

        if (precio.trim() === "" || isNaN(parseFloat(precio))) {
            alert("Por favor, ingrese un precio válido.");
            return false;
        }

        if (existencias.trim() === "" || isNaN(parseInt(existencias))) {
            alert("Por favor, ingrese un número válido para las existencias.");
            return false;
        }

        if (imagen.trim() === "") {
            alert("Por favor, seleccione una imagen para el juego.");
            return false;
        }

        return true;
    }
    
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
