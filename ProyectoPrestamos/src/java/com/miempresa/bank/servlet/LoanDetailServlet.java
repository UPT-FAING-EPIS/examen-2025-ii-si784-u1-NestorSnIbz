package com.miempresa.bank.servlet;

import com.miempresa.bank.dao.LoanDAO;
import com.miempresa.bank.dao.PaymentDAO;
import com.miempresa.bank.model.Loan;
import com.miempresa.bank.model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/loan")
public class LoanDetailServlet extends HttpServlet {
    private LoanDAO loanDao = new LoanDAO();
    private PaymentDAO paymentDao = new PaymentDAO();

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws ServletException, IOException {
        String idS = req.getParameter("id");
        if (idS==null) { resp.sendRedirect("loans"); return; }
        int id = Integer.parseInt(idS);
        Loan l = loanDao.findById(id);
        if (l==null) { resp.sendRedirect("loans"); return; }
        List<Payment> pagos = paymentDao.findByLoan(id);
        req.setAttribute("loan", l);
        req.setAttribute("pagos", pagos);
        req.getRequestDispatcher("loan_details.jsp").forward(req, resp);
    }
}
