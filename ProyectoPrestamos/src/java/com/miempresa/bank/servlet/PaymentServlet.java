package com.miempresa.bank.servlet;

import com.miempresa.bank.dao.PaymentDAO;
import com.miempresa.bank.model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private PaymentDAO paymentDao = new PaymentDAO();

    @Override
    protected void doPost(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws ServletException, IOException {
        String fkPrestamo = req.getParameter("fk_prestamo");
        String montoS = req.getParameter("monto");
        String metodo = req.getParameter("metodo");
        String comentario = req.getParameter("comentario");

        Payment p = new Payment();
        p.setFkPrestamo(Integer.parseInt(fkPrestamo));
        p.setMonto(Double.parseDouble(montoS));
        p.setFechaPago(new Date(System.currentTimeMillis()));
        p.setMetodo(metodo);
        p.setComentario(comentario);

        boolean ok = paymentDao.create(p);
        if (ok) {
            resp.sendRedirect("loan?id="+fkPrestamo);
        } else {
            req.setAttribute("error","No se pudo registrar el pago");
            req.getRequestDispatcher("loan_details.jsp").forward(req, resp);
        }
    }
}
