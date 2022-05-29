import wollok.game.*
import frog.*
import extras.*

class Auto {

	const property image = 'car1.png'
	var property position = game.at(9, 1)

	method moverse() {
		if(not self.puedeMover()){
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
	method puedeMover(){
		return  self.position() == game.at(0,1)
		 
	}

}

class AutoCarrera {

	const property image = 'car2.png'
	var property position = game.at(0, 2)

	method moverse() {
		
		if(not self.puedeMover()){
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
	
	method puedeMover(){
		return  self.position() == game.at(9,2)
		
	}
	
}

class AutoMilitar {
	
	const property image = 'car3.png'
	var property position = game.at(8,3)
	
	method moverse() {
		if(not self.puedeMover()){
			position = position.left(1)
		}
		else{
			generadorAutoMilitares.removerVehiculo(self)
			game.removeVisual(self)
		}
	}

	method teEncontro(personaje) {
		personaje.perder()
	}
	
	method puedeMover(){
		return  self.position() == game.at(0,3)		 
	}
}

class Moto {

	const property image = 'colgando.png'
	var property position = game.at(0, 4)

	method moverse() {
		
		if(not self.puedeMover()){
			position = position.right(1)
		}
		else{
			generadorMotos.removerVehiculo(self)
			game.removeVisual(self)
		}
		
	}

	method teEncontro(personaje) {
		personaje.perder()
	}
	
	method puedeMover(){
		return  self.position() == game.at(9,4)
		
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

object generadorAutoMilitares{
	const property vehiculosGenerados = []
	
	method construirVehiculo() {
		return new AutoMilitar()
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

object generadorMotos{
	const property vehiculosGenerados = []
	
	method construirVehiculo() {
		return new Moto()
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
