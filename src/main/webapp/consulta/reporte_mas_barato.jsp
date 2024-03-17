<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


    <title>Lista de juegos más barato</title>
    <%@ include file="/layout/header.jsp" %>
    <style>
        /* Estilos para la tabla */
        .table-container {
            overflow-x: auto; /* Agrega barra de desplazamiento horizontal */
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th, .table td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        .table th {
            background-color: #f2f2f2;
        }

        .btn {
            padding: 5px 10px;
            text-decoration: none;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #007bff;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-danger {
            background-color: #dc3545;
            color: #fff;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

<h1 class="mb-3">Lista de Juegos más Baratos</h1>
  <button onclick="imprimirTabla()" class="btn btn-primary mb-2">
            <i class="fas fa-print"></i> Imprimir Tabla
  </button>
<!-- Contenedor de la tabla con barra de desplazamiento horizontal -->
<div class="table-container">
    <table id="miTabla1" class="table">
        <thead>
            <tr>
                <th class="d-none">ID</th>
                <th>Nombre</th>
                <th>Categoría</th>
                <th>Precio</th>
                <th>Existencias</th>
                <th>Imagen</th>
                <th>Calificación</th>

            </tr>
        </thead>
        <tbody>
            <c:forEach items="${juegos}" var="juego">
                <tr>
                    <td class="d-none">${juego.idjuego}</td>
                    <td>${juego.nomJuego}</td>
                    <td>${juego.idcategoria.categoria}</td>
                    <td>${juego.precio}</td>
                    <td>${juego.existencias}</td>
                    <td>
                        <img src="${juego.imagen}" alt="image-${juego.nomJuego}" style="max-width: 75px; max-height: 50px;">
                    </td>
                    <td>${juego.clasificacion}</td>
               
                </tr>
            </c:forEach>
        </tbody>
    </table>
   
</div>

<%@ include file="/layout/footer.jsp" %>
