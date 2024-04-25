%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h> 
extern FILE *yyin; 
int yylex(void);
int yyerror(char* s);
extern char *yytext; 
char player_name[4][20];
char player_name_a[1][20];
int num_players = 0;
%}
%union {
    char *str;
}

%token SELECT
%token MAP
%token MAPNAME
%token PLAYER
%token <str>PNAME
%token <str>NPNAME
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
%token FIREBALL_FREEZE_ATTACK
%token BE_INVISIBLE
%token CHARGED_UP_MINE
%token FREEZE
%token FREEZE_ATTACK
%token ENERGY_SHIELD
%token MINE
%token FIRE_REAR_WEAPONS
%token JUMP

%%

start : selections turn_structures FINISH_GAME
      ;


selections : selection
           | selections selection
           ;

selection : SELECT MAP MAPNAME { printf("Mapa seleccionado\n"); }
          | SELECT PLAYER PNAME { 
                printf("Personaje seleccionado\n"); 
                if (num_players < 4) {
                    strncpy(player_name[num_players++], yytext, sizeof(player_name[0]) - 1);
                } else {
                    printf("Limite de jugadores alcanzado. No se pueden agregar más jugadores.\n");
                    exit(1); 
                }
              }
          ;
turn_structures : /* Empty */
                | turn_structure turn_structures
                ;

turn_structure : TURN PNAME special_attack PNAME special_attack PNAME special_attack PNAME special_attack FINISH_TURN { printf("Turno completado\n"); }
                |TURN PNAME special_attack PNAME movements shoot PNAME movements shoot PNAME movements shoot FINISH_TURN {printf("First player name: %s\n", $2);
                printf("Second player name: %s\n", $4);
                printf("Third player name: %s\n", $7);
                printf("Fourth player name: %s\n", $10);}
                |TURN PNAME movements shoot PNAME movements shoot PNAME movements shoot PNAME special_attack FINISH_TURN { printf("Turno completado\n"); }
                |TURN PNAME movements shoot PNAME movements shoot PNAME special_attack PNAME special_attack FINISH_TURN { printf("Turno completado\n");}
                |TURN PNAME movements shoot PNAME special_attack PNAME special_attack PNAME special_attack FINISH_TURN { printf("Turno completado\n"); }
                |TURN PNAME movements shoot PNAME special_attack PNAME movements shoot PNAME movements shoot FINISH_TURN { printf("Turno completado\n"); }
                |TURN PNAME movements shoot PNAME movements shoot PNAME movements shoot PNAME movements shoot FINISH_TURN { printf("Turno completado\n"); }
                ;

movements : /* Empty */
          | movements movement
          ;

movement : FORWARD { printf("Avanzar "); }
         | REVERSE { printf("Retroceder "); }
         | RIGHT { printf("Derecha "); }
         | LEFT { printf("Izquierda "); }
         | TURBO { printf("Turbo "); }
         | BRAKE { printf("Frenar "); }
         | ACCELERATE { printf("Acelerar "); }

shoot: MACHINE_GUN { printf("Disparar ametralladora\n"); }
     ;
special_attack: FIREBALL_FREEZE_ATTACK { printf("Disparar bola de fuego congelante\n"); }
     | BE_INVISIBLE { printf("Volverse invisible\n"); }
     | CHARGED_UP_MINE { printf("Colocar mina cargada\n"); }
     | FREEZE_ATTACK { printf("Ataque congelante\n"); }
     | ENERGY_SHIELD { printf("Activar escudo de energía\n"); }
     | MINE { printf("Colocar mina\n"); }
     | FIRE_REAR_WEAPONS { printf("Disparar armas traseras\n"); }
     | JUMP { printf("Saltar\n"); }
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
    printf("Player names:\n");
    for (int i = 0; i < num_players; i++) {
        printf("%d: %s\n", i + 1, player_name[i]);
    }
}

int yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
    return 0;
}
