
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#require_relative "tipo_sorpresa"

module ModeloQytetet

class Sorpresa
 
  def initialize(texto, valor, tipo)
    @texto = texto
    @tipo = tipo
    @valor = valor
  end
  
  attr_reader :texto, :tipo, :valor

  def to_s
    
    "Texto: #{@texto} \n Valor: #{@valor} \n Tipo: #{@tipo}"
    
  end 
  
end

end