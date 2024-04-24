%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
int yyerror(char* s);
%}
%token SELECT
%token MAP
%token PLAYER
%%

sentencia: SELECT { printf("Se reconoció la palabra1\n"); }
         | MAP { printf("Se reconoció la palabra2\n"); }
         | PLAYER { printf("Se reconoció la palabra3\n"); }

%%
int main(int argc, char **argv)
{
	yyparse();
}

int yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}