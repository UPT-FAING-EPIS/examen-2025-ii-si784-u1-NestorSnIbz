<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.miempresa.bank.model.Loan" %>
<%@ page import="com.miempresa.bank.model.Payment" %>
<%@ page import="java.util.List" %>
<%
  Loan loan = (Loan) request.getAttribute("loan");
  List<Payment> pagos = (List<Payment>) request.getAttribute("pagos");
%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8"/><title>Detalles préstamo</title></head>
<body>
  <h2>Detalles del préstamo #<%= loan.getId() %></h2>
  <p>Monto: <%= loan.getMonto() %></p>
  <p>Plazo: <%= loan.getPlazoMeses() %> meses</p>
  <p>Tasa: <%= loan.getTasa() %> %</p>
  <p>Estado: <%= loan.getEstado() %></p>

  <h3>Registrar pago</h3>
  <form method="post" action="payment">
    <input type="hidden" name="fk_prestamo" value="<%= loan.getId() %>"/>
    Monto: <input name="monto" required/><br/>
    Metodo: <input name="metodo"/><br/>
    Comentario: <input name="comentario"/><br/>
    <button type="submit">Registrar pago</button>
  </form>

  <h3>Historial de pagos</h3>
  <table border="1">
    <tr><th>ID</th><th>Monto</th><th>Fecha</th><th>Metodo</th><th>Comentario</th></tr>
    <%
      if (pagos != null) {
        for (Payment p : pagos) {
    %>
      <tr>
        <td><%= p.getId() %></td>
        <td><%= p.getMonto() %></td>
        <td><%= p.getFechaPago() %></td>
        <td><%= p.getMetodo() %></td>
        <td><%= p.getComentario() %></td>
      </tr>
    <%
        }
      }
    %>
  </table>

  <p><a href="loans">Volver</a></p>
</body>
</html>
