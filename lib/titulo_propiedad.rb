# coding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#require_relative "jugador"

module ModeloQytetet

class TituloPropiedad
  
  def initialize (nombre, precio_compra, alquiler_base, factor_revalorizacion, hipoteca_base, precio_edificar)
    @nombre = nombre
    @hipotecada = false
    @precio_compra = precio_compra
    @alquiler_base = alquiler_base
    @factor_revalorizacion = factor_revalorizacion
    @hipoteca_base = hipoteca_base
    @precio_edficar = precio_edificar
    @num_hoteles = 0
    @num_casas = 0
    @propietario = nil
  end
  
  attr_reader :nombre, :hipotecada, :precio_compra, :alquiler_base, :factor_revalorizacion, :hipoteca_base, :precio_edficar, :num_hoteles, :num_casas, :propietario
  
  attr_writer :propietario, :hipotecada
  
  def calcular_coste_cancelar
    
    coste_cancelar = calcular_coste_hipotecar * 1.1
    
    coste_cancelar
    
  end
  
  def calcular_coste_hipotecar
    
    coste_hipoteca = @hipoteca_base * (1 + (@num_casas * 0.5 + @num_hoteles * 2))
    
    coste_hipoteca
    
  end
  
  def calcular_importe_alquiler
    
    coste_alquiler = (@alquiler_base * ((@num_casas * 0.5 + @num_hoteles * 2) + 1))
    
    coste_alquiler
    
  end
  
  def calcular_precio_venta
    
    precio_venta = @precio_compra + (@num_casas + @num_hoteles) * @precio_edficar * @factor_revalorizacion
    
    precio_venta
    
  end
  
  def cancelar_hipoteca
    
    @hipotecada = false
    
  end
  
  def cobrar_alquiler
    raise NotImplementedError 
  end
  
  def edificar_casa
    
    @num_casas = @num_casas + 1
   
  end
  
  def edificar_hotel
    r
    @num_hoteles = @num_hoteles + 1
    
  end
  
  def hipotecar
    
    coste_hipoteca = calcular_coste_hipotecar
    
    @hipotecada = true
    
    coste_hipoteca
    
  end
  
  def pagar_alquiler
    
    coste_alquiler = calcular_importe_alquiler
    
    @propietario.modificar_saldo(coste_alquiler)
    
    coste_alquiler
    
  end
  
  def propietario_encarcelado
    
    aux = false
    
    if (@propietario.encarcelado)
      aux = true
    end
    
    aux
    
  end
  
  def tengo_propietario
    
    aux = false
    
    if (@propietario != nil)
      aux = true
    end
    
    aux
    
  end
  
  def to_s
    
    cadena = "Nombre: #{@nombre}" + ", Hipotecada: #{@hipotecada}" + ", Precio de compra: #{@precio_compra}" + ", Alquiler base: #{@alquiler_base}" + ", Factor de revalorización: #{@factor_revalorizacion}" + ", Hipoteca base: #{@hipoteca_base}" + ", Precio de edificación: #{@precio_edificar}" + ", Número de hoteles: #{@num_hoteles}" + ", Número de casas: #{@num_casas}"
      
    if (propietario != nil)
      
      cadena = cadena + ", propietario: #{@propietario.nombre}"
      
    else
      
      cadena = cadena + ", no tiene propietario"
      
    end
    
    cadena = cadena + "}"
    
  end
  
end

end
