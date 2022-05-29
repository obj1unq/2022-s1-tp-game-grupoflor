import wollok.game.*
import frog.*
import vehiculos.*

class Nenufar{
	const property image = 'nenufar.png'
	var property position = game.at(8,6)
	
	method teEncontro(personaje) {
		game.schedule(3000, {self.desaparecer()})
	}
	
	method desaparecer(){
		game.removeVisual(self)
		generadorNenufares.removerFlotante(self)
	}
	
	method moverse() {
		if(not self.puedeMover()){
			position = position.left(1)
		}
		else{	
			self.desaparecer()
		}
	}
	
	method puedeMover(){
		return  self.position() == game.at(0,6)
		 
	}
	
}

object generadorFlotantes {

	method generarFlotante(constructor) {
		const flotante = self.construirFlotante(constructor)
		constructor.agregarFlotante(flotante)
		game.addVisual(flotante)
	}

	method construirFlotante(constructor) {
		return constructor.construirFlotante()
	}
	
}

object generadorNenufares {
	const property flotantesGenerador = []
	
	method construirFlotante() {
		return new Nenufar()
	}
	
	method agregarFlotante(flotante){
		flotantesGenerador.add(flotante)
	}
	
	method moverFlotantes() {
		flotantesGenerador.forEach({flotante => flotante.moverse()})
	}
	
	method removerFlotante(flotante){
		flotantesGenerador.remove(flotante)
	}
}

/*
object generadorNenufares{
	const property nenufaresGenerados = []
	
	
	method construirNenufar() {
		const nenufarActual = new Nenufar()
		nenufaresGenerados.add(nenufarActual)
		game.addVisual(nenufarActual)
	}
	
	method agregarNenufar(vehiculo){
		vehiculosGenerados.add(vehiculo)
	}
	
	method moverNenufares() {
		nenufaresGenerados.forEach({nenufar => nenufar.moverse()})
	}
	
	method removerVehiculo(vehiculo){
		vehiculosGenerados.remove(vehiculo)
	}
}
*/
