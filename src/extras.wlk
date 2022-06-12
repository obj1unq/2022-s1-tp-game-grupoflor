import wollok.game.*
import frog.*
import vehiculos.*
import randomizer.*

class Flotante{
	const property image
	var property position 
}

class Nenufar inherits Flotante{

	method teEncontro(personaje) {
		game.schedule(3000, {self.desaparecer()})
	}
	
	method desaparecer(){
		game.removeVisual(self)
		generadorNenufares.removerNenufar(self)
	}
	
}

object generadorNenufares {
	
	const property nenufaresGeneradosSur = []
	const property nenufaresGeneradosNorte = []
	
	method generarNenufares(){
		self.generarNenufarSur()
		self.generarNenufarNorte()
	}
	
	method generarNenufarSur() {
		if(nenufaresGeneradosSur.size() < 3){
			const nenufar = self.construirNenufarSur()
			nenufaresGeneradosSur.add(nenufar)
			game.addVisual(nenufar)
		}
	}
	
	method generarNenufarNorte() {
		if(nenufaresGeneradosNorte.size() < 3){
			const nenufar = self.construirNenufarNorte()
			nenufaresGeneradosNorte.add(nenufar)
			game.addVisual(nenufar)
		}
	}

	method construirNenufarSur() {
			return new Nenufar(image = 'nenufar.png', position = randomizer.emptyPosition(6))
	}
	
	method construirNenufarNorte() {
			return new Nenufar(image = 'nenufar.png', position = randomizer.emptyPosition(8))
	}
	
	method removerNenufar(nenufar){
		if (nenufaresGeneradosSur.contains(nenufar)){
			nenufaresGeneradosSur.remove(nenufar)
		}
		else nenufaresGeneradosNorte.remove(nenufar)
	}
}


object ovni{
	const property image = 'ovni.png'
	const objetivo = frog
	var property position = game.at(11, 0)
		
	method teEncontro(frog){
		frog.colisionado()
		game.removeVisual(self)
	}
	
	method moverse(){
		
		var otroPosicion = frog.position()
		var newX = position.x() + if (otroPosicion.x() > position.x()) 1 else -1
		var newY = position.y() + if (otroPosicion.y() > position.y()) 1 else 0
		if (self.position() != otroPosicion){
			newX = newX.max(0).min(game.width() - 1)
			newY = newY.max(0).min(game.height() - 1)
			position = game.at(newX, newY)
		}
		else self.teEncontro(frog)
		
	}
}

object anunciador{
	var property position = game.at(-1, -1)
	const property image = 'car1.png'
}
















//class Tronco inherits Flotante{
//	method puedeMover(){
//		return  self.position() == game.at(10,7)
//	}
//	
//	method moverseEste() {
//		if(not self.puedeMover()){
//			position = position.left(1)
//		}
//		else{
//			generadorTroncos.removerTronco(self)
//			game.removeVisual(self)
//		}
//	}
//}
//
//object generadorTroncos(){
//	
//}

/* 
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
*/

/*
object generadorNenufare {
	const property nenufaresGenerados = []
	
	method construirFlotante() {
			return new Nenufar(image = 'nenufar.png', position = randomizer.emptyPosition(6))
	}
	
	method agregarFlotante(flotante){
		flotantesGenerador.add(flotante)
	}
	
	method moverFlotantes() {
		flotantesGenerador.forEach({flotante => flotante.moverse()})
	}
	
}
 */