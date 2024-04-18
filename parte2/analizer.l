%{
    #include <stdio.h>
    #include <string.h>
%}

%option noyywrap

%%

"Mapa:"    { printf("Mapa seleccionado: %s\n", yytext); }
"Jugador:" { printf("Jugador seleccionado: %s\n", yytext); }

Moscow|Paris|Amazonía|New\ York|Antarctica|Holland|Hong\ Kong|Dark\ Tooth { printf("Mapa: %s\n", yytext); }
Axel|Grasshopper|Mr\.\ Grimm|Hammerhead|Minion|Outlaw\ 2|Roadkill|Shadow|Mr\.\ Slam|Spectre|Sweettooth|Thumper|Twister|Warthog { printf("Jugador: %s\n", yytext); }

.|\n ;  /* Ignorar cualquier otro carácter */

%%

int main(int argc, char *argv[]) {
    // Verificar que se proporcionó un archivo de entrada
    if (argc != 2) {
        printf("Uso: %s <archivo_de_entrada>\n", argv[0]);
        return 1;
    }

    // Abrir el archivo de entrada
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Error al abrir el archivo");
        return 1;
    }

    // Analizar el archivo línea por línea
    yyin = file;
    yylex();

    // Cerrar el archivo
    fclose(file);

    return 0;
}
