package com.miempresa.bank.model;

import java.sql.Date;

public class Loan {
    private int id;
    private int fkUsuario;
    private double monto;
    private int plazoMeses;
    private double tasa;
    private String estado;
    private Date fechaSolicitud;
    private Date fechaAprobacion;
    private String descripcion;

    // getters y setters...
    public int getId(){return id;}
    public void setId(int id){this.id=id;}
    public int getFkUsuario(){return fkUsuario;}
    public void setFkUsuario(int fkUsuario){this.fkUsuario=fkUsuario;}
    public double getMonto(){return monto;}
    public void setMonto(double monto){this.monto=monto;}
    public int getPlazoMeses(){return plazoMeses;}
    public void setPlazoMeses(int plazoMeses){this.plazoMeses=plazoMeses;}
    public double getTasa(){return tasa;}
    public void setTasa(double tasa){this.tasa=tasa;}
    public String getEstado(){return estado;}
    public void setEstado(String estado){this.estado=estado;}
    public Date getFechaSolicitud(){return fechaSolicitud;}
    public void setFechaSolicitud(Date fechaSolicitud){this.fechaSolicitud=fechaSolicitud;}
    public Date getFechaAprobacion(){return fechaAprobacion;}
    public void setFechaAprobacion(Date fechaAprobacion){this.fechaAprobacion=fechaAprobacion;}
    public String getDescripcion(){return descripcion;}
    public void setDescripcion(String descripcion){this.descripcion=descripcion;}
}
