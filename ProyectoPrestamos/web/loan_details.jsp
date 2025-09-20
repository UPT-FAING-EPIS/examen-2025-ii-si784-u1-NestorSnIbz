<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.miempresa.bank.model.Loan" %>
<%@ page import="com.miempresa.bank.model.Payment" %>
<%
    com.miempresa.bank.model.User user = (com.miempresa.bank.model.User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("login"); return; }
    Loan loan = (Loan) request.getAttribute("loan");
    List<Payment> pagos = (List<Payment>) request.getAttribute("pagos");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Detalles del Préstamo</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h2>Detalles del Préstamo #<%= loan.getId() %></h2>
    <a href="loans">Volver a mis préstamos</a>
    
    <h3>Información del Préstamo</h3>
    <table>
        <tr><th>Monto:</th><td><%= loan.getMonto() %></td></tr>
        <tr><th>Plazo (meses):</th><td><%= loan.getPlazoMeses() %></td></tr>
        <tr><th>Tasa:</th><td><%= loan.getTasa() %>%</td></tr>
        <tr><th>Estado:</th><td><%= loan.getEstado() %></td></tr>
        <tr><th>Descripción:</th><td><%= loan.getDescripcion() %></td></tr>
        <tr><th>Fecha de Solicitud:</th><td><%= loan.getFechaSolicitud() %></td></tr>
        <% if (loan.getFechaAprobacion() != null) { %>
        <tr><th>Fecha de Aprobación:</th><td><%= loan.getFechaAprobacion() %></td></tr>
        <% } %>
    </table>

    <h3>Realizar Pago</h3>
    <form method="post" action="payment">
        <input type="hidden" name="fk_prestamo" value="<%= loan.getId() %>">
        Monto: <input name="monto" type="number" step="0.01" required><br>
        Método de pago: 
        <select name="metodo" required>
            <option value="TARJETA">Tarjeta</option>
            <option value="TRANSFERENCIA">Transferencia</option>
            <option value="EFECTIVO">Efectivo</option>
        </select><br>
        Comentario: <input name="comentario"><br>
        <button type="submit">Registrar Pago</button>
    </form>

    <h3>Historial de Pagos</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Fecha</th>
            <th>Monto</th>
            <th>Método</th>
            <th>Comentario</th>
        </tr>
        <%
            if (pagos != null && !pagos.isEmpty()) {
                for (Payment p : pagos) {
        %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getFechaPago() %></td>
                <td><%= p.getMonto() %></td>
                <td><%= p.getMetodo() %></td>
                <td><%= p.getComentario() %></td>
            </tr>
        <%
                }
            } else {
        %>
            <tr><td colspan="5">No hay pagos registrados</td></tr>
        <% } %>
    </table>

    <c:if test="${not empty error}">
        <div style="color:red">${error}</div>
    </c:if>
</body>
</html>