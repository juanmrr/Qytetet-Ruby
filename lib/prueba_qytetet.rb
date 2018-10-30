# coding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "qytetet"
require_relative "sorpresa"
require_relative "tipo_sorpresa"

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
      puts i
    end
    
    @@juego.mazo.each do |i|
      puts i
    end

    aux = mayor_que_cero
    
    aux.each do |i|
      puts i
    end

    aux = ir_a_casilla
    
    aux.each do |i|
      puts i
    end

    tipos = TipoSorpresa.constants

    tipos.each do |i|
      aux = tipos(TipoSorpresa.const_get(i))
        aux.each do |i|
          puts i
        end
    end
    
    aux = @@juego.tablero.casillas
    
    aux.each do |i|
      puts i
    end
    
  end
  
end

PruebaQytetet.main

end