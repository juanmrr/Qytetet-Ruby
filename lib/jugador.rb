# coding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "casilla"
require_relative "titulo_propiedad"
require_relative "sorpresa"

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
   
    total = 0
    
    @propiedaes.each do |i|
      total = total + i.num_casas + i.num_hoteles
    end
    
    total
    
  end
  
  def debo_pagar_alquiler
    raise NotImplementedError 
  end
  
  def devolver_carta_libertad
    
    carta = @carta_libertad
    
    @carta_libertad = nil
    
    carta
    
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
  
  def modificar_saldo(cantidad)
    
    @saldo = @saldo + cantidad 
    
  end
  
  def obtener_capital
    
    capital = @saldo
    
    @propiedades.each do |i|
      capital = capital + i.precio_compra + (i.num_casas + i.num_hoteles) * i.precio_edficar
      if (i.hipotecada)
        capital = capital - i.hipoteca_base
      end
    end
    
    capital
    
  end
  
  def obtener_propiedades(hipotecada)
    
    aux = Array.new
    
    @propiedades.each do |i|
      if (i.hipotecada == hipotecada)
        aux << i
      end
    end
      
    aux
    
  end
  
  def pagar_alquiler
    raise NotImplementedError 
  end
  
  def pagar_impuesto
    
    self.modificar_saldo(-@casilla_actual.coste)
    
  end
  
  def pagar_libertad(cantidad)
    raise NotImplementedError 
  end
  
  def tengo_carta_libertad
    
    aux = false
    
    if (@carta_libertad != nil)
      aux = true
    end
    
    aux
    
  end
  
  def vender_propiedad
    raise NotImplementedError 
  end
  
  private
  
  def eliminar_de_mis_propiedades(titulo)
    raise NotImplementedError 
  end
  
  def es_de_mi_propiedad(titulo)
    
    aux = false
    
    @propiedades.each do |i|
      if (i == titulo)
        aux = true
      end
    end
    
    aux
    
  end
  
  def tengo_saldo(cantidad)
    
    tengo_saldo = false
    
    if (@saldo > cantidad)
      tengo_saldo = true
    end
    
    tengo_saldo
    
  end
  
  def to_s
    
    aux = "{" + "Nombre: #{@nombre}" + ", encarcelado: #{@encarcelado}" + ", saldo: #{@saldo}" + ", capital: #{obtener_capital}"
    
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
      
    aux = aux + "}"
      
    aux
    
    end
  
  end

  def <=>(otroJugador)            
    otroJugador.obtenerCapital <=> obtenerCapital     
  end


end

end