%{
#include "analizer.tab.h"
%}
%option noyywrap
%%
[ Ss ][ Ee ][ Ll ][ Ee ][ Cc ][ Tt ]  {return SELECT; }
[ Mm ][ Aa ][ Pp ]                    {return MAP; }
[ Pp ][ Ll ][ Aa ][ Yy ][ Ee ][ Rr ]  {return PLAYER; }
"Turno:"                              {return TURN; }
"Termina."                            {return FINISH_TURN; }
"Fin del juego."                      {return FINISH_GAME; }
"Moscow"                              {return MAPNAME; }
"Paris"                               {return MAPNAME; }
"Amazonía"                            {return MAPNAME; }
"New York"                            {return MAPNAME; }
"Antarctica"                          {return MAPNAME; }
"Holland"                             {return MAPNAME; }
"Hong Kong"                           {return MAPNAME; }
"Axel"                                {return PNAME; }
"Grasshopper"                         {return PNAME; }
"Mr. Grimm"                           {return PNAME; }
"Hammerhead"                          {return PNAME; }
"Minion"                              {return PNAME; }
"Outlaw 2"                            {return PNAME; }
"Roadkill"                            {return PNAME; }
"Shadow"                              {return PNAME; }
"Mr. Slam"                            {return PNAME; }  
"Spectre"                             {return PNAME; }
"Sweettooth"                          {return PNAME; }
"Thumper"                             {return PNAME; }
"Twister"                             {return PNAME; }
"Warthog"                             {return PNAME; }
"Darktooth"                           {return PNAME; }
"⇑"                                   {return FORWARD; }
"⇒"                                   { return RIGHT; }
"⇓"                                   { return REVERSE; }
"⇐"                                   { return LEFT; }
"Y"                                   { return TURBO; }
"B"                                   { return BRAKE; }
"X"                                   { return ACCELERATE; }
"L1"                                  { return SECONDARY_WEAPON_1; }
"L2"                                  { return FIRE_SELECTED_WEAPON; }
"R1"                                  { return SECONDARY_WEAPON_2; }
"R2"                                  { return MACHINE_GUN; }
"L1L2R1R2⇒⇐⇑"                         { return FIREBALL_FREEZE_ATTACK; }
"⇐⇐⇓⇓"                                { return BE_INVISIBLE; }
"⇒⇐⇓⇓"                                { return CHARGED_UP_MINE; }
"⇑⇓⇑"                                 { return FREEZE; }
"⇒⇐⇑"                                 { return FREEZE_ATTACK; }
"⇒⇒⇓⇓"                                { return ENERGY_SHIELD; }
"⇒⇐⇓"                                 { return MINE; }
"⇐⇒⇓L2"                               { return FIRE_REAR_WEAPONS; }
"⇑⇐⇐"                                 { return JUMP; }



[ \t\n]+
.           { printf("Caracter no reconocido: %s\n", yytext); }
%%