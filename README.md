---

# Repositorio del Taller Flex

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
```bash
flex word-counter.l
cc lex.yy.c -lfl -o word-counter
./word-counter < example.txt 
### Parte 2
Ya implementado en la calculadora.

### Punto 6
![Comparacion de tiempo de ejecucion](https://github.com/AlgorithmicPaws/flex-bison/blob/main/ComparationResults.png)
---
