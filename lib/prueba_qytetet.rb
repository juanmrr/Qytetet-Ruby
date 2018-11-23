# coding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "qytetet"
require_relative "sorpresa"
require_relative "tipo_sorpresa"
require_relative "jugador"
require_relative "casilla"
require_relative "dado"
require_relative "estado_juego"
require_relative "metodo_salir_carcel"
require_relative "tipo_casilla"
require_relative "titulo_propiedad"
require_relative "tablero"

module ModeloQytetet

class PruebaQytetet

  @@juego = Qytetet.instance

  def self.mayor_que_cero
    
    aux = Array.new

    @@juego.mazo.each do |i|
      if (i.valor > 0) then
         aux << i
      end
    end
    
    aux
    
  end
  
  def self.tipos(tipo)
    
    aux = Array.new
    
    @@juego.mazo.each do |i|
      if (i.tipo == tipo) then
        aux << i
      end
    end
    
    aux
    
  end
  
  def self.ir_a_casilla
    
    aux = Array.new
    
    @@juego.mazo.each do |i|
      if (i.tipo == TipoSorpresa::IRACASILLA) then
        aux << i
      end
    end
    
    aux
    
  end
  
  def self.get_nombre_jugadores
    
    num_jug = 0
    
    cadena = String.new

    nombres = Array.new
    
    while (cadena != "2" && cadena != "3" && cadena != "4")
      puts "Introduzca el número de jugadores:"
      cadena = gets.chomp
    end
    
    num_jug = cadena.to_i

    for i in(1..num_jug)
      puts "Introduzca el nombre del jugador " + i.to_s + " :"
      cadena = gets.chomp
      nombres << cadena
    end
    
    nombres
    
  end
  
  def self.main
    
    nombres = get_nombre_jugadores

    @@juego.inicializar_juego(nombres)
    
    @@juego.jugadores.each do |i|
      puts i.to_s
    end
    
    @@juego.mover(2)
    
    @@juego.jugadores.each do |i|
      puts i.to_s
    end
    
    @@juego.comprar_titulo_propiedad
    
    @@juego.edificar_casa(2)
    
    @@juego.jugadores.each do |i|
      puts i.to_s
    end
    
    @@juego.siguiente_jugador
    
    @@juego.mover(18)
    
    @@juego.mover(4)
    
    @@juego.jugadores.each do |i|
      puts i.to_s
    end
    
    @@juego.siguiente_jugador
    
    @@juego.hipotecar_propiedad(2)
    
    @@juego.jugadores.each do |i|
      puts i.to_s
    end
    
    @@juego.cancelar_hipoteca(2)
    
    @@juego.jugadores.each do |i|
      puts i.to_s
    end
    
    @@juego.vender_propiedad(2)
    
    puts "Ranking\n"
    
    @@juego.obtener_ranking
    
    @@juego.jugadores.each do |i|
      puts i.to_s
    end
    
    @@juego.mover(2)
    
    @@juego.aplicar_sorpresa
    
    @@juego.jugadores.each do |i|
      puts i.to_s
    end
    
    @@juego.mover(1)
    
    #@@juego.intenta_salir_carcel(MetodoSalirCarcel::PAGANDOLIBERTAD)
    
    @@juego.jugadores.each do |i|
      puts i.to_s
    end
    
    @@juego.siguiente_jugador
    
    @@juego.mover(3)
    
    @@juego.jugadores.each do |i|
      puts i.to_s
    end
    
    @@juego.mover(10)
    
    @@juego.jugadores.each do |i|
      puts i.to_s
    end
    
  end
  
end

PruebaQytetet.main

end