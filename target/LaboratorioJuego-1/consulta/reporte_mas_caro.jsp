<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


    <title>Lista de juegos más caro</title>
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

<h1 class="mb-3">Lista de Juegos más Caros</h1>
    <div class="d-flex mb-2">
        <button onclick="imprimirTabla()" class="btn btn-primary"  style="margin-right: 10px;">
            <i class="fas fa-print"></i> Imprimir Tabla
        </button>
        <a href="exportcsvmasaltos" class="btn btn-success"  style="margin-right: 10px;">
            <i class="fas fa-file-csv"></i> Exportar CSV
        </a>
        <a href="exportpdfmasaltos" class="btn btn-danger"  style="margin-right: 10px;" onclick="exportarPDF()">
            <i class="fas fa-file-pdf"></i> Exportar PDF
        </a>
    </div>
<!-- Contenedor de la tabla con barra de desplazamiento horizontal -->
<div class="table-container">
    <table id="miTabla1" class="table">
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Categoría</th>
                <th>Precio</th>
                <th>Existencias</th>
                <th>Calificación</th>

            </tr>
        </thead>
        <tbody>
            <c:forEach items="${juegos}" var="juego">
                <tr>
                    <td>${juego.nomJuego}</td>
                    <td>${juego.idcategoria.categoria}</td>
                    <td>${juego.precio}</td>
                    <td>${juego.existencias}</td>
                    <td>${juego.clasificacion}</td>
               
                </tr>
            </c:forEach>
        </tbody>
   
    </table>
</div>

<%@ include file="/layout/footer.jsp" %>

