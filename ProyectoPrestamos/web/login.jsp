<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/responsive.css">
</head>
<body>
    <div class="container" style="max-width: 500px; margin-top: 50px;">
        <div class="section">
            <h2 class="text-center">Login</h2>
            <form method="post" action="login">
                <div>
                    <label for="username">Usuario:</label>
                    <input id="username" name="username"/>
                </div>
                <div>
                    <label for="password">Contraseña:</label>
                    <input id="password" name="password" type="password"/>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%;">Entrar</button>
            </form>
            <p class="text-center mt-2"><a href="register">Crear cuenta</a></p>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
        </div>
    </div>
</body>
</html>