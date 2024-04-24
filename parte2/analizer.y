%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin; 
int yylex(void);
int yyerror(char* s);
%}
%token SELECT
%token MAP
%token MAPNAME
%token PLAYER
%token PNAME
%token FINISH_TURN
%token FINISH_GAME
%token TURN
%token FORWARD
%token RIGHT
%token REVERSE
%token LEFT
%token TURBO
%token BRAKE
%token ACCELERATE
%token SECONDARY_WEAPON_1
%token FIRE_SELECTED_WEAPON
%token SECONDARY_WEAPON_2
%token MACHINE_GUN
%%

start : selections turn_structures FINISH_GAME
      ;


selections : selection
           | selections selection
           ;

selection : SELECT MAP MAPNAME { printf("Mapa seleccionado\n"); }
          | SELECT PLAYER PNAME  { printf("Personaje seleccionado\n"); }
          ;
turn_structures : /* Empty */
                | turn_structure turn_structures
                ;

turn_structure : TURN PNAME movements PNAME movements PNAME movements PNAME movements FINISH_TURN { printf("Turno completado\n"); }
               ;


movements : /* Empty */
          | movements movement
          ;

movement : FORWARD { printf("Avanzar\n"); }
         | REVERSE { printf("Retroceder\n"); }
         | RIGHT { printf("Derecha\n"); }
         | LEFT { printf("Izquierda\n"); }
         | TURBO { printf("Turbo\n"); }
         | BRAKE { printf("Frenar\n"); }
         | ACCELERATE { printf("Acelerar\n"); }
         | SECONDARY_WEAPON_1 { printf("Disparar arma secundaria 1\n"); }
         | FIRE_SELECTED_WEAPON { printf("Disparar arma seleccionada\n"); }
         | SECONDARY_WEAPON_2 { printf("Disparar arma secundaria 2\n"); }
         | MACHINE_GUN { printf("Disparar ametralladora\n"); }
         ;
%%

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s archivo.txt\n", argv[0]);
        return 1;
    }

    FILE *archivo = fopen(argv[1], "r");
    if (archivo == NULL) {
        fprintf(stderr, "No se pudo abrir el archivo %s\n", argv[1]);
        return 1;
    }


    yyin = archivo;


    yyparse();

    fclose(archivo);

    return 0;
}

int yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
    return 0;
}