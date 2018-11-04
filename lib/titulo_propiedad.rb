# coding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "jugador"

module ModeloQytetet

class TituloPropiedad
  
  def initialize (nombre, precio_compra, alquiler_base, factor_revalorizacion, hipoteca_base, precio_edificar)
    @nombre = nombre
    @hipotecada = false
    @precio_compra = precio_compra
    @alquiler_base = alquiler_base
    @factor_revalorizacion = factor_revalorizacion
    @hipoteca_base = hipoteca_base
    @precio_edificar = precio_edificar
    @num_hoteles = 0
    @num_casas = 0
    @propietario = nil
  end
  
  attr_reader :nombre, :hipotecada, :precio_compra, :alquiler_base, :factor_revalorizacion, :hipoteca_base, :precio_edficar, :num_hoteles, :num_casas, :propietario
  
  attr_writer :propietario, :hipotecada  
  
  def calcular_coste_cancelar
    raise NotImplementedError 
  end
  
  def calcular_coste_hipotecar
    raise NotImplementedError 
  end
  
  def calcular_importe_alquiler
    raise NotImplementedError 
  end
  
  def cancelar_hipoteca
    raise NotImplementedError 
  end
  
  def cobrar_alquiler
    raise NotImplementedError 
  end
  
  def edificar_casa
    raise NotImplementedError 
  end
  
  def edificar_hotel
    raise NotImplementedError 
  end
  
  def hipotecar
    raise NotImplementedError 
  end
  
  def pagar_alquiler
    raise NotImplementedError 
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
      
      cadena = cadena + ", propietario: #{@propietario}"
      
    else
      
      cadena = cadena + ", no tiene propietario"
      
    end
    
    cadena = cadena + "}"
    
  end
  
end

end
