import wollok.game.*
import obstaculos.*

object frog {
	var property position = game.at(5,0)
	const property image = "frogUP.png"	
	
	method ganar() {
		self.terminar("Gané!")		
	}
	
	method perder() {
		self.terminar("Perdí!")
	}
	
	method terminar(mensaje) {
		game.say(self, mensaje)
		game.schedule(1000, {game.stop()})
	}
}

object derecha {
	method siguiente(posicion) {
		
		return posicion.right(1)	
	}
	
}

object izquierda {
	method siguiente(posicion) {
		return posicion.left(1)	
	}	
}
object arriba {
	method siguiente(posicion) {
		return posicion.up(1)	
	}	
}

object abajo {
	method siguiente(posicion) {
		return posicion.down(1)	
	}
}

