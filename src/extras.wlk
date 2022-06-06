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