import wollok.game.*
import frog.*

class Auto {

	const property image = 'car1.png'
	var property position = game.at(9, 1)

	method moverse() {
		if(not self.verificarMoverse()){
			position = position.left(1)
		}
		else{
			generadorAutos.removerVehiculo(self)
			game.removeVisual(self)
		}
	}

	method teEncontro(personaje) {
		personaje.perder()
	}
	method verificarMoverse(){
		return  self.position() == game.at(0,1)
		
	}

}

class AutoCarrera {

	const property image = 'car2.png'
	var property position = game.at(0, 2)

	method moverse() {
		
		if(not self.verificarMoverse()){
			position = position.right(1)
		}
		else{
			generadorAutosCarreras.removerVehiculo(self)
			game.removeVisual(self)
		}
		
	}

	method teEncontro(personaje) {
		personaje.perder()
	}
	
	method verificarMoverse(){
		return  self.position() == game.at(9,2)
		
	}
	
	

}

object generadorVehiculos {

	method generarVehiculo(constructor) {
		const vehiculo = self.construirVehiculo(constructor)
		constructor.agregarVehiculo(vehiculo)
		game.addVisual(vehiculo)
	}

	method construirVehiculo(constructor) {
		return constructor.construirVehiculo()
	}
	
	

}

object generadorAutos {
	const property vehiculosGenerados = []
	
	
	method construirVehiculo() {
		
		return new Auto()
		
	}
	
	method agregarVehiculo(vehiculo){
		vehiculosGenerados.add(vehiculo)
	}
	method moverVehiculos() {
		vehiculosGenerados.forEach({vehiculo => vehiculo.moverse()})
	}
	
	method removerVehiculo(vehiculo){
		vehiculosGenerados.remove(vehiculo)
	}
	
	
}

object generadorAutosCarreras {
	const property vehiculosGenerados = []
	
	method construirVehiculo() {
		return new AutoCarrera()
	}
	
	method agregarVehiculo(vehiculo){
		vehiculosGenerados.add(vehiculo)
	}
	method moverVehiculos() {
		vehiculosGenerados.forEach({vehiculo => vehiculo.moverse()})
	}
	method removerVehiculo(vehiculo){
		vehiculosGenerados.remove(vehiculo)
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
