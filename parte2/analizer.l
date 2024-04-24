%option noyywrap nodefault yylineno
%{
#include "analizer.tab.h"
%}

%option noyywrap

%%

[ Ss ][ Ee ][ Ll ][ Ee ][ Cc ][ Tt ] { printf("Se reconoci la palabra 'select'\n"); return SELECT; }
[ Mm ][ Aa ][ Pp ]                { printf("Se reconoci la palabra 'map'\n"); return MAP; }
[ Pp ][ Ll ][ Aa ][ Yy ][ Ee ][ Rr ]  { printf("Se reconoci la palabra 'player'\n"); return PLAYER; }
.           { printf("Carácter no reconocido: %s\n", yytext); }
%%
