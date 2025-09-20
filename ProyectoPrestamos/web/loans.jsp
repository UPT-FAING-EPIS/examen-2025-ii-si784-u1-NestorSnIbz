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
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis préstamos</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/responsive.css">
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <h1>Mis Préstamos</h1>
                <div class="user-info">
                    Bienvenido, <%= user.getNombre() %>
                </div>
                <div class="nav-links">
                    <a href="logout">Cerrar sesión</a>
                </div>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="section">
            <h2>Solicitar nuevo préstamo</h2>
            <form method="post" action="loans">
                <div>
                    <label for="monto">Monto:</label>
                    <input id="monto" name="monto" required/>
                </div>
                <div>
                    <label for="plazo">Plazo (meses):</label>
                    <input id="plazo" name="plazo" required/>
                </div>
                <div>
                    <label for="tasa">Tasa (%):</label>
                    <input id="tasa" name="tasa" required/>
                </div>
                <div>
                    <label for="descripcion">Descripción:</label>
                    <input id="descripcion" name="descripcion"/>
                </div>
                <button type="submit" class="btn btn-primary">Solicitar</button>
            </form>
        </div>

        <div class="section">
            <h2>Lista de préstamos</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Monto</th>
                        <th>Plazo</th>
                        <th>Tasa</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
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
                        <td><a href="loan?id=<%= l.getId() %>" class="btn btn-primary">Ver</a></td>
                      </tr>
                    <%
                        }
                      }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>