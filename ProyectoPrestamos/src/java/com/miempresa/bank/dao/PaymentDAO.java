package com.miempresa.bank.dao;

import com.miempresa.bank.model.Payment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public boolean create(Payment p) {
        String sql = "INSERT INTO pago(fk_prestamo,monto,fecha_pago,metodo,comentario) VALUES(?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, p.getFkPrestamo());
            ps.setDouble(2, p.getMonto());
            ps.setDate(3, p.getFechaPago() == null ? new Date(System.currentTimeMillis()) : p.getFechaPago());
            ps.setString(4, p.getMetodo());
            ps.setString(5, p.getComentario());
            return ps.executeUpdate()>0;
        } catch(SQLException e){ e.printStackTrace(); }
        return false;
    }

    public List<Payment> findByLoan(int loanId) {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM pago WHERE fk_prestamo = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, loanId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Payment p = new Payment();
                    p.setId(rs.getInt("id"));
                    p.setFkPrestamo(rs.getInt("fk_prestamo"));
                    p.setMonto(rs.getDouble("monto"));
                    p.setFechaPago(rs.getDate("fecha_pago"));
                    p.setMetodo(rs.getString("metodo"));
                    p.setComentario(rs.getString("comentario"));
                    list.add(p);
                }
            }
        } catch(SQLException e){ e.printStackTrace(); }
        return list;
    }
}
