const fs = require("fs");
const path = require("path");

const mod = require("./elgol-parser");

function createLexer() {
  if (mod && typeof mod.Parser === "function") {
    const p = new mod.Parser();
    if (p && p.lexer) return p.lexer;
  }

  if (mod && mod.lexer) return mod.lexer;
  if (mod && mod.parser && mod.parser.lexer) return mod.parser.lexer;
  if (mod && mod.Parser && mod.Parser.prototype && mod.Parser.prototype.lexer) {
    return mod.Parser.prototype.lexer;
  }

  return null;
}

function tokenName(tok) {
  return typeof tok === "string" ? tok : `#${tok}`;
}

function lexAll(input, { maxTokens = 200000 } = {}) {
  const lx = createLexer();
  if (!lx) {
    throw new Error(
      "Lexer não encontrado no módulo gerado. Keys do módulo: " +
        (mod ? Object.keys(mod).join(", ") : "(null)")
    );
  }

  lx.setInput(input);

  const out = [];
  for (let i = 0; i < maxTokens; i++) {
    const tok = lx.lex();

    // stop conditions (EOF real ou EOF “numérico” com yytext vazio)
    if (tok === "EOF") break;
    if (typeof tok === "number" && lx.yytext === "") break;

    const loc = lx.yylloc
      ? {
          first_line: lx.yylloc.first_line,
          first_column: lx.yylloc.first_column,
        }
      : null;

    out.push({
      token: tok,
      tokenLabel: tokenName(tok),
      text: lx.yytext,
      loc,
    });
  }

  return out;
}

function main() {
  const fileArg = process.argv[2] || "ELGOL.TXT";
  const filePath = path.resolve(process.cwd(), fileArg);

  if (!fs.existsSync(filePath)) {
    console.error("Arquivo não encontrado:", filePath);
    process.exit(2);
  }

  const src = fs.readFileSync(filePath, "utf8");
  const tokens = lexAll(src);

  for (const t of tokens) {
    const loc = t.loc ? ` @${t.loc.first_line}:${t.loc.first_column}` : "";
    const text = String(t.text).replace(/\r?\n/g, "\\n");
    console.log(`${t.tokenLabel.padEnd(14)} "${text}"${loc}`);
  }
}

main();