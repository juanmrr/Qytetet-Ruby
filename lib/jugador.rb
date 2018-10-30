# coding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet

class Jugador
  
  def initialize(nombre)
    @encarcelado = false
    @nombre = nombre
    @saldo = 7500
    @carta_libertad = nil
    @propiedades = Array.new
    @casilla_actual = nil
  end
  
  attr_reader :carta_libertad, :casilla_actual, :encarcelado, :nombre, :propiedades, :saldo
  
  attr_writer :carta_libertad, :casilla_actual, :encarcelado
  
  def cancelar_hipoteca(titulo)
    raise NotImplementedError 
  end
  
  def comprar_titulo_propiedad
    raise NotImplementedError 
  end
  
  def cuantas_casas_hoteles_tengo
    raise NotImplementedError 
  end
  
  def debo_pagar_alquiler
    raise NotImplementedError 
  end
  
  def devolver_carta_libertad
    raise NotImplementedError 
  end
  
  def edificar_casa(titulo)
    raise NotImplementedError 
  end
  
  def edificar_hotel(titulo)
    raise NotImplementedError 
  end
  
  def estoy_en_calle_libre
    raise NotImplementedError 
  end
  
  def hipotecar_propiedad(titulo)
    raise NotImplementedError 
  end
  
  def ir_a_carcel(casilla)
    raise NotImplementedError 
  end
  
  def modificar_saldo
    raise NotImplementedError 
  end
  
  def obtener_capital
    raise NotImplementedError 
  end
  
  def obtener_propiedades(hipotecada)
    raise NotImplementedError 
  end
  
  def pagar_alquiler
    raise NotImplementedError 
  end
  
  def pagar_impuesto
    raise NotImplementedError 
  end
  
  def pagar_libertad(cantidad)
    raise NotImplementedError 
  end
  
  def tengo_carta_libertad
    raise NotImplementedError 
  end
  
  def vender_propiedad
    raise NotImplementedError 
  end
  
  private
  
  def eliminar_de_mis_propiedades(titulo)
    raise NotImplementedError 
  end
  
  def es_de_mi_propiedad(titulo)
    raise NotImplementedError 
  end
  
  def tengo_saldo(cantidad)
    raise NotImplementedError 
  end
  
  def to_s
    
    aux = "{" + "Nombre: #{@nombre}" + ", encarcelado: #{@encarcelado}" + ", saldo: #{@saldo}"
    
    if (@carta_libertad != nil) then
      aux = aux + ", carta libertad: #{@carta_libertad}"
    end
    
    if (@propiedades.empty?) then
      aux = aux + ", el jugador no tiene propiedades"
    else
      @propiedades.each do |i|
        aux = aux + i.nombre + ", "
      end
    end
    
    if (@casilla_actual != nil) then
    
      aux = aux + ", casilla actual: #{@casilla_actual}"
    
    else
      
      aux = aux + ", no se ha asignado una casilla aún"
      
    aux
    
  end
  
end


end

end