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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administración</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/responsive.css">
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <h1>Panel de Administración</h1>
                <div class="user-info">
                    Bienvenido, <%= user.getNombre() %> (<%= user.getRol() %>)
                </div>
                <div class="nav-links">
                    <a href="loans">Volver a mis préstamos</a>
                    <a href="logout">Cerrar sesión</a>
                </div>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="section">
            <h2>Gestión de Préstamos</h2>
            <table>
                <thead>
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
                </thead>
                <tbody>
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
                                <button type="submit" class="btn btn-primary">Actualizar</button>
                            </form>
                        </td>
                    </tr>
                    <%   }
                    } else { %>
                    <tr><td colspan="8">No hay préstamos registrados</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <div class="section">
            <h2>Usuarios Registrados</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Rol</th>
                        <th>Fecha Registro</th>
                    </tr>
                </thead>
                <tbody>
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
                </tbody>
            </table>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
    </div>
</body>
</html>