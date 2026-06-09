%start programa

%%

programa
  : definicoes_funcao bloco_principal EOF
  ;

definicoes_funcao
  : definicoes_funcao funcao
  | /* vazio */
  ;

funcao
  : TIPO_NUMERO FUNCAO LPAREN parametros_opt RPAREN DOT bloco_funcao
  ;

parametros_opt
  : parametros
  | /* vazio */
  ;

parametros
  : parametro
  | parametros COMMA parametro
  ;

parametro
  : TIPO_NUMERO ID
  ;

bloco_funcao
  : INICIO DOT comandos_opt FIM DOT
  ;

bloco_principal
  : INICIO DOT comandos_opt FIM DOT
  ;

comandos_opt
  : comandos
  | /* vazio */
  ;

comandos
  : comandos comando
  | comando
  ;

comando
  : declaracao
  | atribuicao
  | atribuicao_elgio
  | enquanto
  | para
  | se
  ;

declaracao
  : TIPO_NUMERO ID DOT
  ;

atribuicao
  : ID ATRIB expressao DOT
  ;

atribuicao_elgio
  : ELGIO ATRIB expressao_sem_funcao DOT
  ;

enquanto
  : ENQUANTO expressao_logica DOT enquanto_corpo
  ;

enquanto_corpo
  : ENTAO DOT bloco_principal
  | ENTAO DOT comandos_opt FIM DOT
  | bloco_principal
  | comandos_opt FIM DOT
  ;

para
  : PARA ID limite_para DOT bloco_principal
  ;

limite_para
  : ID
  | INT
  ;

se
  : SE expressao_logica DOT ENTAO DOT bloco_principal SENAO DOT bloco_principal
  ;

expressao
  : operando expressao_cauda
  ;

expressao_cauda
  : operador_matematico operando expressao_cauda
  | /* vazio */
  ;

expressao_sem_funcao
  : operando_sem_funcao expressao_sem_funcao_cauda
  ;

expressao_sem_funcao_cauda
  : operador_matematico operando_sem_funcao expressao_sem_funcao_cauda
  | /* vazio */
  ;

operador_matematico
  : PLUS
  | MINUS
  | MULT
  | SLASH
  | EXP
  | MOD
  ;

operando
  : INT
  | ID
  | NADA
  | NEG operando
  | chamada_funcao
  ;

operando_sem_funcao
  : INT
  | ID
  | NADA
  | NEG operando_sem_funcao
  ;

chamada_funcao
  : FUNCAO LPAREN argumentos_opt RPAREN
  ;

argumentos_opt
  : argumentos
  | /* vazio */
  ;

argumentos
  : argumento
  | argumentos COMMA argumento
  ;

argumento
  : INT
  | ID
  | NADA
  ;

expressao_logica
  : operando_logico operador_relacional operando_logico
  ;

operando_logico
  : INT
  | ID
  | NADA
  ;

operador_relacional
  : MAIOR
  | MENOR
  | IGUAL
  | DIFERENTE diferente_sufixo
  | MIGUAL
  | MIGUALC
  ;

diferente_sufixo
  : DE
  | /* vazio */
  ;

%%
