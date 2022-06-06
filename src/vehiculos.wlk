import wollok.game.*
import frog.*
import extras.*

class Vehiculo{
	var property position
	
	var property image
	
	method moverse() 
	
	method puedeMover()
	
	method teEncontro(personaje) {
		personaje.perder()
	}
}


class AutoParticular inherits Vehiculo{
	
	override method puedeMover(){
		return  self.position() == game.at(0,1)
	}
	
	override method moverse() {
		if(not self.puedeMover()){
			position = position.left(1)
		}
		else{
			generadorAutos.removerVehiculo(self)
			game.removeVisual(self)
		}
	}
	

}

class AutoCarrera inherits Vehiculo{

	override method moverse() {
		
		if(not self.puedeMover()){
			position = position.right(1)
		}
		else{
			generadorAutosCarreras.removerVehiculo(self)
			game.removeVisual(self)
		}
		
	}
	
	override method puedeMover(){
		return  self.position() == game.at(9,2)
	}
	
}

class AutoMilitar inherits Vehiculo{
	
	override method moverse() {
		if(not self.puedeMover()){
			position = position.left(1)
		}
		else{
			generadorAutoMilitares.removerVehiculo(self)
			game.removeVisual(self)
		}
	}

	override method puedeMover(){
		return  self.position() == game.at(0,3)		 
	}
}

class Moto inherits Vehiculo{

	override method moverse() {
		
		if(not self.puedeMover()){
			position = position.right(1)
		}
		else{
			generadorMotos.removerVehiculo(self)
			game.removeVisual(self)
		}
		
	}

	override method puedeMover(){
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
		
		return new AutoParticular(image = 'car1.png', position = game.at(9, 1))
		
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
		return new AutoCarrera(image = 'car2.png', position = game.at(0, 2))
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
		return new AutoMilitar(image = 'car3.png', position = game.at(8,3))
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
		return new Moto(image = 'moto.png', position = game.at(0, 4))
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
