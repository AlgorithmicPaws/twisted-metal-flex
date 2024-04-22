%{
#include <stdio.h>
#include "lex.yy.c"
#include "analizer.tab.c"
%}

%option noyywrap

%%

[ Ss ][ Ee ][ Ll ][ Ee ][ Cc ][ Tt ] { printf("Se reconoci la palabra 'select'\n"); return SELECT; }
[ Mm ][ Aa ][ Pp ]                { printf("Se reconoci la palabra 'map'\n"); return MAP; }
[ Pp ][ Ll ][ Aa ][ Yy ][ Ee ][ Rr ]  { printf("Se reconoci la palabra 'player'\n"); return PLAYER; }
.           ; // Ignorar otros caracteres

%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Uso: %s archivo_de_texto.txt\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        printf("Error al abrir el archivo.\n");
        return 1;
    }

    yyin = file; // Redirige la entrada estándar al archivo

    yyparse();   // Llama al analizador sintáctico generado por Bison

    fclose(file);
    return 0;
}

