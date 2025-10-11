import wollok.game.*

// Etapa 1
// Chevrolet Corsa
class Corsa {
  var property image
  // const property color
  var position = game.at(4,7)
  method position() = position
  method position(nuevaPosicion) {
    position = nuevaPosicion
  }
  const posiciones = #{position}
  method capacidad() = 4
  method velocidadMaxima() = 150
  method peso() = 1300
  method pasoPor(posicion) {
    return posiciones.contains(posicion)
  }

  method moverseHacia(direccion) {
    if (direccion == norte.direcc()) {
      self.position(self.position().up(1))
    }
    else if(direccion == sur.direcc()) {self.position(self.position().down(1))}
    else if(direccion == oeste.direcc()) {self.position(self.position().left(1))}
    else {self.position(self.position().right(1))}
  }

  
  method pasoPorFila(numero) {

  }
}

object norte {method direcc() = self}
object sur {method direcc() = self}
object oeste {method direcc() = self}
object este {method direcc() = self}

// Renault Kwid
class Kwid {
  var tieneTanqueDeGas = false
  method agregarTanque() {
    tieneTanqueDeGas = true
  }
  method sacarTanque() {
    tieneTanqueDeGas = false
  }
  method tieneTanqueDeGas() = tieneTanqueDeGas
  method capacidad() = if (tieneTanqueDeGas) 3 else 4
  method velocidadMaxima() = if (tieneTanqueDeGas) 110 else 10
  method  peso() = 1200 + self.adicionDeTanque()
  method adicionDeTanque() =
    if (tieneTanqueDeGas) 150 else 0
  method color() = "Azul"
}

// Trafic
object trafic {
  var property interior = comodo
  var property motor = pulenta
  method capacidad() = interior.capacidadPasajeros()

  method velocidadMaxima() = motor.velocidadMaxima()

  method peso() = 400 + interior.peso() + motor.peso()

  method color() = "Blanco"
}

object comodo {
  method capacidadPasajeros() = 5
  method peso() = 700
}

object popular {
  method capacidadPasajeros() = 12
  method peso() = 1000
}

object pulenta {
  method peso() = 800

  method velocidadMaxima() = 130
}

object batalon {
  method peso() = 500

  method velocidadMaxima() = 80
}

// Auto Especial
class AutoEspecial {
  const property capacidad
  const property velocidadMaxima
  const property peso
  const property color
}

class Dependencia {
  const property flota = #{} 
  const property pedidos = [] 
  var property empleados

  method agregarPedido(unPedido) {
    pedidos.add(unPedido)
  }

  method quitarPedido(unPedido) {
    pedidos.remove(unPedido)
  }

  method agregarAFlota(rodado) {
    flota.add(rodado)
  }

  method quitarDeFlota(rodado) {
    flota.remove(rodado)
  }

  method pesoTotalFlota() =
    flota.sum({unRodado => unRodado.peso()})
  
  method estaBienEquipada() = flota.size() >= 3 && flota.all({unRodado => unRodado.velocidadMaxima() <= 100})

  method capacidadTotalEnColor(unColor) =
    flota.filter({unRodado => unRodado.color() == unColor}).sum({unRodado => unRodado.capacidad()})

  method colorDelRodadosMasRapido() = self.rodadoMasRapido().color()

  method rodadoMasRapido() = flota.max({unRodado => unRodado.velocidadMaxima()})

  method capacidadTotal() = flota.size()

  method capaCidadFaltante() = empleados - self.capacidadTotal()

  method esGrande() = empleados <= 40 &&  self.capacidadTotal() <= 5

  method totalDePasajeros() = pedidos.sum({pedido => pedido.cantidadDePasajeros()})

  method cualesPedidosNoSonSatisfechos(auto) = 
    pedidos.filter({pedido => !pedido.satisfaceElPedido(auto)})

  method  todosLosPedidosTieneColorinCompatible(color) = pedidos.all({pedido => !pedido.esColorIncompatible(color)})

  method relajarATodos() {
    pedidos.forEach({unPedido => unPedido.relajar()})
  }
}

// Etapa 2
class Pedido {
  const property distanciaARecorrer
  var tiempoMaximo
  const property cantidadDePasajeros
  const property coloresIncompatibles

  method tiempoMaximo() = tiempoMaximo 

  method velocidadRequerida() = distanciaARecorrer / tiempoMaximo

  method satisfaceElPedido(auto) =
    auto.velocidadMaxima() >= self.velocidadRequerida() &&
    auto.capacidad() >= cantidadDePasajeros &&
    !coloresIncompatibles.contains(auto.color())
  
  method acelerar() {
    tiempoMaximo -= 1
  }

  method relajar() {
    tiempoMaximo += 1
  }

  method colorEsIncompatible(color) = coloresIncompatibles.contains(color)
}