package com.miempresa.bank.dao;

import com.miempresa.bank.model.Loan;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LoanDAO {

    public boolean create(Loan loan) {
        String sql = "INSERT INTO prestamo(fk_usuario,monto,plazo_meses,tasa,estado,descripcion) VALUES(?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, loan.getFkUsuario());
            ps.setDouble(2, loan.getMonto());
            ps.setInt(3, loan.getPlazoMeses());
            ps.setDouble(4, loan.getTasa());
            ps.setString(5, loan.getEstado()==null?"SOLICITADO":loan.getEstado());
            ps.setString(6, loan.getDescripcion());
            return ps.executeUpdate()>0;
        } catch(SQLException e){
            e.printStackTrace();
        }
        return false;
    }

    public List<Loan> findByUser(int userId){
        List<Loan> list = new ArrayList<>();
        String sql = "SELECT * FROM prestamo WHERE fk_usuario = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()){
                    Loan l = new Loan();
                    l.setId(rs.getInt("id"));
                    l.setFkUsuario(rs.getInt("fk_usuario"));
                    l.setMonto(rs.getDouble("monto"));
                    l.setPlazoMeses(rs.getInt("plazo_meses"));
                    l.setTasa(rs.getDouble("tasa"));
                    l.setEstado(rs.getString("estado"));
                    l.setDescripcion(rs.getString("descripcion"));
                    l.setFechaSolicitud(rs.getDate("fecha_solicitud"));
                    l.setFechaAprobacion(rs.getDate("fecha_aprobacion"));
                    list.add(l);
                }
            }
        } catch(SQLException e){ e.printStackTrace(); }
        return list;
    }

    public Loan findById(int id){
        String sql = "SELECT * FROM prestamo WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1,id);
            try (ResultSet rs = ps.executeQuery()){
                if(rs.next()){
                    Loan l = new Loan();
                    l.setId(rs.getInt("id"));
                    l.setFkUsuario(rs.getInt("fk_usuario"));
                    l.setMonto(rs.getDouble("monto"));
                    l.setPlazoMeses(rs.getInt("plazo_meses"));
                    l.setTasa(rs.getDouble("tasa"));
                    l.setEstado(rs.getString("estado"));
                    l.setDescripcion(rs.getString("descripcion"));
                    l.setFechaSolicitud(rs.getDate("fecha_solicitud"));
                    l.setFechaAprobacion(rs.getDate("fecha_aprobacion"));
                    return l;
                }
            }
        } catch(SQLException e){ e.printStackTrace(); }
        return null;
    }

    public boolean updateStatus(int id, String estado){
        String sql = "UPDATE prestamo SET estado = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, estado);
            ps.setInt(2, id);
            return ps.executeUpdate()>0;
        } catch(SQLException e){ e.printStackTrace(); }
        return false;
    }
}
