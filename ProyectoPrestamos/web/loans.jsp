<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.miempresa.bank.model.Loan" %>
<%
    com.miempresa.bank.model.User user = (com.miempresa.bank.model.User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("login"); return; }
    List<Loan> loans = (List<Loan>) request.getAttribute("loans");
%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8"/><title>Mis préstamos</title></head>
<body>
  <h2>Bienvenido, <%= user.getNombre() %> - Mis préstamos</h2>
  <a href="logout">Cerrar sesión</a>
  <h3>Solicitar nuevo préstamo</h3>
  <form method="post" action="loans">
    Monto: <input name="monto" required/><br/>
    Plazo (meses): <input name="plazo" required/><br/>
    Tasa (%): <input name="tasa" required/><br/>
    Descripción: <input name="descripcion"/><br/>
    <button type="submit">Solicitar</button>
  </form>

  <h3>Lista de préstamos</h3>
  <table border="1">
    <tr><th>ID</th><th>Monto</th><th>Plazo</th><th>Tasa</th><th>Estado</th><th>Acciones</th></tr>
    <%
      if (loans != null) {
        for (Loan l : loans) {
    %>
      <tr>
        <td><%= l.getId() %></td>
        <td><%= l.getMonto() %></td>
        <td><%= l.getPlazoMeses() %></td>
        <td><%= l.getTasa() %></td>
        <td><%= l.getEstado() %></td>
        <td><a href="loan?id=<%= l.getId() %>">Ver</a></td>
      </tr>
    <%
        }
      }
    %>
  </table>
</body>
</html>
