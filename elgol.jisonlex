%options flex

%%

/* whitespace */
[ \t]+                      /* skip */
\r\n|\r|\n                   /* skip */

/* comentário Elgol: começa com * e vai até fim da linha */
\*.*                         /* skip */

/* palavras reservadas */
"inicio"                     return 'INICIO';
"fim"                        return 'FIM';
"se"                         return 'SE';
"senao"                      return 'SENAO';
"entao"                      return 'ENTAO';
"enquanto"                   return 'ENQUANTO';
"para"                       return 'PARA';

"numero"                     return 'TIPO_NUMERO';
"inteiro"                    return 'TIPO_INTEIRO';

"elgio"                      return 'ELGIO';
"NADA"                       return 'NADA';

/* relacionais (textuais) */
"maior"                      return 'MAIOR';
"menor"                      return 'MENOR';
"igual"                      return 'IGUAL';
"diferente"                  return 'DIFERENTE';
"migual"                     return 'MIGUAL';
"Migual"                     return 'MIGUALC';
"de"                         return 'DE';

/* operadores matemáticos e tokens simples */
"EXP"                        return 'EXP';
"x"                          return 'MULT';

"="                          return 'ATRIB';
"+"                          return 'PLUS';
"-"                          return 'MINUS';
"*"                          return 'STAR';
"/"                          return 'SLASH';

"("                          return 'LPAREN';
")"                          return 'RPAREN';
","                          return 'COMMA';
"."                          return 'DOT';

/* números: não pode começar com 0; e 0 sozinho é erro léxico */
[1-9][0-9]*\.[0-9]+          return 'FLOAT';
[1-9][0-9]*                  return 'INT';
0                            return 'ERRO_LEXICO';

/* INVALIDOS (para bater com o enunciado): letras+digitos nao podem formar token */
_[A-Za-z]+[0-9]+             return 'ERRO_LEXICO'; /* ex: _Fazalgo2 */
[A-Za-z]+[0-9]+              return 'ERRO_LEXICO'; /* ex: Faz2 */

/* função: começa com _ e só letras */
_[A-Za-z]+                   return 'FUNCAO';

/* id (variável): só letras */
[A-Za-z]+                    return 'ID';

/* fim de arquivo */
<<EOF>>                      return 'EOF';

/* qualquer outro caractere -> erro léxico */
.                            return 'ERRO_LEXICO';