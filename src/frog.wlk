import wollok.game.*
import vehiculos.*
import extras.*

object frog {
	var property position = game.at(5,0)
	var property image = "frogUP.png"	
	var property vidas = 3
	var property puntaje = 0
	var property cantidadLlegadas = 0
	
	method image(direccion){
		return 'frog' + direccion.image() + '.png'
		
	}
	
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

	method mover(direccion) {
        if (direccion == arriba.direccion()) {
            image = "frogUP.png"
        } else if (direccion == izquierda.direccion()) {
            image = "frogLeft.png"
        } else if (direccion == derecha.direccion()) {
            image = "frogRight.png"
        } else {
            image = "frogDown.png"
        }
    }
    
    method colisionado(){
    	if(vidas == 0){
			self.perder()	
		}
		else{
			vidas-= 1
			self.volverInicio()
			game.say(anunciador, 'Te quedan ' + vidas + 'vidas')
		}
    }
    
    method volverInicio(){
    	position = game.at(8,0)
    }
	
	method agregarPuntaje(numero){
		const puntajeNuevo = puntaje + numero
		if (puntajeNuevo >= 100){
			puntaje = 0
			vidas = vidas + 1
		}
		else puntaje = puntajeNuevo
	}
	
	method sumarLlegada(){
		if (cantidadLlegadas < 2){
			cantidadLlegadas = cantidadLlegadas + 1
			self.volverInicio()
		}
		else{self.ganar()} 
	}

}




object derecha {

    method siguiente(posicion) {
        return posicion.right(1)
    }

    method direccion() {
        return self
    }

}

object izquierda {

    method siguiente(posicion) {
        return posicion.left(1)
    }

    method direccion() {
        return self
    }

}

object arriba {

    method siguiente(posicion) {
        return posicion.up(1)
    }

    method direccion() {
        return self
    }

}

object abajo {

    method siguiente(posicion) {
        return posicion.down(1)
    }

    method direccion() {
        return self
    }

}
