package com.miempresa.bank.dao;

import com.miempresa.bank.model.User;
import java.sql.*;

public class UserDAO {

    public User findByUsername(String username) {
        String sql = "SELECT * FROM usuario WHERE username = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setNombre(rs.getString("nombre"));
                    u.setEmail(rs.getString("email"));
                    u.setRol(rs.getString("rol"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean create(User u) {
        String sql = "INSERT INTO usuario(username,password,nombre,email,rol) VALUES(?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword()); // en producción hashear
            ps.setString(3, u.getNombre());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getRol()==null?"CLIENTE":u.getRol());
            int affected = ps.executeUpdate();
            return affected>0;
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
