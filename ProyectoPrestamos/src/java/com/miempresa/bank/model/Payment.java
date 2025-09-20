package com.miempresa.bank.model;

import java.sql.Date;

public class Payment {
    private int id;
    private int fkPrestamo;
    private double monto;
    private Date fechaPago;
    private String metodo;
    private String comentario;

    // getters y setters...
    public int getId(){return id;}
    public void setId(int id){this.id=id;}
    public int getFkPrestamo(){return fkPrestamo;}
    public void setFkPrestamo(int fkPrestamo){this.fkPrestamo=fkPrestamo;}
    public double getMonto(){return monto;}
    public void setMonto(double monto){this.monto=monto;}
    public Date getFechaPago(){return fechaPago;}
    public void setFechaPago(Date fechaPago){this.fechaPago=fechaPago;}
    public String getMetodo(){return metodo;}
    public void setMetodo(String metodo){this.metodo=metodo;}
    public String getComentario(){return comentario;}
    public void setComentario(String comentario){this.comentario=comentario;}
}
