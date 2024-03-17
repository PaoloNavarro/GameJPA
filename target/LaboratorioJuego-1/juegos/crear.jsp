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
</style>

<form action="juegoscrear" method="post"  onsubmit="return validarFormulario()">
    <h1>Crear Juego</h1>

    <label for="nomJuego">Nombre del Juego:</label>
    <input type="text" id="nomJuego" name="nomJuego" required><br><br>

    <label for="idCategoria">Categoría:</label>
    <select id="idCategoria" name="idCategoria" required>
            <c:forEach items="${categorias}" var="categoria">
                <option value="${categoria.idcategoria}">${categoria.categoria}</option>
             </c:forEach>
    </select><br><br>

    <label for="precio">Precio:</label>
    <input type="number" id="precio" name="precio" required min="0" step="0.01"><br><br>

    <label for="existencias">Existencias:</label>
    <input type="number" id="existencias" name="existencias" required min="0"><br><br>

    <label for="imagen">Imagen:</label>
    <input type="url" id="imagen" name="imagen" required><br><br>
    
    <label for="clasificacion">Clasificación:</label>
    <select id="clasificacion" name="clasificacion" required>
        <option value="E">Everyone (E)</option>
        <option value="E10+">Everyone 10+ (E10+)</option>
        <option value="T">Teen (T)</option>
        <option value="M">Mature (M)</option>
        <option value="AO">Adults Only (AO)</option>
    </select><br><br>

    <input type="submit" value="Guardar Juego">
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
</script>