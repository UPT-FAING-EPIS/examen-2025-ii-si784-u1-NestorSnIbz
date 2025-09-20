package com.miempresa.bank.servlet;

import com.miempresa.bank.dao.UserDAO;
import com.miempresa.bank.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDao = new UserDAO();

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User u = userDao.findByUsername(username);
        if (u != null && u.getPassword().equals(password)) {
            HttpSession session = req.getSession();
            session.setAttribute("user", u);
            resp.sendRedirect("loans");
        } else {
            req.setAttribute("error", "Usuario o contraseña incorrectos");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
