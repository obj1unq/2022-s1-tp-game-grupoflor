import wollok.game.*
import frog.*
import vehiculos.*
import randomizer.*

class Flotante{
	const property image
	var property position 
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
	
//	method moverseIzquierda() {
//		
//		if(not self.puedeMover()){
//			position = position.left(1)
//		}
//		else{
//			generadorTroncos.removerTroncoNorte(self)
//			game.removeVisual(self)
//		}
//		
//	}

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
		self.reiniciarObjeto(ovni)
		self.reiniciarObjeto(frog)
	}
	
	method reiniciarObjeto(objeto){
		game.removeVisual(objeto)
		game.addVisual(objeto)
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
	var property position = game.at(0, 0)
		
	method teEncontro(frog){
		frog.colisionado()
		position = game.at(0, 0)
	}
	
	method moverse(){
		if (frog.cantidadLlegadas() > 1){
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
}

object anunciador{
	var property position = game.at(-1, -1)
	const property image = 'car1.png'
	
	method decirPuntajeYVidas(rana){
		 game.say(self, "Te quedan " + rana.vidas() + ' vidas y ' + rana.puntaje() + ' puntos') 
	}
	
	method cantidadLlegadas(rana){
		game.say(self, 'Te quedan ' + self.cantidadADecir(rana) + ' llegadas')
	}
	
	method cantidadADecir(rana){
		return 3 - rana.cantidadLlegadas()
	}
}



class Agua{
	const image = 'agua.png'
	var property position
	
	method teEncontro(frog){
		frog.colisionado()
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
//		const alcantarilla3 = new Alcantarilla(position = randomizer.emptyPosition())
		game.addVisual(alcantarilla1)
		game.addVisual(alcantarilla2)
//		game.addVisual(alcantarilla3)
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
		frog.sumarLlegada()
		anunciador.cantidadLlegadas(frog)
		ocupada = true
	}
	
	method validarLlegada(){
		if(ocupada){
			self.error('La meta está ocupada')
		}
	}
}

//object generadorNenufares {
//	
//	const property nenufaresGeneradosSur = []
//	const property nenufaresGeneradosNorte = []
//	
//	method generarNenufares(){
//		self.generarNenufarSur()
//		self.generarNenufarNorte()
//	}
//	
//	method generarNenufarSur() {
//		if(nenufaresGeneradosSur.size() < 3){
//			const nenufar = self.construirNenufarSur()
//			nenufaresGeneradosSur.add(nenufar)
//			game.addVisual(nenufar)
//		}
//	}
//	
//	method generarNenufarNorte() {
//		if(nenufaresGeneradosNorte.size() < 3){
//			const nenufar = self.construirNenufarNorte()
//			nenufaresGeneradosNorte.add(nenufar)
//			game.addVisual(nenufar)
//		}
//	}
//
//	method construirNenufarSur() {
//			return new Nenufar(image = 'nenufar.png', position = randomizer.emptyPosition(6))
//	}
//	
//	method construirNenufarNorte() {
//			return new Nenufar(image = 'nenufar.png', position = randomizer.emptyPosition(8))
//	}
//	
//	method removerNenufar(nenufar){
//		if (nenufaresGeneradosSur.contains(nenufar)){
//			nenufaresGeneradosSur.remove(nenufar)
//		}
//		else nenufaresGeneradosNorte.remove(nenufar)
//	}
//}


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