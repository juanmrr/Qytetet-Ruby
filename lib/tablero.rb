# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "casilla"
require_relative "titulo_propiedad"

module ModeloQytetet

  class Tablero
    
  def initialize
    
    @casillas = Array.new
    @carcel

    inicializar

  end
  
  attr_reader :casillas, :carcel
  
  private 
  
  def inicializar
    
    @casillas << Casilla.crea_casilla(0,0,TipoCasilla::SALIDA)
    titulocalle1 = TituloPropiedad.new("Calle Buena Vista",500,50,10,150,250)
    @casillas << Casilla.crea_calle(1,titulocalle1)
    #@casillas.at(1).titulo.casilla = @casillas.at(1)
    titulocalle2 = TituloPropiedad.new("Calle Doctor Victor Escribano",600,60,12,150,250)
    @casillas << Casilla.crea_calle(2,titulocalle2)
    #@casillas.at(2).titulo.casilla = @casillas.at(2)
    titulocalle3 = TituloPropiedad.new("Calle Arabial",700,70,14,150,250)
    @casillas << Casilla.crea_calle(3,titulocalle3)
    #@casillas.at(3).titulo.casilla = @casillas.at(3)
    titulocalle4 = TituloPropiedad.new("Calle Periodista Jose Maria Carulla",800,80,16,150,250)
    @casillas << Casilla.crea_casilla(4,-100,TipoCasilla::SORPRESA)
    @casillas << Casilla.crea_casilla(5,-300,TipoCasilla::CARCEL)
    @casillas << Casilla.crea_calle(6,titulocalle4)
    #@casillas.at(6).titulo.casilla = @casillas.at(6)
    titulocalle5 = TituloPropiedad.new("Avenida de Madrid",900,90,18,150,250)
    @casillas << Casilla.crea_casilla(7,100,TipoCasilla::SORPRESA)
    @casillas << Casilla.crea_calle(8,titulocalle5)
    #@casillas.at(8).titulo.casilla = @casillas.at(8)
    titulocalle6 = TituloPropiedad.new("Camino de Ronda",1000,100,20,150,250)
    @casillas << Casilla.crea_calle(9,titulocalle6)
    #@casillas.at(9).titulo.casilla = @casillas.at(9)
    @casillas << Casilla.crea_casilla(10,-100,TipoCasilla::PARKING)
    titulocalle7 = TituloPropiedad.new("Calle Pedro Antonio de Alarcon",830,80,16,150,250)
    @casillas << Casilla.crea_calle(11,titulocalle7)
    #@casillas.at(11).titulo.casilla = @casillas.at(11)
    titulocalle8 = TituloPropiedad.new("Calle Recogidas",780,80,16,150,250)
    @casillas << Casilla.crea_calle(12,titulocalle8)
    #@casillas.at(12).titulo.casilla = @casillas.at(12)
    titulocalle9 = TituloPropiedad.new("Avenida de Andalucia",620,60,12,150,250)
    @casillas << Casilla.crea_calle(13,titulocalle9)
    #@casillas.at(13).titulo.casilla = @casillas.at(13)
    @casillas << Casilla.crea_casilla(14,200,TipoCasilla::SORPRESA)
    @casillas << Casilla.crea_casilla(15,0,TipoCasilla::JUEZ)
    titulocalle10 = TituloPropiedad.new("Avenida Juan Pablo II",550,50,11,150,250)
    @casillas << Casilla.crea_calle(16,titulocalle10)
    #@casillas.at(16).titulo.casilla = @casillas.at(16)
    titulocalle11 = TituloPropiedad.new("Calle Curro Cuchares",950,95,19,150,250)
    @casillas << Casilla.crea_calle(17,titulocalle11)
    #@casillas.at(17).titulo.casilla = @casillas.at(17)
    @casillas << Casilla.crea_casilla(18,-300,TipoCasilla::IMPUESTO)
    titulocalle12 = TituloPropiedad.new("Calle Elvira",870,90,19,150,250)
    @casillas << Casilla.crea_calle(19,titulocalle12)
    #@casillas.at(19).titulo.casilla = @casillas.at(19)
    
    @carcel = @casillas.at(5)
    
  end
  
  public
  
  def es_casilla_carcel
    raise NotImplementedError 
  end
  
  def obtener_casilla_final(casilla, desplazamiento)
    raise NotImplementedError 
  end
  
  def obtener_casilla_numero(numero_casilla)
    raise NotImplementedError 
  end
  
  def to_s
    
    @casillas.each do |i|
      puts i
    end
    
  end
  
  
end

end