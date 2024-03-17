

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="layout/header.jsp" %>
    <title>Inicio</title>

<!-- Estilos específicos para la página de portada -->
<style>
    /* Estilos para el contenido dentro del contenedor central */
    .logo {
        text-align: center;
    }

    .logo img {
        max-width: 200px;
    }

    .university-name {
        text-align: center;
        font-size: 24px;
        margin-top: 20px;
    }

    .subject {
        text-align: center;
        font-size: 20px;
        margin-top: 10px;
    }

    .parcial {
        text-align: center;
        font-size: 18px;
        margin-top: 10px;
    }

    .alumnos-title {
        text-align: center;
        font-size: 16px;
        margin-top: 20px;
    }

    .alumnos-list {
        text-align: center;
        list-style: none;
        padding: 0;
    }

    .alumnos-list li {
        font-size: 14px;
        margin-top: 5px;
    }

    .dirigido {
        text-align: center;
        font-size: 18px;
        margin-top: 20px;
    }
</style>

    <!-- Contenido de la página de portada -->
    <div class="logo">
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/UNICAES_Logo.png/800px-UNICAES_Logo.png" alt="Logo de la Universidad">
    </div>
    <h1 class="university-name">Universidad Católica de El Salvador</h1>
    <h3 class="parcial">Laboratorio 01-periodo2</h3>
    <h4 class="alumnos-title">Alumnos:</h4>
    <ul class="alumnos-list">
          <li>Navarro Rosales, Paolo Isaac</li>
        <li>Díaz López, Christian Armando</li>
        <!-- Agrega más alumnos si es necesario -->
    </ul>
    <h4 class="dirigido">Dirigido a: Ing. Ricardo Edgardo Quintanilla Padilla</h4>

<%@ include file="layout/footer.jsp" %>
