package com.miempresa.bank.servlet;

import com.miempresa.bank.dao.UserDAO;
import com.miempresa.bank.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDao = new UserDAO();

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String pass = req.getParameter("password");
        String nombre = req.getParameter("nombre");
        String email = req.getParameter("email");

        User u = new User();
        u.setUsername(username);
        u.setPassword(pass); // en prod: hash
        u.setNombre(nombre);
        u.setEmail(email);
        u.setRol("CLIENTE");

        boolean ok = userDao.create(u);
        if (ok) {
            resp.sendRedirect("login");
        } else {
            req.setAttribute("error", "No se pudo crear usuario. Verifique datos.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }
}
