<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  

    <title>Lista de juegos</title>
    <%@ include file="/layout/header.jsp" %>
    <style>
    /* The Modal (background) */
    .modal {
      display: none; /* Hidden by default */
      position: fixed; /* Stay in place */
      z-index: 9999; /* Sit on top */
      left: 50%; /* Centrar horizontalmente */
      top: 50%; /* Centrar verticalmente */
      transform: translate(-50%, -50%); /* Centrar completamente */
      width: 50%; /* Ancho del modal */
      height: 50%; /* Altura del modal */
      overflow: auto; /* Habilitar desplazamiento si es necesario */
      background-color: rgba(255, 255, 255, 0.9); /* Color de fondo */
      border: 1px solid rgba(0, 0, 0, 0.2); /* Borde con color y transparencia */
      box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.5); /* Sombra */
    }



    /* Modal Content/Box */
    .modal-content {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100%;
    }

    .modal-img {
      width: 400px;
      height: 400px;
    }

    /* Close Button */
    .close {
      position: absolute;
      top: 15px;
      right: 35px;
      color: #000000;
      font-size: 40px;
      font-weight: bold;
      transition: 0.3s;
      border: 2px solid ; /* Borde transparente por defecto */
    }

    .close:hover,
    .close:focus {
      color: #ff0000; /* Cambiar color a rojo cuando el cursor está encima */
      text-decoration: none;
      cursor: pointer;
      border-color: #000; /* Agregar un borde negro cuando el cursor está encima */
    }



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
<h1 class="mb-3">Lista de Juegos</h1>

<!-- Botón para agregar un nuevo juego -->
<a href="juegoscrear" class="btn btn-primary mb-3">
    <i class="fas fa-plus"></i> Agregar Juego
</a>

<!-- Contenedor para la tabla con barra de desplazamiento horizontal -->
<div class="table-container">
    <table id="miTabla" class="table">
        <thead>
            <tr>
                <th class="d-none">ID</th>
                <th>Nombre</th>
                <th>Categoría</th>
                <th>Precio</th>
                <th>Existencias</th>
                <th>Imagen</th>
                <th>Calificacion</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:set var="uploadPath" value="uploads/" />
            <c:forEach items="${juegos}" var="juego">
                <tr>
                    <td class="d-none">${juego.idjuego}</td>
                    <td>${juego.nomJuego}</td>
                    <td>${juego.idcategoria.categoria}</td>
                    <td>${juego.precio}</td>
                    <td>${juego.existencias}</td>
                   
                  <td>
                       <c:set var="segments" value="${fn:split(juego.imagen, '/')}"/>
                       <c:set var="lastSegmentIndex" value="${fn:length(segments) - 1}"/>
                        <c:set var="lastSegment" value="${segments[lastSegmentIndex]}"/>
                        <%-- Construir la nueva ruta de la imagen con el último segmento --%>
                        <c:set var="newImagePath" value="${uploadPath}${lastSegment}"/>
                        
                        <img id="imagenJuego${juego.idjuego}" src="${newImagePath}" alt="image-${juego.nomJuego}" style="max-width: 75px; max-height: 50px;" onclick="mostrarImagen('${newImagePath}')">
                </td>
                <td>
                    <%-- Mostrar imagen de clasificación según el valor --%>
                    <c:choose>
                        <c:when test="${juego.clasificacion eq 'EC'}">
                            <img id="imagenClasificacionEC" src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/ESRB_2013_Early_Childhood.svg/1280px-ESRB_2013_Early_Childhood.svg.png" alt="EC" style="width: 30px; height: 30px;"
                                onclick="mostrarImagen('https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/ESRB_2013_Early_Childhood.svg/1280px-ESRB_2013_Early_Childhood.svg.png')">
                            <span>(EC)</span>
                        </c:when>
                        <c:when test="${juego.clasificacion eq 'E'}">
                            <img  id="imagenClasificacionE" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/ESRB_2013_Everyone.svg/1280px-ESRB_2013_Everyone.svg.png" alt="E" style="width: 30px; height: 30px;"
                           onclick="mostrarImagen('https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/ESRB_2013_Everyone.svg/1280px-ESRB_2013_Everyone.svg.png')">

                            <span> (E)</span>
                        </c:when>
                        <c:when test="${juego.clasificacion eq 'E10+'}">
                            <img id="imagenClasificacionE10+" src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/ESRB_2013_Everyone_10%2B.svg/1280px-ESRB_2013_Everyone_10%2B.svg.png" alt="E10+" style="width: 30px; height: 30px;"
                                  onclick="mostrarImagen('https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/ESRB_2013_Everyone_10%2B.svg/1280px-ESRB_2013_Everyone_10%2B.svg.png')">
                            <span>(E10+)</span>
                        </c:when>
                        <c:when test="${juego.clasificacion eq 'T'}">
                            <img id="imagenClasificacionT" src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/ESRB_2013_Teen.svg/1280px-ESRB_2013_Teen.svg.png" alt="T" style="width: 30px; height: 30px;"
                                  onclick="mostrarImagen('https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/ESRB_2013_Teen.svg/1280px-ESRB_2013_Teen.svg.png')">
                            <span>(T)</span>
                        </c:when>
                        <c:when test="${juego.clasificacion eq 'M'}">
                            <img id="imagenClasificacionM" src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/ESRB_2013_Mature.svg/1280px-ESRB_2013_Mature.svg.png" alt="M" style="width: 30px; height: 30px;"
                                  onclick="mostrarImagen('https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/ESRB_2013_Mature.svg/1280px-ESRB_2013_Mature.svg.png')">
                             <span>(M)</span>
                        </c:when>
                        <c:when test="${juego.clasificacion eq 'AO'}">
                            <img id="imagenClasificacionAO" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/ESRB_2013_Adults_Only_18%2B.svg/1280px-ESRB_2013_Adults_Only_18%2B.svg.png" alt="AO" style="width: 30px; height: 30px;"
                                  onclick="mostrarImagen('https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/ESRB_2013_Adults_Only_18%2B.svg/1280px-ESRB_2013_Adults_Only_18%2B.svg.png')">
                             <span>(AO)</span>
                        </c:when>
                        <c:when test="${juego.clasificacion eq 'RP'}">
                            <img id="imagenClasificacionRP" src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/ESRB_2013_Rating_Pending.svg/1280px-ESRB_2013_Rating_Pending.svg.png" alt="RP" style="width: 30px; height: 30px;"
                                  onclick="mostrarImagen('https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/ESRB_2013_Rating_Pending.svg/1280px-ESRB_2013_Rating_Pending.svg.png')">
                              <span>(RP)</span>
                        </c:when>
                        <c:otherwise>
                            ${juego.clasificacion}
                        </c:otherwise>
                    </c:choose>
                </td>
                    <td>
                        <a href="juegoseditar?id=${juego.idjuego}" class="btn btn-primary">
                            <i class="fas fa-pencil-alt"></i> Editar
                        </a>
                        <a href="#" class="btn btn-danger" onclick="eliminarElemento(${juego.idjuego}, 'juegos')">
                            <i class="fas fa-trash"></i> Eliminar
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<!-- The Modal -->
<div id="imagenModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="cerrarModal()">&times;</span>
    <img id="imagenGrande" class="modal-img">
  </div>
</div>


<%@ include file="/layout/footer.jsp" %>

