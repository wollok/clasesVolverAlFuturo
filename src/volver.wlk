class Elemento{
	var property anioOrigen
	var property descripcion 
	
	method paradoja(){
		if (self.esParadojico())
			self.alterarDescripcion()
	}
	method alterarDescripcion(){
		descripcion = descripcion.reverse()
	}
	method esParadojico(){
		return anioOrigen > tiempo.anioActual()
	}
	method esDe(lugar){
		return descripcion.contains(lugar.nombre())
	}
}

const patineta = new Elemento(anioOrigen =  2015,descripcion = "vuela")
const libroDeportivo = new Elemento(anioOrigen = 2015,descripcion = "te dice quien salio campeon")
const fotoReloj = new Elemento(anioOrigen = 1885,descripcion = "esta en blanco y negro")
const fotoFamilia = new Elemento(anioOrigen = 1985,descripcion = "familia mcfly")
const revista = new Elemento(anioOrigen = 2016,descripcion = "argentina")

class Lugar{
	var property nombre
	const habitantes = []
	 
	 method llega(habitante){
	 	habitantes.add(habitante)
	 	habitante.agregarElemento(
	 		new Elemento(
	 			anioOrigen = tiempo.anioActual(), 
	 			descripcion = "Recuerdo de " + nombre
	 		)
	 	)
	 }
	 method seVa(habitante){
	 	habitantes.remove(habitante)
	 }
	 
	 method hayAlguienConAlgoDelLugar(){
	 	return habitantes.any({personaje => personaje.tieneAlgoDe(self)})
	 }
}

class Personaje{
	const elementosPersonales = []
	const caracteristica
	var property edad
	var property altura
	
	method esMayor(){
		return edad > 50
	}
	method perderPertenenciaMasAntigua(){
		if (not elementosPersonales.isEmpty())
			elementosPersonales.remove(self.pertenenciaMasAntigua())
	}
	method agregarElemento(elemento){
		elementosPersonales.add(elemento)
	}

	method pertenenciaMasAntigua(){
		return elementosPersonales.min({elemento => elemento.anioOrigen()})
	}
	
	method envejecer(anios){
		edad += anios
	}
	method rejuvenecer(anios){
		edad -= anios
	}
	method disminuirAltura(cm){
		altura -= cm
	}
	method tieneAlgoDe(lugar){
		return elementosPersonales.any{elemento=>elemento.esDe(lugar)}
	}
	method paradojas(){
		elementosPersonales.forEach{elemento=>elemento.paradoja()}
	}
}

const docBrown = new Personaje(
	caracteristica = "le dicen doc", 
	elementosPersonales=[fotoReloj, revista], 
	edad = 71,
	altura = 1.8
) 
const marty = new Personaje(
	caracteristica = "Se enoja cuando le dicen gallina",
	elementosPersonales = [patineta,fotoFamilia],
	edad = 25,
	altura = 1.7
)
const biff = new Personaje(
	caracteristica = "tiene un caracter feo", 
	elementosPersonales=[libroDeportivo],
	edad = 25,
	altura = 2
)


object deLorean{
	var property combustible = plutonio
	const pasajeros = [marty,docBrown]
	var lugar = new Lugar(
		nombre = "Hill Valley",
		habitantes = [marty,docBrown,biff]
	)
	
	method subirA(personaje){
		pasajeros.add(personaje)
	}
	method bajarA(personaje){
		pasajeros.remove(personaje)
	}
	method viajarEnElTiempo(fecha){
		tiempo.anioActual(fecha)
		pasajeros.forEach({pasajero => 
			combustible.afectar(pasajero)
			pasajero.paradojas()
		})
	}  
	method viajarEnElEspacio(destino){
		pasajeros.forEach({pasajero => 
			destino.llega(pasajero)
			lugar.seVa(pasajero) 
		})
		lugar = destino
	}  

}


object nafta{
	method afectar(personaje){
		personaje.disminuirAltura(1)
	}
}
object plutonio{
	method afectar(personaje){
		if(personaje.esMayor())
			personaje.rejuvenecer(10)
		else
			personaje.envejecer(5)	
	}
}
object energiaElectrica{
	 method afectar(personaje){
	 	personaje.perderPertenenciaMasAntigua()
	 }
}

object tiempo{
	var property anioActual = 2020
}

