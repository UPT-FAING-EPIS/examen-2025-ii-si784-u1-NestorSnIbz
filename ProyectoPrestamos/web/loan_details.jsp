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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles del Préstamo</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/responsive.css">
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <h1>Detalles del Préstamo #<%= loan.getId() %></h1>
                <div class="nav-links">
                    <a href="loans">Volver a mis préstamos</a>
                    <a href="logout">Cerrar sesión</a>
                </div>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="section">
            <h2>Información del Préstamo</h2>
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
        </div>

        <div class="section">
            <h2>Realizar Pago</h2>
            <form method="post" action="payment">
                <input type="hidden" name="fk_prestamo" value="<%= loan.getId() %>">
                <div>
                    <label for="monto">Monto:</label>
                    <input id="monto" name="monto" type="number" step="0.01" required>
                </div>
                <div>
                    <label for="metodo">Método de pago:</label>
                    <select id="metodo" name="metodo" required>
                        <option value="TARJETA">Tarjeta</option>
                        <option value="TRANSFERENCIA">Transferencia</option>
                        <option value="EFECTIVO">Efectivo</option>
                    </select>
                </div>
                <div>
                    <label for="comentario">Comentario:</label>
                    <input id="comentario" name="comentario">
                </div>
                <button type="submit" class="btn btn-primary">Registrar Pago</button>
            </form>
        </div>

        <div class="section">
            <h2>Historial de Pagos</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Fecha</th>
                        <th>Monto</th>
                        <th>Método</th>
                        <th>Comentario</th>
                    </tr>
                </thead>
                <tbody>
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
                </tbody>
            </table>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
    </div>
</body>
</html>