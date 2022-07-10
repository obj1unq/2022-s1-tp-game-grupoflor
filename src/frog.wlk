import wollok.game.*
import vehiculos.*
import extras.*
import niveles.*

object frog {
	var property position = game.at(5,0)
	var property image = "frogUP.png"	
	var property vidas = 2
	var property puntaje = 0
	var property cantidadLlegadas = 0
	var property saltoDisponible = true
	var property puedeMover = false
	

	method saltar(){
		self.validarSaltar()
		saltoDisponible = false
		position = position.up(2)
	}
	
	method validarSaltar(){
		if (!saltoDisponible){
			self.error('no me quedan energias para saltar')
		}
	}
	
	method ganar() {
		self.terminar(pantallaVictoria, 'sonidoVictoria.mp3')
	}
	
	method perder() {
		self.terminar(pantallaMuerte, 'sonidoMuerte.mp3')
	}
	
	method terminar(pantalla, sonido) {
		game.clear()
		game.addVisual(pantalla)
		reproductor.pararMusica()
		reproductor.cambiarMusica(sonido)
		reproductor.iniciarMusica()
		game.schedule(8000, {game.stop()})
	}

	method mover(direccion) {
        const aDondeVoy = direccion.siguiente(position)
        self.validarInicio()  
        if(self.destinoValido(aDondeVoy)) {
            self.position(aDondeVoy)
            self.cambiarImagen(direccion)
        }
    }
    
    method cambiarImagen(direccion){
    	image = 'frog' + direccion.subfijo() + '.png'
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
    	position = game.at(7,0)
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
	
	method destinoValido(destino) {
        return destino.x().between(0, game.width() - 1) and
               (destino.y().between(0, game.height() - 2) or self.destinosMetas(destino))
    }
    
    method destinosMetas(destino){
    	return destino == game.at(1, 10) or destino == game.at(4, 10) or destino == game.at(7, 10)
    }
    
    method validarDestino(destino) {
        if(not self.destinoValido(destino)) {
            self.error("destino invalido")
        }        
    }
    
    method validarPosicion(){
    	if (self.muere()){
    		self.colisionado()
    	}
    }
    
    method muere(){
    	return agua.estaEnAgua(position) and  !generadorTroncos.estaEnTronco(position) and !generadorNenufares.estaEnNenufar(position)
    }
    
    method liberarMovimiento(){
    	game.schedule(7000, {self.liberarRana()})
    }
    
    method liberarRana(){
    	puedeMover = true
    	game.say(self, 'Ahora si me puedo mover :D')
    }
    
    method validarInicio(){
    	if (! puedeMover){
    		game.error('Estoy entrando en calor')
    	}
    }
    
    method reiniciarObjeto(){
    	game.removeVisual(self)
    	game.addVisual(self)
    }

}




object derecha {

    method siguiente(posicion) {
        return posicion.right(1)
    }

    method direccion() {
        return self
    }
    
    method subfijo(){
    	return 'Right'
    }

}

object izquierda {

    method siguiente(posicion) {
        return posicion.left(1)
    }

    method direccion() {
        return self
    }
	
	method subfijo(){
    	return 'Left'
    }
}

object arriba {

    method siguiente(posicion) {
        return posicion.up(1)
    }

    method direccion() {
        return self
    }
    
    method subfijo(){
    	return 'UP'
    }

}

object abajo {

    method siguiente(posicion) {
        return posicion.down(1)
    }

    method direccion() {
        return self
    }
    
    method subfijo(){
    	return 'Down'
    }

}
