<!DOCTYPE html>
<html>
<head><meta charset="utf-8"/><title>Registro</title></head>
<body>
  <h2>Registro</h2>
  <form method="post" action="register">
    Usuario: <input name="username"/><br/>
    Nombre: <input name="nombre"/><br/>
    Email: <input name="email"/><br/>
    Contraseña: <input name="password" type="password"/><br/>
    <button type="submit">Registrar</button>
  </form>
  <p><a href="login">Ya tengo cuenta</a></p>
  <c:if test="${not empty error}">
    <div style="color:red">${error}</div>
  </c:if>
</body>
</html>
