<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <title>GameCategory</title>
    <!-- Incluir Bootstrap CSS y JavaScript -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- Incluir FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    
    <link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' height='1em' viewBox='0 0 640 512'%3E%3Cpath d='M36.8 192H603.2c20.3 0 36.8-16.5 36.8-36.8c0-7.3-2.2-14.4-6.2-20.4L558.2 21.4C549.3 8 534.4 0 518.3 0H121.7c-16 0-31 8-39.9 21.4L6.2 134.7c-4 6.1-6.2 13.2-6.2 20.4C0 175.5 16.5 192 36.8 192zM64 224V384v80c0 26.5 21.5 48 48 48H336c26.5 0 48-21.5 48-48V384 224H320V384H128V224H64zm448 0V480c0 17.7 14.3 32 32 32s32-14.3 32-32V224H512z'/%3E%3C/svg%3E" type="image/svg+xml">
   <!-- SweetAlert2 CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.js"></script>

    
    <!-- Agrega las bibliotecas de DataTables -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/dt-1.11.3/datatables.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/dt-1.11.3/datatables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<!--select dinamicos -->

<!-- Select2 CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/css/select2.min.css" rel="stylesheet" />

<!-- Select2 JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/js/select2.min.js"></script>


    <!-- Bloque de estilo personalizado -->
    <style>
      .body {
        background-image: url('https://i.ibb.co/W5SVDQy/glitch-videojuegos-joystick-textura-patrones-fisuras-615746-110.jpg'); /* URL directa de la imagen de fondo */
        background-size: cover; /* Ajusta el tamaño de la imagen para cubrir todo el fondo */
        background-repeat: no-repeat; /* Evita que la imagen se repita */
        background-position: center center; /* Centra la imagen en el fondo */
    }
        /* Estilo del Navbar */
        .navbar {
            background-color: #fff; /* Color de fondo suave */
        }

            .navbar-brand {
               font-size: 22px;
               color: #333; /* Color de texto más oscuro */
               display: flex;
               align-items: center; /* Centrar verticalmente */
               padding: 5px 10px;
               border-radius: 10px; /* Bordes redondeados */
           }

           .navbar-brand img {
               width: 30px; /* Ancho de la imagen */
               height: auto; /* Altura automática */
               margin-right: 5px; /* Margen a la derecha de la imagen */
           }

        /* Estilo del botón de hamburguesa */
        .custom-toggler .navbar-toggler-icon {
            background: none; /* Fondo transparente */
            border: none; /* Sin borde */
            outline: none; /* Sin contorno */
            padding: 0; /* Sin relleno */
            color: #333; /* Color de texto más oscuro */
            font-size: 24px; /* Tamaño de fuente */
        }

        /* Estilo de los enlaces del menú */
        .navbar-nav .nav-item {
            margin: 0 25px;
        }

        .navbar-nav .nav-link {
            font-size: 22px;
            color: #333; /* Color de texto más oscuro */
            transition: color 0.3s; /* Transición de color suave */
        }

        .navbar-nav .nav-link:hover {
            color: #888; /* Cambio de color al pasar el mouse */
        }

        /* Estilo del contenedor del contenido */
        .container {
            background-color: #fff; /* Fondo del contenido más claro */
            padding: 20px;
            margin-bottom: 20px;
            margin-top: 25px;
            border-radius: 5px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1); /* Sombra suave */
        }
     
    </style>
</head>
<body class="body">
    <!-- Navbar con paleta de colores suaves -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="../LaboratorioJuego/index.jsp">
             
                <img  src="https://i.ibb.co/Zxs7tg0/consola-de-juego.png"  alt="Logo de la Movie" width="40" height="40">
                <span>  GameCategoryWEB</span>
            </a>
            <button class="navbar-toggler custom-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fas fa-bars"></i> <!-- Icono de hamburguesa personalizado de FontAwesome -->
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item active">
                        <a class="nav-link" href="../LaboratorioJuego/index.jsp">Inicio</a>
                    </li>
                         <li class="nav-item">
                             <a class="nav-link" href="juegos">Juego</a>
                         </li>
                         <li class="nav-item">
                             <a class="nav-link" href="categorias">Categoria</a>
                         </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Reporte
                            </a>
                            <div class="dropdown-menu" aria-labelledby="userDropdown">
                                 <a class="dropdown-item" href="consultar">Precio de mas caro a mas bajo</a>
                                <a class="dropdown-item" href="reporte">Precio de mas bajo a mas caro </a>
               

                            </div>
                        </li>
                         
              

                    
                </ul>
            </div>
        </div>
    </nav>

    <!-- Contenido principal -->
    <div class="container">
        <!-- Resto de tu contenido aquí -->
