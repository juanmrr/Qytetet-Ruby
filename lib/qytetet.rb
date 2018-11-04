# coding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "singleton"
require_relative "sorpresa"
require_relative "tipo_sorpresa"
require_relative "tablero"
require_relative "dado"
require_relative "jugador"
require_relative "estado_juego"

module ModeloQytetet

class Qytetet
  
  include Singleton
  
  @@NUMSORPRESAS = 10
  @@PRECIOSALIDA = 200
  @@SALDOSALIDA = 7500
  @@MAXJUGADORES = 4
  @@NUMCASILLAS = 20
  
  def initialize
    @mazo = Array.new
    @tablero = nil
    @carta_actual = nil
    @dado = Dado.instance
    @jugadores = Array.new
    @jugador_actual = nil
    @estado_juego = nil
  end
    
  private
  
  attr_writer :carta_actual, :estado_juego
  
  public
  
  attr_reader :mazo, :dado, :carta_actual, :jugadores, :jugador_actual, :tablero
  
  def actuar_si_en_casilla_edificable
    raise NotImplementedError 
  end
  
  def actual_si_en_casilla_no_edificable
    raise NotImplementedError 
  end
  
  def aplicar_sorpresa
    raise NotImplementedError 
  end
  
  def cancelar_hipoteca(numero_casilla)
    raise NotImplementedError 
  end
  
  def comprar_titulo_propiedad
    raise NotImplementedError 
  end
  
  def edificar_casa(numero_casilla)
    raise NotImplementedError 
  end
  
  def edificar_hotel(numero_casilla)
    raise NotImplementedError 
  end
  
  def get_valor_dado
    raise NotImplementedError 
  end
  
  def hipotecar_propiedad(numero_casilla)
    raise NotImplementedError 
  end
  
  def inicializar_juego(nombres)
    
    inicializar_jugadores(nombres)
    inicializar_tablero
    inicializar_cartas_sorpresa
    
  end
  
  def intenta_salir_carcel(metodo)
    raise NotImplementedError 
  end
  
  def jugar
    
    int tirada = tirar_dado
    
    casilla = @tablero.obtener_casilla_final(@jugador_actual.casilla_actual, tirada)
    
    mover(casilla.numero_casilla)
    
  end
  
  def mover(num_casilla_destino)
    
  end
  
  def obtener_casilla_jugador_actual
    raise NotImplementedError 
  end
  
  def obtener_casillas_tablero
    raise NotImplementedError 
  end
  
  def obtener_propiedades_jugador
    
    aux = Array.new
    
    prop = Array.new
    
    prop = @jugador_actual.propiedades
    
    @tablero.casillas.each do |i|
      if (prop.include?(i.titulo))
        aux << i.numero_casilla
      end
    end
    
    aux
    
  end
  
  def obtener_propiedades_jugador_segun_estado_hipoteca(estado_hipoteca)
    
    aux = Array.new
    
    prop = Array.new
    
    prop = @jugador_actual.obtener_propiedades(estado_hipoteca)
    
    @tablero.casillas.each do |i|
      if (prop.include?(i.titulo))
        aux << i.numero_casilla
      end
    end
    
    aux
    
  end
  
  def obtener_ranking
    
    @jugadores = @jugadores.sort
    
  end
  
  def obtener_saldo_jugador_actual
    
    @jugador_actual.saldo
    
  end
  
  def siguiente_jugador
    
    jugador = @jugadores.index(@jugador_actual)
    
    @jugador_actual = @jugadores.at((jugador +1) % @jugadores.length)
    
    if (@jugador_actual.encarcelado)
      @estado_juego = EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
    else
      @estado_juego = EstadoJuego::JA_PREPARADO
    end
    
  end
  
  def vender_propiedad(numero_casilla)
    raise NotImplementedError 
  end
  
  def tirar_dado
    
    int tirada = @dado.tirar
    
    tirada
    
  end
  
  def get_valor_dado
    
    @dado.valor
    
  end
  
  private
  
  def encarcelar_jugador
    raise NotImplementedError 
  end
  
  def inicializar_cartas_sorpresa
    
    @mazo << Sorpresa.new("Te hemos pillado con chanclas y calcetines, ¡lo sentimos, debes ir a la carcel!", @tablero.carcel.numero_casilla, TipoSorpresa::IRACASILLA)

    #2 cartas de IRACASILLA, cuyo valor es el número de la casilla a dónde vas.
      
    @mazo << Sorpresa.new("Avance hasta la casilla X.", 8, TipoSorpresa::IRACASILLA)
    @mazo << Sorpresa.new("Avance hasta la casilla Y", 18, TipoSorpresa::IRACASILLA)
        
    #2 cartas de PAGARCOBRAR, cuyo valor es la cantidad de dinero a pagar si es negativo o a cobrar si es positivo.
        
    @mazo << Sorpresa.new("Le ha tocado la loteria, reciba 300.", 300, TipoSorpresa::PAGARCOBRAR)
    @mazo << Sorpresa.new("Multa por exceso de velocidad, pague 175.", -175, TipoSorpresa::PAGARCOBRAR)
        
    #2 cartas PORCASAHOTEL, cuyo valor es la cantidad de dinero a pagar o recibir por cada casa y hotel.
        
    @mazo << Sorpresa.new("Cobre 100 por cada casa y por cada hotel.", 100, TipoSorpresa::PORCASAHOTEL)
    @mazo << Sorpresa.new("Pague 100 por cada casa y por cada hotel.", -100, TipoSorpresa::PORCASAHOTEL)
        
    #2 cartas PORJUGADOR, cuyo valor es la cantidad que se debe pagar o recibir del resto de jugadores.
        
    @mazo << Sorpresa.new("Cobre 100 de cada jugador", 100, TipoSorpresa::PORJUGADOR)
    @mazo << Sorpresa.new("Pague 100 a cada jugador", -100, TipoSorpresa::PORJUGADOR)
        
    #1 carta de SalirCarcel, con la que el jugador podrá salir de la cárcel y cuyo valor no es aplicable (0 por defecto).
        
    @mazo << Sorpresa.new("Salga de la carcel cuando quiera con esta carta.", 0, TipoSorpresa::SALIRCARCEL)
    
  end
  
  def inicializar_jugadores(nombres)
    
    nombres.each do |i|
      @jugadores << Jugador.new(i)
    end
    
  end
  
  def inicializar_tablero
    
    @tablero = Tablero.new
    
  end
  
  def salida_jugadores
    
    @jugadores.each do |i|
      i.casilla_actual = @tablero.casillas.at(0)
      @estado_juego = EstadoJuego::JA_PREPARADO
    end
    
    jugador = rand(@jugadores.length - 1)
    
    @jugador_actual = @jugadores.at(jugador)
    
  end
  
end

end