import wollok.game.*
import frog.*

class Auto {

	const property image = 'car1.png'
	var property position = game.at(9, 1)

	method moverse() {
		position = position.left(1)
	}

	method teEncontro(personaje) {
		personaje.perder()
	}

}

class AutoCarreras {

	const property image = 'car2.png'
	var property position = game.at(0, 2)

	method moverse() {
		position = position.right(1)
	}

	method teEncontro(personaje) {
		personaje.perder()
	}

}

object generadorVehiculos {

	const property vehiculosGenerados = []

	method generarVehiculo(constructor) {
		const vehiculo = self.construirVehiculo(constructor)
		constructor.agregarVehiculo(vehiculo)
		game.addVisual(vehiculo)
	}

	method construirVehiculo(constructor) {
		return constructor.construirVehiculo()
	}
	
	/*
	method construirAuto() {
		return new Auto()
	}
	*/

}

object generadorAutos {
	const property vehiculosGenerados = []
	
	method construirVehiculo() {
		return new Auto()
	}
	
	method agregarVehiculo(vehiculo){
		vehiculosGenerados.add(vehiculo)
	}
}

object generadorAutosCarreras {
	const property vehiculosGenerados = []
	
	method construirVehiculo() {
		return new AutoCarreras()
	}
	
	method agregarVehiculo(vehiculo){
		vehiculosGenerados.add(vehiculo)
	}
}

/* 
 * 
 * class Vehiculo{
 * 	
 * 	method image(vehiculo) {
 * 		return ''vehiculo" + '.jpg''
 * 	}
 * 	
 * }
 *  
 */
