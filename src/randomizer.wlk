import wollok.game.*

object randomizer {

	method position(posicionY){
		return game.at((0 .. game.width() - 1 ).anyOne(), posicionY)
	}
	
	method emptyPosition(posicionY){
		const position = self.position(posicionY)
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition(posicionY)
		}
	}

}


	
			
	/*method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
	}*/
	
	/* 
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
	*/