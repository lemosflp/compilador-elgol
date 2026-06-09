# Compilador Elgol — Analisador Léxico (Jison)

## Requisitos
- Node.js **v20.x** (recomendado)
- npm

### Verificar versões
```bash
node -v
npm -v
```

## Instalação
Na pasta do projeto:

```bash
npm install
```
## Como executar

O projeto utiliza 2 arquivos:
- elgol.jison (gramática mínima)
- elgol.jisonlex (regras léxicas)
- elgol-parser.js (parser já gerado e versionado no repositório)

1. Rodar o analisador léxico (imprime tokens)

```bash
node ./lex-run.js ./teste.elgol
```
Você vai ver tokens tipo: TIPO_NUMERO, FUNCAO, ID, INT, INICIO, FIM, DOT, etc.

2. Rodar o analisador sintático

```bash
node ./parse-run.js ./teste.elgol
```

Se o arquivo estiver correto, o comando imprime `OK`. Se houver erro, ele informa a linha.

Outros códigos para analisar:

```bash
node ./lex-run.js ./ex1.elgol
node ./lex-run.js ./ex2.elgol
node ./lex-run.js ./ex3.elgol
node ./lex-run.js ./ex4.elgol
node ./lex-run.js ./ex5.elgol
```
