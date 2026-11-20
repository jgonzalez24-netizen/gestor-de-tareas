<?php
$servidor = "localhost";
$usuario = "root";
$contrasena = "";
$base_datos = "edutask";

$conn = mysqli_connect($servidor, $usuario, $contrasena, $base_datos);

if (!$conn) {
    die("Error de conexión: " . mysqli_connect_error());
}

mysqli_set_charset($conn, "utf8mb4");