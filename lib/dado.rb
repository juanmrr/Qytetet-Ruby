# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "singleton"

module ModeloQytetet

class Dado
  
  include Singleton
  
  attr_reader :valor
  
  def initialize
    @valor
  end
  
  def tirar
    
    tirada = rand(1..6)
    
    @valor = tirada
    
    tirada
    
  end
  
end

end
