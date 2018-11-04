# coding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "tipo_casilla"
require_relative "titulo_propiedad"

module ModeloQytetet

class Casilla
  
  private_class_method :new
  
  def initialize (numero_casilla, coste, tipo, titulo)
    @numero_casilla = numero_casilla
    @coste = coste
    @tipo = tipo
    @titulo = titulo
  end
  
  attr_reader :numero_casilla, :coste, :tipo
  
  def self.crea_calle (numero, titulo)
    
    new(numero, titulo.precio_compra, TipoCasilla::CALLE, titulo)

  end
  
  def self.crea_casilla(numero, coste, tipo)
    
    new(numero, coste, tipo, nil)
    
  end
  
  def asignar_propietario(jugador)
    raise NotImplementedError 
  end
  
  def pagar_alquiler
    raise NotImplementedError 
  end
  
  def propietario_encarcelado
    
    @titulo.propietario_encarcelado
    
  end
  
  def soy_edificable
    
    aux = false
    
    if (@tipo == TipoCasilla::CALLE)
      aux = true
    end
    
    aux
    
  end
  
  def tengo_propietario
    
    @titulo.tengo_propietario
    
  end
  
  def to_s
    
    aux = "{Número de casilla: #{@numero_casilla}" + ", Coste: #{@coste}" + ", Tipo: #{@tipo} "
    
    if (@titulo != nil)
      
      aux = aux + @titulo.to_s
     
    end
    
    aux = aux + "}"
    
    aux
    
  end
  
  private 
  
  attr_accessor :titulo
  
end

end