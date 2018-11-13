# coding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "singleton"
#require_relative "sorpresa"
#require_relative "tipo_sorpresa"
#require_relative "tablero"
#require_relative "dado"
#require_relative "jugador"
#require_relative "estado_juego"

module ModeloQytetet

class Qytetet
  
  include Singleton
  
  @@NUMSORPRESAS = 10
  @@PRECIOLIBERTAD = 200
  @@SALDOSALIDA = 1000
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
    
    debo_pagar = @jugador_actual.debo_pagar_alquiler
    
    if (debo_pagar)
      @jugador_actual.pagar_alquiler
      if (@jugador_actual.saldo <= 0)
        @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
      end
    end
    
    casilla = obtener_casilla_jugador_actual
    
    tengo_propietario = casilla.tengo_propietario
    
    if (@estdo_juego != EstadoJuego::ALGUNJUGADORENBANCARROTA)
      if (tengo_propietario)
        @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
      else
        @estado_juego = EstadoJuego::JA_PUEDECOMPRARGESTIONAR
      end
    end
    
  end
  
  def actuar_si_en_casilla_no_edificable
    
    @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
    
    casilla_actual = @jugador_actual.casilla_actual
    
    if (casilla_actual.tipo == TipoCasilla::IMPUESTO)
      @jugador_actual.pagar_impuesto
    elsif (casilla_actual.tipo == TipoCasilla::JUEZ)
      encarcelar_jugador
    elsif (casilla_actual.tipo == TipoCasilla::SORPRESA)
      @carta_actual = @mazo.shift()
      @estado_juego = EstadoJuego::JA_CONSORPRESA
    end
    
  end
  
  def aplicar_sorpresa
    
    @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
    
    if (@carta_actual.tipo == TipoSorpresa::SALIRCARCEL)
      @jugador_actual.carta_libertad = @carta_actual
    else
      @mazo << @carta_actual
      if (@carta_actual.tipo == TipoSorpresa::PAGARCOBRAR)
        @jugador_actual.modificar_saldo(@carta_actual.valor)
        if (@jugador_actual.saldo < 0)
          @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
        end
      elsif (@carta_actual.tipo == TipoSorpresa::IRACASILLA)
        valor = @carta_actual.valor
        casilla_carcel = @tablero.es_casilla_carcel(valor)
        if (casilla_carcel)
          encarcelar_jugador
        else
          mover(valor)
        end
      elsif (@carta_actual.tipo == TipoSorpresa::PORCASAHOTEL)
        cantidad = @carta_actual.valor
        numero_total = @jugador_actual.cuantas_casas_hoteles_tengo
        @jugador_actual.modificar_saldo(cantidad * numero_total)
        if (@jugador_actual.saldo < 0)
          @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
        end
      elsif (@carta_actual.tipo == TipoSorpresa::PORJUGADOR)
        @jugadores.each do |i|
          jugador = i
          if (jugador != @jugador_actual)
            jugador.modificar_saldo(@carta_actual.valor)
          end
          if (jugador.saldo < 0)
            @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
          end
          if (@jugador_actual.saldo < 0)
            @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
          end
        end
      end
    end
  end
  
  def cancelar_hipoteca(numero_casilla)
    
    cancelar = false;
        
    titulo = @tablero.casillas.at(numero_casilla).titulo
        
    cancelar = @jugador_actual.cancelar_hipoteca(titulo);
        
    @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR;
    
    cancelar

  end
  
  def comprar_titulo_propiedad
    
    comprado = @jugador_actual.comprar_titulo_propiedad
    
    if (comprado)
      @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
    end
    
    comprado
    
  end
  
  def edificar_casa(numero_casilla)
    
    edificada = false
    
    casilla = @tablero.obtener_casilla_numero(numero_casilla)
    
    titulo = casilla.titulo
    
    edificada = @jugador_actual.edificar_casa(titulo)
    
    if (edificada)
      @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
    end
    
    edificada
    
  end
  
  def edificar_hotel(numero_casilla)
    
    edificada = false
    
    casilla = @tablero.obtener_casilla_numero(numero_casilla)
    
    titulo = casilla.titulo
    
    edificada = @jugador_actual.edificar_hotel(titulo)
    
    if (edificada)
      @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
    end
    
    edificada
    
  end
  
  def get_valor_dado
    @dado.valor 
  end
  
  def hipotecar_propiedad(numero_casilla)
    
    casilla = @tablero.obtener_casilla_numero(numero_casilla)
    
    titulo = casilla.titulo
    
    @jugador_actual.hipotecar_propiedad(titulo)
    
    @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
    
  end
  
  def inicializar_juego(nombres)
    
    inicializar_jugadores(nombres)
    inicializar_tablero
    inicializar_cartas_sorpresa
    salida_jugadores
    
  end
  
  def intenta_salir_carcel(metodo)
    
    libre = false
    
    if (metodo == MetodoSalirCarcel::TIRANDODADO)
      resultado = tirar_dado
      
      if (resultado >= 5)
        @jugador_actual.encarcelado = false
      end
      
    elsif (metodo == MetodoSalirCarcel::PAGANDOLIBERTAD)
      @jugador_actual.pagar_libertad(@@PRECIOLIBERTAD)
    end
    
    libre = @jugador_actual.encarcelado
    
    if (libre)
      @estado_juego = EstadoJuego::JA_ENCARCELADO
    else
      @estado_juego = EstadoJuego::JA_PREPARADO
    end
    
    libre
    
  end
  
  def jugar
    
    tirada = tirar_dado
    
    casilla = @tablero.obtener_casilla_final(@jugador_actual.casilla_actual, tirada)
    
    mover(casilla.numero_casilla)
    
  end
  
  def mover(num_casilla_destino)
    
    casilla_inicial = @jugador_actual.casilla_actual
    
    casilla_final = @tablero.obtener_casilla_final(casilla_inicial, num_casilla_destino)
    
    @jugador_actual.casilla_actual = casilla_final
    
    if (num_casilla_destino < casilla_inicial.numero_casilla)
      @jugador_actual.modificar_saldo(@@SALDOSALIDA)
    end
    
    if (casilla_final.soy_edificable)
      actuar_si_en_casilla_edificable
    else
      actuar_si_en_casilla_no_edificable
    end
    
  end
  
  def obtener_casilla_jugador_actual
    
    @jugador_actual.casilla_actual
    
  end
  
  def obtener_casillas_tablero
    
    @tablero
    
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
    
    jugadores = @jugadores.sort
    
    jugadores.each do |i|
      puts i.to_s
    end
    
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
    
    casilla = @tablero.obtener_casilla_numero(numero_casilla)
    
    @jugador_actual.vender_propiedad(casilla)
    
    @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
    
  end
  
  def tirar_dado
    
    int tirada = @dado.tirar
    
    tirada
    
  end
  
  private
  
  def encarcelar_jugador
    
    if (!@jugador_actual.tengo_carta_libertad)
      casilla_carcel = @tablero.carcel
      @jugador_actual.ir_a_carcel(casilla_carcel)
      @estado_juego = EstadoJuego::JA_ENCARCELADO
    else
      carta = @jugador_actual.devolver_carta_libertad
      @mazo << carta
      @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
    end
    
  end
  
  def inicializar_cartas_sorpresa
    
    @mazo << Sorpresa.new("Te hemos pillado con chanclas y calcetines, ¡lo sentimos, debes ir a la carcel!", @tablero.carcel.numero_casilla, TipoSorpresa::IRACASILLA)

    #2 cartas de IRACASILLA, cuyo valor es el número de la casilla a dónde vas.
      
    @mazo << Sorpresa.new("Avance hasta la casilla X.", 8, TipoSorpresa::IRACASILLA)
    @mazo << Sorpresa.new("Avance hasta la casilla Y", 4, TipoSorpresa::IRACASILLA)
        
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
    
    @mazo = @mazo.shuffle
    
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