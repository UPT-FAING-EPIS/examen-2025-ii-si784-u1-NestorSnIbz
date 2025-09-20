<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/responsive.css">
</head>
<body>
    <div class="container" style="max-width: 500px; margin-top: 50px;">
        <div class="section">
            <h2 class="text-center">Registro</h2>
            <form method="post" action="register">
                <div>
                    <label for="username">Usuario:</label>
                    <input id="username" name="username"/>
                </div>
                <div>
                    <label for="nombre">Nombre:</label>
                    <input id="nombre" name="nombre"/>
                </div>
                <div>
                    <label for="email">Email:</label>
                    <input id="email" name="email"/>
                </div>
                <div>
                    <label for="password">Contraseña:</label>
                    <input id="password" name="password" type="password"/>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%;">Registrar</button>
            </form>
            <p class="text-center mt-2"><a href="login">Ya tengo cuenta</a></p>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
        </div>
    </div>
</body>
</html>