import wollok.game.*

// Etapa 1
// Chevrolet Corsa
class Corsa {
  var property image
  // const property color
  var position = new Position(4,7)
  method position() = position
  method position(nuevaPosicion) {
    position = nuevaPosicion
  }
  const posiciones = #{position}
  method posiciones() = posiciones
  method capacidad() = 4
  method velocidadMaxima() = 150
  method peso() = 1300
  method pasoPor(posicion) {
    return posiciones.contains(posicion)
  }

  method moverseHacia(direccion) {
    if (direccion == norte.direcc()) {
      self.position(self.position().up(1)) self.agregarPosicion(self.position())
    }
    else if(direccion == sur.direcc()) {self.position(self.position().down(1)) self.agregarPosicion(self.position())}
    else if(direccion == oeste.direcc()) {self.position(self.position().left(1)) self.agregarPosicion(self.position())}
    else {self.position(self.position().right(1)) self.agregarPosicion(self.position())}
  }

  method agregarPosicion(unaPosicion) {
    posiciones.add(unaPosicion)
  }
}

object norte {
    method direcc() = self
}

object sur {
    method direcc() = self
}

object oeste {
    method direcc() = self
}

object este {
    method direcc() = self
}


object pared {
    var property image = "paredLadrillos3.jpg"
    var property position = new position(x = 8, y = 3)
    var resistencia = 3
    method recibirChoque(){
        resistencia = 0.max(resistencia-1)
        if (resistencia == 2){
            image = "paredLadrillos2.jpg"
        }
        else {
            image = "paredLadrillos1.jpg"
        }
    }
    method resistencia() = resistencia
}