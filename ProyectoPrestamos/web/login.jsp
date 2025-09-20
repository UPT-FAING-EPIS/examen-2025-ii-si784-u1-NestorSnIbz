<!DOCTYPE html>
<html>
<head><meta charset="utf-8"/><title>Iniciar sesión</title></head>
<body>
  <h2>Login</h2>
  <form method="post" action="login">
    Usuario: <input name="username"/><br/>
    Contraseña: <input name="password" type="password"/><br/>
    <button type="submit">Entrar</button>
  </form>
  <p><a href="register">Crear cuenta</a></p>
  <c:if test="${not empty error}">
    <div style="color:red">${error}</div>
  </c:if>
</body>
</html>
