import wollok.game.*
import frog.*
import vehiculos.*
import randomizer.*

class Flotante{
	const property image
	var property position
	
	method mismaPosicion(posicion){
		return position == posicion
	}
}


object generadorTroncos{
	
	const property troncosGenerados = []
	
	
	method construirTronco(posicionInicialTronco){
		const posicionInicial = posicionInicialTronco
		const tronco1 = new Tronco(image = 'trunk' + 3 + '.png', position = posicionInicial)
		const tronco2 = new Tronco(image = 'trunk' + 2 + '.png', position = posicionInicial.left(1))
		const tronco3 = new Tronco(image = 'trunk' + 1 + '.png', position = posicionInicial.left(2))
		troncosGenerados.add(tronco1)
		troncosGenerados.add(tronco2)
		troncosGenerados.add(tronco3)
		game.addVisual(tronco1)
		game.addVisual(tronco2)
		game.addVisual(tronco3)
	}
	
	
	method moverTroncos(){
		troncosGenerados.forEach({tronco => tronco.moverse()})
	}
	
	method removerTronco(tronco){
		troncosGenerados.remove(tronco)
	}
	
	method estaEnTronco(posicion){
		return troncosGenerados.any({tronco => tronco.mismaPosicion(posicion)})
	}
}


class Tronco inherits Flotante{
	
	
	method moverse() {
		
		if(not self.puedeMover()){
			position = position.right(1)
		}
		else{
			generadorTroncos.removerTronco(self)
		}
		
	}

	method puedeMover(){
		return  self.position() == game.at(9,7) or self.position() == game.at(9,9)
	}
	
	method teEncontro(frog){
		
	}
	
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
		ovni.reiniciarObjeto()
		frog.reiniciarObjeto()
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
	
	method estaEnNenufar(posicion){
		return nenufaresGeneradosSur.any({nenufar => nenufar.mismaPosicion(posicion)})
			   or
			   nenufaresGeneradosNorte.any({nenufar => nenufar.mismaPosicion(posicion)})
		
	}
}


object ovni{
	const property image = 'ovni.png'
	const objetivo = frog
	var property position = game.at(0, 0)
		
	method teEncontro(personaje){
		if (personaje.cantidadLlegadas() > 1){
		personaje.colisionado()
		position = game.at(0, 0)
		}
		else game.say(self, 'Me estoy preparando')
	}
	
	method moverse(){
		if (objetivo.cantidadLlegadas() > 1){
			var otroPosicion = objetivo.position()
			var newX = position.x() + if (otroPosicion.x() > position.x()) 1 else -1
			var newY = position.y() + if (otroPosicion.y() > position.y()) 1 else 0
			if (self.position() != otroPosicion){
			newX = newX.max(0).min(game.width() - 1)
			newY = newY.max(0).min(game.height() - 1)
			position = game.at(newX, newY)
		}
		else self.teEncontro(objetivo)
		}
	}
	
	 method reiniciarObjeto(){
    	game.removeVisual(self)
    	game.addVisual(self)
    }
}

object anunciador{
	var property position = game.at(0, -1)
	const property image = 'car1.png'
	
	method decirPuntajeYVidas(rana){
		 game.say(self, "Te quedan " + rana.vidas() + ' vidas y ' + rana.puntaje() + ' puntos') 
	}
	
	method cantidadLlegadas(rana){
		game.say(self, 'Te quedan ' + self.cantidadADecir(rana) + ' llegadas')
	}
	
	method cantidadADecir(rana){
		return 2 - rana.cantidadLlegadas()
	}
}

object agua{
	
	method estaEnAgua(rana){
		return rana.x().between(0, game.width() - 1) and rana.y().between(6,9)
	}
	
}


object generadorFrutas{
	const property frutasGeneradas = []
	
	method generarFruta(){
		if(frutasGeneradas.size() < 2){
			const fruta = self.construirFruta()
			frutasGeneradas.add(fruta)
			game.addVisual(fruta)
		}
	}
	
	method construirFruta(){
		return new Fruta(position =  randomizer.emptyPosition())
	}
	
	method removerFruta(fruta){
		frutasGeneradas.remove(fruta)
	}
}

class Fruta{
	var property image = 'fruta.png'
	var property position
	
	method teEncontro(frog){
		frog.agregarPuntaje(25)
		generadorFrutas.removerFruta(self)
		game.removeVisual(self)
		anunciador.decirPuntajeYVidas(frog)
	}
}

object generadorAlcantarillas{
	method generarAlcantarillas(){
		const alcantarilla1 = new Alcantarilla(position = game.at(8,0))
		const alcantarilla2 = new Alcantarilla(position = randomizer.emptyPosition())
		game.addVisual(alcantarilla1)
		game.addVisual(alcantarilla2)
	}
}

class Alcantarilla{
	const property position
	const property image = 'alcantarilla.png'
	
	method teEncontro(frog){
		frog.volverInicio()
		game.say(frog, 'uh me resbalé :(')
	}
}

object generadorMeta {
	method generarMeta(){
		const meta1 = new Meta(position = game.at(1, 10))
		const meta2 = new Meta(position = game.at(4, 10))
		const meta3 = new Meta(position = game.at(7, 10))
		game.addVisual(meta1)
		game.addVisual(meta2)
		game.addVisual(meta3)
	}
}

class Meta{
	const property image = 'grass.png'
	var property position
	var ocupada = false
	
	method teEncontro(frog){
		self.validarLlegada()
		if (frog.cantidadLlegadas() < 2){
			anunciador.cantidadLlegadas(frog)
		}
		frog.sumarLlegada()
		ocupada = true
	}
	
	method validarLlegada(){
		if(ocupada){
			self.error('La meta está ocupada')
		}
	}
}