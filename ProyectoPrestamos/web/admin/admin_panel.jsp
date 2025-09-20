<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.miempresa.bank.model.Loan" %>
<%@ page import="com.miempresa.bank.model.User" %>
<%
    com.miempresa.bank.model.User user = (com.miempresa.bank.model.User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRol())) { 
        response.sendRedirect("login"); 
        return; 
    }
    
    List<Loan> loans = (List<Loan>) request.getAttribute("loans");
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Panel de Administración</title>
    <style>
        table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .section { margin-bottom: 30px; }
    </style>
</head>
<body>
    <h2>Panel de Administración</h2>
    <p>Bienvenido, <%= user.getNombre() %> (<%= user.getRol() %>)</p>
    <a href="loans">Volver a mis préstamos</a> | 
    <a href="logout">Cerrar sesión</a>
    
    <div class="section">
        <h3>Gestión de Préstamos</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Usuario ID</th>
                <th>Monto</th>
                <th>Plazo</th>
                <th>Tasa</th>
                <th>Estado</th>
                <th>Fecha Solicitud</th>
                <th>Acciones</th>
            </tr>
            <% if (loans != null && !loans.isEmpty()) { 
                for (Loan loan : loans) { %>
            <tr>
                <td><%= loan.getId() %></td>
                <td><%= loan.getFkUsuario() %></td>
                <td><%= loan.getMonto() %></td>
                <td><%= loan.getPlazoMeses() %> meses</td>
                <td><%= loan.getTasa() %>%</td>
                <td><%= loan.getEstado() %></td>
                <td><%= loan.getFechaSolicitud() %></td>
                <td>
                    <form method="post" action="admin" style="display:inline;">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="loanId" value="<%= loan.getId() %>">
                        <select name="status">
                            <option value="SOLICITADO" <%= "SOLICITADO".equals(loan.getEstado()) ? "selected" : "" %>>Solicitado</option>
                            <option value="APROBADO" <%= "APROBADO".equals(loan.getEstado()) ? "selected" : "" %>>Aprobado</option>
                            <option value="RECHAZADO" <%= "RECHAZADO".equals(loan.getEstado()) ? "selected" : "" %>>Rechazado</option>
                            <option value="PAGADO" <%= "PAGADO".equals(loan.getEstado()) ? "selected" : "" %>>Pagado</option>
                        </select>
                        <button type="submit">Actualizar</button>
                    </form>
                </td>
            </tr>
            <%   }
            } else { %>
            <tr><td colspan="8">No hay préstamos registrados</td></tr>
            <% } %>
        </table>
    </div>
    
    <div class="section">
        <h3>Usuarios Registrados</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Nombre</th>
                <th>Email</th>
                <th>Rol</th>
                <th>Fecha Registro</th>
            </tr>
            <% if (users != null && !users.isEmpty()) { 
                for (User usr : users) { %>
            <tr>
                <td><%= usr.getId() %></td>
                <td><%= usr.getUsername() %></td>
                <td><%= usr.getNombre() %></td>
                <td><%= usr.getEmail() %></td>
                <td><%= usr.getRol() %></td>
                <td><!-- Aquí deberías tener un campo de fecha de registro en tu modelo User --></td>
            </tr>
            <%   }
            } else { %>
            <tr><td colspan="6">No hay usuarios registrados</td></tr>
            <% } %>
        </table>
    </div>

    <c:if test="${not empty success}">
        <div style="color:green">${success}</div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div style="color:red">${error}</div>
    </c:if>
</body>
</html>