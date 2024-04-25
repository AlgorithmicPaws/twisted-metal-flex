%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h> 
extern FILE *yyin; 
int yylex(void);
int yyerror(char* s);
extern char *yytext; 
char player_name[4][20];
char repeat_player_name[4][20];
int num_players = 0;
int repeat_num_players = 0;
char map_name[20];
int map_selected = 0;
char player_name_check[20];
int vida1 = 0;
int vida2 = 0;
int vida3 = 0;
int vida4 = 0;

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

selection : SELECT MAP MAPNAME { 
                if (map_selected) {
                    printf("Error: Solo se puede seleccionar un mapa.\n");
                    exit(1);
                }
                printf("Mapa seleccionado: %s\n", yytext); 
                strncpy(map_name, yytext, sizeof(map_name) - 1);
                map_selected = 1; 
            }
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
turn_structures : turn_structure 
                | turn_structure turn_structures
                ;

turn_structure : TURN turn turn turn turn FINISH_TURN {repeat_num_players = 0;
    for (int i = 0; i < 4; i++) {
        memset(repeat_player_name[i], 0, sizeof(repeat_player_name[i])); // Fill each element with null bytes
    }
    }
               ;

turn: PNAME special_attack {   if(strcmp(player_name_check, $1) == 0){
                                printf("Personaje repetido\n ");
                                exit(1); 
                                }else{
                                char *player_name_check = $1;
                                 if(strcmp(player_name_check, player_name[0]) == 0 || 
                                strcmp(player_name_check, player_name[1]) == 0 || 
                                strcmp(player_name_check, player_name[2]) == 0 || 
                                strcmp(player_name_check, player_name[3]) == 0) {
                                printf("Todo bien\n ");
                                } else {
                                printf("Personaje no seleccionado\n ");
                                exit(1);
                            }}}
    | PNAME movements shoot {   if(strcmp(player_name_check, $1) == 0){
                                printf("Personaje repetido\n ");
                                exit(1); 
                                }else{
                                char *player_name_check = $1;
                                 if(strcmp(player_name_check, player_name[0]) == 0 || 
                                strcmp(player_name_check, player_name[1]) == 0 || 
                                strcmp(player_name_check, player_name[2]) == 0 || 
                                strcmp(player_name_check, player_name[3]) == 0) {
                                printf("Todo bien\n ");
                                } else {
                                printf("Personaje no seleccionado\n ");
                                exit(1);
                            }}}
    | PNAME movements secundary_attacks{ 
                                char *player_name_check = $1;
                                 if(strcmp(player_name_check, player_name[0]) == 0 || 
                                strcmp(player_name_check, player_name[1]) == 0 || 
                                strcmp(player_name_check, player_name[2]) == 0 || 
                                strcmp(player_name_check, player_name[3]) == 0) {
                                    if((strcmp(player_name_check, repeat_player_name[0]) == 0 || 
                                        strcmp(player_name_check, repeat_player_name[1]) == 0 || 
                                        strcmp(player_name_check, repeat_player_name[2]) == 0 || 
                                        strcmp(player_name_check, repeat_player_name[3]) == 0)){
                                        printf("Personaje repetido\n ");
                                        exit(1); 
                                     }else{
                                        strncpy(repeat_player_name[repeat_num_players++], player_name_check, sizeof(repeat_player_name[0]) - 1);
                                } } else {
                                printf("Personaje no seleccionado\n ");
                                exit(1);
                            }}

movements : movement
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

secundary_attacks : FIRE_SELECTED_WEAPON { printf("Disparo secundario\n"); }
                  | select_secundary_attack secundary_attacks 
                  ; 

select_secundary_attack: SECONDARY_WEAPON_1 { printf("Cambio arma izq\n"); }
     | SECONDARY_WEAPON_2 { printf("Cambio arma der\n"); }
     ;

special_attack: FIREBALL_FREEZE_ATTACK { printf("Disparar bola de fuego congelante\n"); }
     | BE_INVISIBLE { printf("Volverse invisible\n"); }
     | FREEZE_ATTACK { printf("Ataque congelante\n"); }
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
