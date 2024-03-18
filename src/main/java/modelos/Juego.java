/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelos;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author X1
 */
@Entity
@Table(name = "juego", catalog = "juegos", schema = "")
@NamedQueries({
    @NamedQuery(name = "Juego.findAll", query = "SELECT j FROM Juego j"),
    @NamedQuery(name = "Juego.findByIdjuego", query = "SELECT j FROM Juego j WHERE j.idjuego = :idjuego"),
    @NamedQuery(name = "Juego.findByNomJuego", query = "SELECT j FROM Juego j WHERE j.nomJuego = :nomJuego"),
    @NamedQuery(name = "Juego.findByPrecio", query = "SELECT j FROM Juego j WHERE j.precio = :precio"),
    @NamedQuery(name = "Juego.findByExistencias", query = "SELECT j FROM Juego j WHERE j.existencias = :existencias"),
    @NamedQuery(name = "Juego.findByImagen", query = "SELECT j FROM Juego j WHERE j.imagen = :imagen"),
    @NamedQuery(name = "Juego.findByClasificacion", query = "SELECT j FROM Juego j WHERE j.clasificacion = :clasificacion")})
public class Juego implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idjuego")
    private Integer idjuego;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 75)
    @Column(name = "nomJuego", unique = true)
    private String nomJuego;
    @Basic(optional = false)
    @NotNull
    @Column(name = "precio")
    private float precio;
    @Basic(optional = false)
    @NotNull
    @Column(name = "existencias")
    private int existencias;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 500)
    @Column(name = "imagen")
    private String imagen;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 15)
    @Column(name = "clasificacion")
    private String clasificacion;
    @JoinColumn(name = "idcategoria", referencedColumnName = "idcategoria")
    @ManyToOne(optional = false)
    private Categoria idcategoria;

    public Juego() {
    }

    public Juego(Integer idjuego) {
        this.idjuego = idjuego;
    }

    public Juego(Integer idjuego, String nomJuego, float precio, int existencias, String imagen, String clasificacion) {
        this.idjuego = idjuego;
        this.nomJuego = nomJuego;
        this.precio = precio;
        this.existencias = existencias;
        this.imagen = imagen;
        this.clasificacion = clasificacion;
    }

    public Integer getIdjuego() {
        return idjuego;
    }

    public void setIdjuego(Integer idjuego) {
        this.idjuego = idjuego;
    }

    public String getNomJuego() {
        return nomJuego;
    }

    public void setNomJuego(String nomJuego) {
        this.nomJuego = nomJuego;
    }

    public float getPrecio() {
        return precio;
    }

    public void setPrecio(float precio) {
        this.precio = precio;
    }

    public int getExistencias() {
        return existencias;
    }

    public void setExistencias(int existencias) {
        this.existencias = existencias;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getClasificacion() {
        return clasificacion;
    }

    public void setClasificacion(String clasificacion) {
        this.clasificacion = clasificacion;
    }

    public Categoria getIdcategoria() {
        return idcategoria;
    }

    public void setIdcategoria(Categoria idcategoria) {
        this.idcategoria = idcategoria;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idjuego != null ? idjuego.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Juego)) {
            return false;
        }
        Juego other = (Juego) object;
        if ((this.idjuego == null && other.idjuego != null) || (this.idjuego != null && !this.idjuego.equals(other.idjuego))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelos.Juego[ idjuego=" + idjuego + " ]";
    }
    
}
