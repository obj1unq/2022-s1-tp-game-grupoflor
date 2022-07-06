import wollok.game.*
import frog.*
import vehiculos.*
import extras.*

object presentacion { 
	
	method iniciar(){

		game.addVisual(pantallaCarga)
		config.configurarTeclas()

	}
}

object pantallaCarga{
	
	const property image = "froggerfachero.jpg"
	const property position = game.origin()
	
}



object juego {
	method iniciar(){
	
	reproductor.iniciarMusica()
	
	game.removeVisual(pantallaCarga)
	generadorAlcantarillas.generarAlcantarillas()
	generadorMeta.generarMeta()
	
//	game.onTick(2500, 'auto', {generadorVehiculos.generarVehiculos()})
	
	game.onTick(5000, 'auto', {generadorVehiculos.generarVehiculo(generadorAutos)})
	game.onTick(4000, 'autoCarrera', {generadorVehiculos.generarVehiculo(generadorAutosCarreras)})
//	game.onTick(8000, 'tanque', {generadorVehiculos.generarVehiculo(generadorAutoMilitares)})
	game.onTick(3800, 'moto', {generadorVehiculos.generarVehiculo(generadorMotos)})

   
	game.onTick(1500, 'auto', {generadorAutos.moverVehiculos()})
	game.onTick(1000, 'autoCarrera', {generadorAutosCarreras.moverVehiculos()})
//	game.onTick(4000, 'Tanque', {generadorAutoMilitares.moverVehiculos()})
	game.onTick(500, 'Moto', {generadorMotos.moverVehiculos()})
	
	game.onTick(3000, 'disparar', {tanque.disparar()})
	game.onTick(1000, 'bala', {generadorBalas.moverBalas()})
	
	game.onTick(1000, 'ovni', {ovni.moverse()})
	
	game.onTick(2500, 'nenufar', {generadorNenufares.generarNenufares()})

	
//	game.onTick(8000, 'generarTroncos', {generadorTroncos.generarTroncos()})
	game.onTick(8000, 'generarTroncosSur', {generadorTroncos.construirTronco(game.at(0,7))})
	game.onTick(10000, 'generarTroncosNorte', {generadorTroncos.construirTronco(game.at(0,9))})
	game.onTick(1000, 'moverTroncos', {generadorTroncos.moverTroncos()})
	
	
	game.onTick(2000, 'frutas', {generadorFrutas.generarFruta()})
	
	game.onTick(500, 'posicion', {frog.validarPosicion()})
	
	game.addVisual(ovni)
	game.addVisual(anunciador)
	game.addVisual(tanque)
	game.addVisual(frog)
	
	game.onCollideDo(frog, { algo => algo.teEncontro(frog) } )
	
	frog.liberarMovimiento()
	
	}
}

object config {
	
	method configurarTeclas(){
		keyboard.left().onPressDo( { frog.mover(izquierda) } )
		keyboard.right().onPressDo( { frog.mover(derecha) } )
		keyboard.up().onPressDo( { frog.mover(arriba) } )
		keyboard.down().onPressDo( { frog.mover(abajo) } )
		keyboard.v().onPressDo( { anunciador.decirPuntajeYVidas(frog) } )
		keyboard.space().onPressDo( { frog.saltar() } )
		keyboard.enter().onPressDo( {juego.iniciar()} )
	}

}

object reproductor {
	method iniciarMusica(){
		const musica = game.sound("musicafrog.mp3")
		musica.shouldLoop(true)
		keyboard.w().onPressDo({musica.volume(1)})
		keyboard.s().onPressDo({musica.volume(0.5)})
		keyboard.m().onPressDo({musica.volume(0)})78
		game.schedule(500, { musica.play()} )
	}
}