package com.miempresa.bank.servlet;

import com.miempresa.bank.dao.LoanDAO;
import com.miempresa.bank.model.Loan;
import com.miempresa.bank.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/loans")
public class LoanServlet extends HttpServlet {
    private LoanDAO loanDao = new LoanDAO();

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session==null || session.getAttribute("user")==null) {
            resp.sendRedirect("login");
            return;
        }
        User u = (User) session.getAttribute("user");
        List<Loan> loans = loanDao.findByUser(u.getId());
        req.setAttribute("loans", loans);
        req.getRequestDispatcher("loans.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session==null || session.getAttribute("user")==null) {
            resp.sendRedirect("login");
            return;
        }
        User u = (User) session.getAttribute("user");

        String montoS = req.getParameter("monto");
        String plazoS = req.getParameter("plazo");
        String tasaS = req.getParameter("tasa");
        String descripcion = req.getParameter("descripcion");

        Loan l = new Loan();
        l.setFkUsuario(u.getId());
        l.setMonto(Double.parseDouble(montoS));
        l.setPlazoMeses(Integer.parseInt(plazoS));
        l.setTasa(Double.parseDouble(tasaS));
        l.setDescripcion(descripcion);
        l.setEstado("SOLICITADO");

        boolean ok = loanDao.create(l);
        if (ok) {
            resp.sendRedirect("loans");
        } else {
            req.setAttribute("error", "Error al solicitar préstamo.");
            doGet(req, resp);
        }
    }
}
