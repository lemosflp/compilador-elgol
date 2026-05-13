# Compilador Elgol — Analisador Léxico (Jison)

## Requisitos
- Windows
- Node.js **v20.x** (recomendado)
- npm

### Verificar versões
```powershell
node -v
npm -v
```

## Instalação
Na pasta do projeto:

```powershell
npm install
```
## Como executar

O projeto utiliza 2 arquivos:
- elgol.jison (gramática mínima)
- elgol.jisonlex (regras léxicas)

1. Gere o arquivo:

```powershell
npx jison .\elgol.jison .\elgol.jisonlex -o .\elgol-parser.js -m commonjs
```

2. Confirme que foi criado:

```powershell
dir .\elgol-parser.js
```

3. Rodar o analisador léxico (imprime tokens)

```powershell
node .\lex-run.js .\teste.elgol
```
Você vai ver tokens tipo: TIPO_NUMERO, FUNCAO, ID, INT, INICIO, FIM, DOT, etc.

Outros códigos para analisar:

```powershell
node .\lex-run.js .\ex1.elgol
node .\lex-run.js .\ex2.elgol
node .\lex-run.js .\ex3.elgol
node .\lex-run.js .\ex4.elgol
node .\lex-run.js .\ex5.elgol
```
