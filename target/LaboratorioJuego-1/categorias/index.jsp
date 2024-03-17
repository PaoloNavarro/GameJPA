<%@page contentType="text/html" pageEncoding="UTF-8"%>


    <title>Lista de alumnos</title>
    <%@ include file="/layout/header.jsp" %>
    <style>
        .table-container {
            overflow-x: auto; /* Añade barra de desplazamiento horizontal */
        }
        /* Estilo para la tabla de productos */
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

<h1 class="mb-3">Lista de Categorías</h1>

<!-- Botón para agregar una nueva categoría -->
<a href="categoriascrear" class="btn btn-primary mb-3">
    <i class="fas fa-plus"></i> Agregar Categoría
</a>

<!-- Contenedor para la tabla con barra de desplazamiento horizontal -->
<div class="table-container">
    <table id="miTabla" class="table">
        <thead>
            <tr>
                <th class="d-none">ID</th>
                <th>Categoría</th>
                <th>Imagen</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${categorias}" var="categoria">
                <tr>
                    <td class="d-none">${categoria.idcategoria}</td>
                    <td>${categoria.categoria}</td>
                    <td>
                        <img src="${categoria.imagenCat}" alt="image-${categoria.categoria}" style="max-width: 75px; max-height: 50px;">
                    </td>                
                    <td>
                        <a href="categoriaseditar?id=${categoria.idcategoria}" class="btn btn-primary">
                            <i class="fas fa-pencil-alt"></i> Editar
                        </a>
                        <a href="#" class="btn btn-danger" onclick="eliminarElemento(${categoria.idcategoria}, 'categorias')">
                            <i class="fas fa-trash"></i> Eliminar
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

    
<%@ include file="/layout/footer.jsp" %>

