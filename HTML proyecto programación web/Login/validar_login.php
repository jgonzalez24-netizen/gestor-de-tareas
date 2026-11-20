<?php
session_start();
require_once "conexion.php";

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    header("Location: Login.html");
    exit;
}

$email = trim($_POST["email"] ?? "");
$contrasena = $_POST["contrasena"] ?? "";

if ($email == "" || $contrasena == "") {
    echo "<script>alert('Escribe tu correo y contraseña.'); window.location.href = 'Login.html';</script>";
    exit;
}

$sql = "SELECT id_usuario, nombres, contrasena, activo FROM usuario WHERE email = ? LIMIT 1";
$stmt = mysqli_prepare($conn, $sql);
mysqli_stmt_bind_param($stmt, "s", $email);
mysqli_stmt_execute($stmt);

$resultado = mysqli_stmt_get_result($stmt);
$usuario = mysqli_fetch_assoc($resultado);

if ($usuario && $usuario["activo"] == 1 && password_verify($contrasena, $usuario["contrasena"])) {
    $_SESSION["id_usuario"] = $usuario["id_usuario"];
    $_SESSION["nombres"] = $usuario["nombres"];

    header("Location: Inicio/inicio.html");
    exit;
} else {
    echo "<script>alert('Correo o contraseña incorrectos.'); window.location.href = 'Login.html';</script>";
    exit;
}
?>