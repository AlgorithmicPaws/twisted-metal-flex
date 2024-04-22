%{
#include <stdio.h>
%}

%token SELECT
%token MAP
%token PLAYER
%%

sentencia: SELECT { printf("Se reconoció la palabra1\n"); }
         | MAP { printf("Se reconoció la palabra2\n"); }
         | PLAYER { printf("Se reconoció la palabra3\n"); }

%%

int main() {
    yyparse();
    return 0;
}
