---

# Taller Flex - Twisted Metal

Este repositorio contiene la solución al taller de Flex, junto con el proyecto del scaner del juego Twisted Metal. Twisted Metal es un derby de demolición que permite el uso de proyectiles baláısticos, ametralladoras, minas y otros tipos de armas (hasta un arma satelital y armas nucleares). En su modo de torneo se pueden tener batallas multijugador en diferentes escenarios, en los cuales se encuentras gran variedad de pick ups de armas y mejoras. El objetivo del juego es ser el último automóvil en pie.


## Detalles del taller

### Parte 1

#### Ejemplo 1
Escáner que reemplaza todos los números en un flujo de texto con un signo de interrogación. Podría ser útil, por ejemplo, si fueras un contador particularmente poco escrupuloso.
1. **Comandos para compilar y correr programa**:
    ```bash
    flex hide-digits.l
    gcc lex.yy.c -o hide-digits -lfl
    ./hide-digits 
#### Ejemplo 2
Este ejemplo ilustra un programa que cuenta las palabras, caracteres y líneas de un archivo seleccionado durante la ejecución del archivo compilado. 
1. **Comandos para compilar y correr programa**:
   Es importante cambiar `example.txt` por el nombre del archivo con el cual se correra el programa.
    ```bash
    flex word-counter.l
    cc lex.yy.c -lfl -o word-counter
    ./word-counter < example.txt 
### Parte 2
#### Descripción
Analizador sintáctico para un combate de la arena de Twisted Metal. Un combate de la arena debe iniciar
seleccionando el escenario, luego seleccionando 4 jugadores, entonces inicia el combate. En esta aproximación cada jugador hace un movimiento en su turno, además de que un ataque se hace a un solo oponente y será exitoso o no con base en la poscisión del objetivo.
#### Selección de Mapa y Personajes

En el documento de juego, los jugadores deben seleccionar un mapa y cuatro personajes para el combate. Esto se realiza mediante comandos específicos en el documento.

- Para seleccionar un mapa, se utiliza el comando `select map <nombre del mapa>`.
- Para seleccionar un personaje, se utiliza el comando `select player <nombre del personaje>`.

Es importante seguir estas instrucciones correctamente, ya que no realizar la selección de mapa o de alguno de los cuatro jugadores resultará en un error y el no reconocimiento del documento de juego.

##### Lista de Mapas 

| Mapas       |
|-------------|
| Moscow      |
| Paris       |
| Amazonía    |
| New York    |
| Antarctica  |
| Holland     |
| Hong Kong   |
| Dark Tooth  |
##### Lista de Personajes 
| Personajes | Descripción                                                                                                                                         |  Vida    |
|------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| Axel       | Es un hombre aprisionado en 2 ruedas gigantes por culpa de su padre. Se une al torneo para conseguir el valor de hacerle frente a su padre.         |   20     |
| Grasshopper| Krysta Sparks es la piloto de este buggy. Afirma ser la hija de Calypso y su deseo es asesinarlo.                                                   |   20     |
| Mr. Grimm  | La parca pilotea esta motocicleta con sidecar. Se une al torneo porque desea facilitar su consumo de almas.                                         |    20    |
| Hammerhead | Los pilotos de esta Monster Truck son Mike y Stu, dos cabezahuecas que ingresan al torneo para desear poder volar.                                  |   20     |
| Minion     | El demonio Minion conduce este vehículo APC guerrillero. Solo se une al torneo por el deseo de vengarse de Calypso por haberle robado sus poderes.  |  20      |
| Outlaw 2   | Jamie Roberts maneja este coche de policía. Es la hermana del Outlaw de la primera entrega y busca a su hermano perdido.                            |     20   |
| Roadkill   | Piloteado por Marcus Kane, un vagabundo que cree que todo el universo de Twisted Metal es algo imaginario.                                          | 20       |
| Shadow     | Su piloto es Mortimer y conduce un coche fúnebre. Es el guardián de las almas perdidas que fueron asesinadas.                                       |   20  |
| Mr. Slam   | Un tractor de pala conducido por Simon Whittlebone, un arquitecto frustrado que desea construir el rascacielos más grande del mundo.                     | 20   |
| Spectre    | Un Corvette blanco conducido por Ken Masters, un actor cuyo único deseo es la fama absoluta.                                                              |20  |
| Sweettooth | El camión de helados de la anterior entrega vuelve conducido por Kane Needles, un payaso homicida.                                                        |20  |
| Thumper    | Una limusina rosa manejada por Bruce Cochrane, un gangster que desea ser el emperador del mundo.                                                         |20   |
| Twister    | Este F1 es conducido por Amanda Watts, una piloto de carreras cuyo deseo es viajar a la velocidad de la luz.                                             |20      |
| Warthog    | El capitán Rogers maneja este blindado de guerra. Se une al torneo para desear ser joven otra vez.                                                 | 20                                                             |
| Darktooth  | Esta extraña mezcla de Sweettooth con Darkside es el jefe final del juego. No es seleccionable.                                                     |20            |
#### Acciones y movimientos 
##### Controles basicos (movimiento) 
| Acción                | Comando           |
|-----------------------|-------------------|
| Acelerar              | ⇑                 |
| Cambiar dirección a la derecha | ⇒ |
| Retroceder            | ⇓                 |
| Cambiar dirección a la izquierda | ⇐ |
| Turbo                 | △                 |
| Frenar                | ⃝                 |
| Acelerar              | □                 |

| Cambiar arma secundaria 1 | L1 |
| Disparar arma seleccionada | L2          |
| Cambiar arma secundaria 2 | R1 |
| Ametralladora         | R2                 |
##### Ataques de un especiales 
| Ataque Especial                                 | Comando                        | Daño  |
|-------------------------------------------------|--------------------------------|-------|
| Fireball and freeze attack                      | L1, L2, R1, R2, ⇒, ⇐, ⇑       |    5   |
| Be Invisible                                    | ⇐, ⇐, ⇓, ⇓                    |    0   |
| Charged up mine                                 | ⇒, ⇐, ⇓, ⃝                    |    0   |
| Freeze                                          | ⇑, ⇓, ⇑                       |    0   |
| Freeze Attack                                   | ⇒, ⇐, ⇑                       |    5   |
| Energy shield                                   | ⇒, ⇒, ⇓, ⇓                    |    0   |
| Mine                                            | ⇒, ⇐, ⇓                       |    7   |
| Disparar armas desde la parte trasera          | ⇐, ⇒, ⇓, L2                    |    2   |
| Saltar                                          | ⇑, ⇐, ⇐                       |    0   |


##### Anatomia de un turno 
En su turno, cada personaje puede relizar las siguientes acciones:
|Acción|Comanado|
|------|--------|
|Desplazarse|mov(comandos de movimiento)|
|Ataque|atq(comando ataque, arma, personaje objectivo)|
|Ataque especial| atqs(comando ataque especial)|
puede desplazarse y disparar la ametralladora, desplazarse y disparar arma seleccionada, o realizar un ataque avanzado.
Adem´as se supondr´a que un ataque se hace a un solo oponente y ser´a exitoso con probabilidad de 1 si se encuentra entre
[-15, 15] grados, con probabilidad de 0.5 si esta entre [-45, -15) y (15. 45] grados, es decir la mitad de las veces el ataque
de un jugador impactar´a en otro en ese rango.

---
