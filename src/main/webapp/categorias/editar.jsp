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
</style>


<form action="categoriaseditar" method="post">
    <h1>Editar Categoría</h1>

    <input type="hidden" id="idCategoria1" name="idCategoria1" value="${categoria.idcategoria}">

    <label for="categoria">Nombre de la Categoría:</label>
    <input type="text" id="categoria" name="categoria" value="${categoria.categoria}" required><br><br>

    <label for="imagen">URL de la Imagen:</label>
    <input type="url" id="imagen" name="imagen" value="${categoria.imagenCat}" required><br><br>

    <input type="submit" value="Guardar Cambios">
</form>
<div class="error-message" id="errorMessage"></div>

<%@ include file="/layout/footer.jsp" %>
