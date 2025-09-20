package com.miempresa.bank.servlet;

import com.miempresa.bank.dao.LoanDAO;
import com.miempresa.bank.dao.UserDAO;
import com.miempresa.bank.model.Loan;
import com.miempresa.bank.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private LoanDAO loanDao = new LoanDAO();
    private UserDAO userDao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        
        // Verificar autenticación y rol de administrador
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRol())) {
            resp.sendRedirect("loans");
            return;
        }
        
        // Obtener todos los préstamos para administración
        List<Loan> allLoans = loanDao.findAll();
        List<User> allUsers = userDao.findAll();
        
        req.setAttribute("loans", allLoans);
        req.setAttribute("users", allUsers);
        req.getRequestDispatcher("admin/admin_panel.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        
        // Verificar autenticación y rol de administrador
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRol())) {
            resp.sendRedirect("loans");
            return;
        }
        
        // Procesar acciones de administración
        String action = req.getParameter("action");
        String loanId = req.getParameter("loanId");
        String newStatus = req.getParameter("status");
        
        if ("updateStatus".equals(action) && loanId != null && newStatus != null) {
            boolean updated = loanDao.updateStatus(Integer.parseInt(loanId), newStatus);
            if (updated) {
                req.setAttribute("success", "Estado del préstamo actualizado correctamente");
            } else {
                req.setAttribute("error", "Error al actualizar el estado del préstamo");
            }
        }
        
        doGet(req, resp);
    }
}