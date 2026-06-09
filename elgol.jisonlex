%options flex

%%

/* whitespace */
[ \t]+                       /* skip */
\r\n|\r|\n                   /* skip */

/* comentário Elgol: começa com * e vai até fim da linha */
\*.* /* skip */

/* palavras reservadas */
"inicio"                     return 'INICIO';
"fim"                        return 'FIM';
"se"                         return 'SE';
"senao"                      return 'SENAO';
"entao"                      return 'ENTAO';
"enquanto"                   return 'ENQUANTO';
"para"                       return 'PARA';

"numero"                     return 'TIPO_NUMERO';
"inteiro"                    return 'TIPO_NUMERO';

"elgio"                      return 'ELGIO';
"NADA"                       return 'NADA';
"NEG"                        return 'NEG';
"de"                         return 'DE';

/* relacionais (textuais) */
"maior"                      return 'MAIOR';
"menor"                      return 'MENOR';
"igual"                      return 'IGUAL';
"diferente"                  return 'DIFERENTE';
"migual"                     return 'MIGUAL';
"Migual"                     return 'MIGUALC';

/* operadores matemáticos e tokens simples */
"EXP"                        return 'EXP';
"x"                          return 'MULT';
"%"                          return 'MOD';

"="                          return 'ATRIB';
"+"                          return 'PLUS';
"-"                          return 'MINUS';
"/"                          return 'SLASH';

"("                          return 'LPAREN';
")"                          return 'RPAREN';
","                          return 'COMMA';
"."                          return 'DOT';

/* números: não pode começar com 0; e 0 sozinho é erro léxico */
[1-9][0-9]* return 'INT';
0                            return 'ERRO_LEXICO';

/* INVALIDOS: regras explícitas para invalidar letra+digito (Faz2, _Faz2, 2Faz) */
_[A-Za-z0-9]*[0-9][A-Za-z0-9]* return 'ERRO_LEXICO'; /* ex: _Faz2, _2Faz */
[A-Za-z]+[0-9][A-Za-z0-9]* return 'ERRO_LEXICO'; /* ex: Faz2, Fa2z */
[0-9]+[A-Za-z_][A-Za-z0-9_]* return 'ERRO_LEXICO'; /* ex: 2Faz, 2_ */

/* função: começa com _ e segue letras */
_[A-Z][A-Za-z]*              return 'FUNCAO';

/* id (variável): começa com maiúscula e segue letras */
[A-Z][A-Za-z]*               return 'ID';

/* fim de arquivo */
<<EOF>>                      return 'EOF';

/* qualquer outro caractere -> erro léxico */
.                            return 'ERRO_LEXICO';