/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba;

import controladores.CategoriaJpaController;
import modelos.Categoria;

/**
 *
 * @author X1
 */
public class Prueba {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        CategoriaJpaController controlador=new CategoriaJpaController();
        Categoria categorias=new Categoria();
        categorias.setCategoria("Paola");
        categorias.setImagenCat("urlchida");
        controlador.create(categorias);
    }
    
}
