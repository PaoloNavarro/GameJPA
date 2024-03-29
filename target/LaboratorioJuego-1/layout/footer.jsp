<%-- 
    Document   : footer
    Created on : 26 sep. 2023, 08:41:05
    Author     : X1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    </div>

</body>
</html>
    <%-- Mostrar mensaje de éxito si está presente en la sesión --%>
    <% String successMessage = (String) session.getAttribute("successMessage"); %>
    <% if (successMessage != null) { %>
        <script>
            Swal.fire({
                title: 'Éxito',
                text: '<%= successMessage %>',
                icon: 'success',
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
        </script>
        <% session.removeAttribute("successMessage"); %>
    <% } %>

    <%-- Mostrar mensaje de error si está presente en la sesión --%>
    <% String errorMessage = (String) session.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
        <script>
            Swal.fire({
                title: 'Error',
                text: '<%= errorMessage %>',
                icon: 'error',
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
        </script>
        <% session.removeAttribute("errorMessage"); %>
    <% } %>

<script>
    
    function eliminarElemento(idElemento, elemento) {
        console.log("ID del " + elemento + " a eliminar:", idElemento);

        Swal.fire({
            title: '¿Estás seguro?',
            text: `Esta acción eliminará el ${elemento}. ¿Deseas continuar?`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Si el usuario confirmó, redirige a la URL de eliminación
                window.location.href = elemento+`eliminar?id=` + idElemento;
            }
        });
    }
     function comprar() {
    // Verificar si la sesión contiene un cliente (puedes ajustar esta lógica según tu aplicación)
    var clienteEnSesion = <%= session.getAttribute("cliente") != null %> ;

    if (clienteEnSesion) {
        // Si la sesión contiene un cliente, muestra una confirmación adicional antes de comprar
        Swal.fire({
            title: 'Confirmar compra',
            text: '¿Estás seguro de realizar la compra?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Sí, comprar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // El usuario confirmó la compra, aquí puedes redirigir a la página de compra
                window.location.href = "comprar";
                
            }
        });
    } else {
        // Si la sesión no contiene un cliente, muestra el mensaje de inicio de sesión como antes
        Swal.fire({
            title: 'Iniciar sesión',
            text: 'Para realizar la compra, debes iniciar sesión y tener un cliente válido.',
            icon: 'info',
            showCancelButton: true,
            confirmButtonText: 'Iniciar sesión',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Redirige a la página de inicio de sesión
                window.location.href = "login";
            }
        });
    }
}

$(document).ready(function() {
    $('#miTabla').DataTable({
        "language": {
            "sProcessing": "Procesando...",
            "sLengthMenu": "Mostrar _MENU_ registros por página",
            "sZeroRecords": "No se encontraron resultados",
            "sEmptyTable": "Ningún dato disponible en esta tabla",
            "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
            "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
            "sInfoPostFix": "",
            "sSearch": "Buscar:",
            "sUrl": "",
            "sInfoThousands": ",",
            "sLoadingRecords": "Cargando...",
            "oPaginate": {
                "sFirst": "Primero",
                "sLast": "Último",
                "sNext": "Siguiente",
                "sPrevious": "Anterior"
            }
        },
        "lengthMenu": [5, 10, 25], // Mostrar opciones de 5, 10 y 25 registros por página
        "pageLength": 5 // Establecer 5 como valor por defecto
    });
});


</script>

<script>
    $(document).ready(function() {
        $('#idCategoria').select2();
    });
</script>
<script>
   $(document).ready(function() {
    $('#clasificacion').select2({
        templateResult: formatClasificacion
    });

    // Función para personalizar el formato de las opciones
    function formatClasificacion(option) {
        if (!option.id) {
            return option.text;
        }

        var imageUrl;
        switch (option.id) {
            case 'EC':
                imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/ESRB_2013_Early_Childhood.svg/1280px-ESRB_2013_Early_Childhood.svg.png';
                break;
            case 'E':
                imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/ESRB_2013_Everyone.svg/1280px-ESRB_2013_Everyone.svg.png';
                break;
            case 'E10+':
                imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/ESRB_2013_Everyone_10%2B.svg/1280px-ESRB_2013_Everyone_10%2B.svg.png';
                break;
            case 'T':
                imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/ESRB_2013_Teen.svg/1280px-ESRB_2013_Teen.svg.png';
                break;
            case 'M':
                imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/ESRB_2013_Mature.svg/1280px-ESRB_2013_Mature.svg.png';
                break;
            case 'AO':
                imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/ESRB_2013_Adults_Only_18%2B.svg/1280px-ESRB_2013_Adults_Only_18%2B.svg.png';
                break;
            case 'RP':
                imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/ESRB_2013_Rating_Pending.svg/1280px-ESRB_2013_Rating_Pending.svg.png';
                break;
            default:
                imageUrl = '';
        }

         var $option = $(
                '<span><img src="' + imageUrl + '" class="img-clasificacion" style="width: 30px; height: 30px;" /> ' + option.text + '</span>'
            );
        return $option;
    }
});
</script>

<script>
    function imprimirTabla() {
        // Obtener el contenido de la tabla
        var contenidoTabla = document.getElementById("miTabla1").outerHTML;
        // Crear una ventana nueva para imprimir
        var ventanaImpresion = window.open('', '_blank');
        // Escribir el contenido de la tabla en la ventana de impresión
        ventanaImpresion.document.write('<html><head><title>Reporte de Juegos</title>');
        // Agregar estilos CSS para la impresión
        ventanaImpresion.document.write('<style>');
        ventanaImpresion.document.write('@media print {');
        ventanaImpresion.document.write('body { font-family: Arial, sans-serif; }');
        ventanaImpresion.document.write('h1 { text-align: center; margin-bottom: 20px; }');
        ventanaImpresion.document.write('table { border-collapse: collapse; width: 100%; }');
        ventanaImpresion.document.write('table, th, td { border: 1px solid #dee2e6; }');
        ventanaImpresion.document.write('th, td { padding: 8px; text-align: left; }');
        ventanaImpresion.document.write('th { background-color: #f2f2f2; }');
        ventanaImpresion.document.write('img { max-width: 100%; height: auto; }');
        ventanaImpresion.document.write('}');
        ventanaImpresion.document.write('</style>');
        ventanaImpresion.document.write('</head><body>');
        ventanaImpresion.document.write('<h1>Reporte de Juegos</h1>');
        ventanaImpresion.document.write(contenidoTabla);
        ventanaImpresion.document.write('</body></html>');
        // Imprimir la ventana
        ventanaImpresion.print();
        // Cerrar la ventana después de imprimir
        ventanaImpresion.close();
    }
</script>

<script>
    function mostrarImagen(imagenSrc) {
        var modal = document.getElementById('imagenModal');
        var modalImg = document.getElementById('imagenGrande');

        modal.style.display = "block";
        modalImg.src = imagenSrc;
    }

    function cerrarModal() {
        var modal = document.getElementById('imagenModal');
        modal.style.display = "none";
    }
</script>