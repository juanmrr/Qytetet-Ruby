# coding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#require_relative "casilla"
#require_relative "titulo_propiedad"
#require_relative "sorpresa"

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
  
  attr_writer :carta_libertad, :casilla_actual, :encarcelado, :propiedades, :saldo
  
  def cancelar_hipoteca(titulo)
    
    cancelar = false
    
    cantidad = titulo.calcular_coste_cancelar
    
    if (@saldo > cantidad)
      modificar_saldo(-cantidad)
      cancelar = true
      titulo.cancelar_hipoteca
    end
    
    cancelar
    
  end
  
  def comprar_titulo_propiedad
    
    comprado = false
    
    coste_compra = @casilla_actual.coste
    
    if (coste_compra < @saldo)
      titulo = @casilla_actual.asignar_propietario(self)
      comprado = true
      @propiedades << titulo
      modificar_saldo(-coste_compra)
    end
    
    comprado
    
  end
  
  def cuantas_casas_hoteles_tengo
   
    total = 0
    
    @propiedades.each do |i|
      total = total + i.num_casas + i.num_hoteles
    end
    
    total
    
  end
  
  def debo_pagar_alquiler
    
    debo_pagar = false
    
    titulo = @casilla_actual.titulo
    
    es_de_mi_propiedad = es_de_mi_propiedad(titulo)
    
    tiene_propietario = !es_de_mi_propiedad && titulo.tengo_propietario
    
    encarcelado = !es_de_mi_propiedad && tiene_propietario && titulo.propietario_encarcelado
    
    esta_hipotecada = !es_de_mi_propiedad && tiene_propietario && !encarcelado && titulo.hipotecada
    
    debo_pagar = !es_de_mi_propiedad && tiene_propietario && !encarcelado && !esta_hipotecada
    
    debo_pagar
    
  end
  
  def devolver_carta_libertad
    
    carta = @carta_libertad
    
    @carta_libertad = nil
    
    carta
    
  end
  
  def edificar_casa(titulo)
    
    edificada = false
    
    num_casas = titulo.num_casas
    
    if (num_casas < 4)
      coste_edificar_casa = titulo.precio_edficar
      tengo_saldo = tengo_saldo(coste_edificar_casa)
      if (tengo_saldo)
        titulo.edificar_casa
        modificar_saldo(-coste_edificar_casa)
        edificada = true
      end
    end
    
    edificada
    
  end
  
  def edificar_hotel(titulo)
    
    edificado = false
    
    num_hoteles = titulo.num_hoteles
    
    if (num_hoteles < 4)
      coste_edificar_hotel = titulo.precio_edficar
      tengo_saldo = tengo_saldo(coste_edificar_hotel)
      if (tengo_saldo)
        titulo.edificar_hotel
        modificar_saldo(-coste_edificar_hotel)
        edificado = true
      end
    end
    
    edificado
    
  end
  
  def estoy_en_calle_libre
    raise NotImplementedError 
  end
  
  def hipotecar_propiedad(titulo)
    
    coste_hipoteca = titulo.hipotecar
    
    modificar_saldo(coste_hipoteca)
    
  end
  
  def ir_a_carcel(casilla)
    
    @casilla_actual = casilla
    
    @encarcelado = true
    
  end
  
  def modificar_saldo(cantidad)
    
    @saldo = @saldo + cantidad 
    
  end
  
  def obtener_capital
    
    capital = @saldo
    
    @propiedades.each do |i|
      capital = capital + (i.num_casas + i.num_hoteles) * i.precio_edficar
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
   
    coste_alquiler = @casilla_actual.pagar_alquiler
    
    modificar_saldo(-coste_alquiler)
    
  end
  
  def pagar_impuesto
    
    self.modificar_saldo(@casilla_actual.coste)
    
  end
  
  def pagar_libertad(cantidad)
    
    tengo_saldo = tengo_saldo(cantidad)
    
    if (tengo_saldo)
      @encarcelado = false
      modificar_saldo(-cantidad)
    end
    
  end
  
  def tengo_carta_libertad
    
    aux = false
    
    if (@carta_libertad != nil)
      aux = true
    end
    
    aux
    
  end
  
  def vender_propiedad(casilla)
    
    titulo = casilla.titulo
    
    eliminar_de_mis_propiedades(titulo)
    
    precio_venta = titulo.calcular_precio_venta
    
    modificar_saldo(precio_venta)
    
  end
  
  def eliminar_de_mis_propiedades(titulo)
    
    @propiedades.delete(titulo)
    
    titulo.propietario = nil
    
  end
  
  private
  
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
  
  public
  
  def to_s
    
    aux = "{" + "Nombre: #{@nombre}" + ", encarcelado: #{@encarcelado}" + ", saldo: #{@saldo}" + ", capital: #{obtener_capital}"
    
    if (@carta_libertad != nil) then
      aux = aux + ", carta libertad: #{@carta_libertad}"
    end
    
    if (@propiedades.empty?) then
      aux = aux + ", el jugador no tiene propiedades"
    else
      @propiedades.each do |i|
        aux = aux + ", " + i.nombre
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
    otroJugador.obtener_capital <=> obtener_capital     
  end


end

end