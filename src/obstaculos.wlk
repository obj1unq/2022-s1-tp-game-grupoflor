import wollok.game.*
import frog.*

object car1{
	const property image = 'car1.png'
	
	method position() {
		return game.at(objetivo.position().x().max(3), 0)
	}
	
	method teEncontro(alguien){
		alguien.perder()
	}
}