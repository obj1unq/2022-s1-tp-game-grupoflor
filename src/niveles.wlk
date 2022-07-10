import wollok.game.*
import frog.*
import vehiculos.*
import extras.*

object presentacion {

	method iniciar() {
		game.addVisual(pantallaCarga)
		config.configurarTeclas()
	}

}

object juego {

	method iniciar() {
		reproductor.iniciarMusica()
		game.removeVisual(pantallaCarga)
		generadorAlcantarillas.generarAlcantarillas()
		generadorMeta.generarMeta()
		vehiculos.iniciar()
		flotantes.iniciar()
		visuales.iniciar()
		game.onTick(1000, 'ovni', { ovni.moverse()})
		game.onTick(2000, 'frutas', { generadorFrutas.generarFruta()})
		game.onTick(50, 'posicion', { frog.validarPosicion()})
		game.onCollideDo(frog, { algo => algo.teEncontro(frog)})
		frog.liberarMovimiento()
	}

}

object vehiculos {

	method iniciar() {
		// generacion de vehiculos
		game.onTick(5000, 'auto', { generadorVehiculos.generarVehiculo(generadorAutos)})
		game.onTick(4000, 'autoCarrera', { generadorVehiculos.generarVehiculo(generadorAutosCarreras)})
		game.onTick(3800, 'moto', { generadorVehiculos.generarVehiculo(generadorMotos)})
		// movimientos de vehiculos
		game.onTick(1500, 'auto', { generadorAutos.moverVehiculos()})
		game.onTick(1000, 'autoCarrera', { generadorAutosCarreras.moverVehiculos()})
		game.onTick(500, 'Moto', { generadorMotos.moverVehiculos()})
		// accionar de tanque
		game.onTick(3000, 'disparar', { tanque.disparar()})
		game.onTick(1000, 'bala', { generadorBalas.moverBalas()})
	}

}

object flotantes {

	method iniciar() {
		// nenufares
		game.onTick(2500, 'nenufar', { generadorNenufares.generarNenufares()})
		// troncos generacion y movimiento
		game.onTick(8000, 'generarTroncosSur', { generadorTroncos.construirTronco(game.at(0, 7))})
		game.onTick(10000, 'generarTroncosNorte', { generadorTroncos.construirTronco(game.at(0, 9))})
		game.onTick(1000, 'moverTroncos', { generadorTroncos.moverTroncos()})
	}

}

object visuales {

	method iniciar() {
		game.addVisual(ovni)
		game.addVisual(anunciador)
		game.addVisual(tanque)
		game.addVisual(frog)
	}

}

object pantallaCarga {

	const property image = "froggerfachero.jpg"
	const property position = game.origin()

}

object pantallaMuerte {

	const property image = "pantallaMuerte.jpg"
	const property position = game.origin()

}

object pantallaVictoria {

	const property image = "creditosFrogger.jpg"
	const property position = game.origin()

}

object config {

	method configurarTeclas() {
		keyboard.left().onPressDo({ frog.mover(izquierda)})
		keyboard.right().onPressDo({ frog.mover(derecha)})
		keyboard.up().onPressDo({ frog.mover(arriba)})
		keyboard.down().onPressDo({ frog.mover(abajo)})
		keyboard.v().onPressDo({ anunciador.decirPuntajeYVidas(frog)})
		keyboard.space().onPressDo({ frog.saltar()})
		keyboard.enter().onPressDo({ juego.iniciar()})
	}

}

object reproductor {

	var musica = game.sound('musicaFrog.mp3')

	method iniciarMusica() {
		musica.shouldLoop(true)
		keyboard.w().onPressDo({ musica.volume(1)})
		keyboard.s().onPressDo({ musica.volume(0.2)})
		keyboard.m().onPressDo({ musica.volume(0)})
		game.schedule(001, { musica.play()})
	}

	method pararMusica() {
		musica.stop()
	}

	method cambiarMusica(musicaNueva) {
		musica = game.sound(musicaNueva)
	}

}

