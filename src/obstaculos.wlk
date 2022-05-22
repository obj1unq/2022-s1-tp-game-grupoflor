import wollok.game.*
import frog.*

class Auto {

	const property image = 'car1.png'
	var property position = game.at(9, 1)

	
	method moverse() {
		position = position.left(1)
	}
	
	method teEncontro(personaje){
		personaje.perder()
	}
}


object generadorVehiculos{
	
	const property vehiculosGenerados = []
	
	method generarVehiculo(){
		const auto = self.construirAuto()
		vehiculosGenerados.add(auto)
		game.addVisual(auto)
	}
	
	method construirAuto(){
		return new Auto()
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
