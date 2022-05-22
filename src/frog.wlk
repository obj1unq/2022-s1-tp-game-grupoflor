import wollok.game.*
import obstaculos.*

object frog {
	var property position = game.center()
	const property image = "frogUP.png"	
	
	method ganar() {
		self.terminar("Gané!")		
	}
	
	method perder() {
		self.terminar("Perdí!")
	}
	
	method terminar(mensaje) {
		game.say(self, mensaje)
		game.schedule(2000, {game.stop()})
	}
}
