import wollok.game.*
import frog.*
import extras.*

class Vehiculo{
	var property position
	
	var property image
	
	method moverse() 
	
	method puedeMover()
	
	method teEncontro(personaje) {
		personaje.colisionado()
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

class GeneradorVehiculo{
	const property vehiculosGenerados = []
	
	method agregarVehiculo(vehiculo){
		vehiculosGenerados.add(vehiculo)
	}
	
	method moverVehiculos() {
		vehiculosGenerados.forEach({vehiculo => vehiculo.moverse()})
	}
	
	method removerVehiculo(vehiculo){
		vehiculosGenerados.remove(vehiculo)
	}
	
	method construirVehiculo()
	
}

object generadorAutos inherits GeneradorVehiculo{
	
	override method construirVehiculo() {	
		return new AutoParticular(image = 'car1.png', position = game.at(9, 1))	
	}
	
}


object generadorAutosCarreras inherits GeneradorVehiculo{
	
	override method construirVehiculo() {
		return new AutoCarrera(image = 'car2.png', position = game.at(0, 2))
	}
	
}


object generadorMotos inherits GeneradorVehiculo{
	
	override method construirVehiculo() {
		return new Moto(image = 'moto.png', position = game.at(0, 4))
	}

}


object tanque{
	var property image = 'tanque.png'
	var property position = game.at(8,3)
	
	method disparar(){
		const bala = generadorBalas.construirBala(self.position())
		game.addVisual(bala)		
	}
	
	method teEncontro(personaje) {
		personaje.colisionado()
	}
}

class Bala{
	var property image = 'bala.png'
	var property position
	
	method moverse(){
		if(not self.puedeMover()){
			position = position.left(1)
		}
		else{
			generadorBalas.removerBala(self)
			game.removeVisual(self)
		}
	}
	
	method puedeMover(){
		return  self.position() == game.at(0,3)		 
	}
	
	method teEncontro(personaje){
		personaje.colisionado()
	
	}
}


object generadorBalas{
	const balasDisparadas = []
	
	method removerBala(bala){
		balasDisparadas.remove(bala)
	}
	
	
	method agregarBala(bala){
		balasDisparadas.add(bala)
	}
	
	method moverBalas() {
		balasDisparadas.forEach({bala => bala.moverse()})
	}
	
	method construirBala(posicionVehiculo){
		const bala = new Bala(position = game.at(posicionVehiculo.x() - 1, posicionVehiculo.y()))
		balasDisparadas.add(bala)
		return bala

	}
}

