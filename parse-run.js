const fs = require("fs");
const path = require("path");

const parserMod = require("./elgol-parser");
const { lexAll } = require("./lex-run");

function getParser() {
  if (parserMod && typeof parserMod.parse === "function") return parserMod;
  if (parserMod && parserMod.parser && typeof parserMod.parser.parse === "function") {
    return parserMod.parser;
  }
  if (parserMod && typeof parserMod.Parser === "function") {
    return new parserMod.Parser();
  }
  throw new Error(
    "Parser não encontrado no módulo gerado. Keys do módulo: " +
      (parserMod ? Object.keys(parserMod).join(", ") : "(null)")
  );
}

function formatLine(error) {
  if (!error || !error.hash) return null;

  const hash = error.hash;
  if (hash.loc && typeof hash.loc.first_line === "number") {
    return hash.loc.first_line;
  }

  if (typeof hash.line === "number") {
    return hash.line + 1;
  }

  return null;
}

function main() {
  const fileArg = process.argv[2] || "ELGOL.TXT";
  const filePath = path.resolve(process.cwd(), fileArg);

  if (!fs.existsSync(filePath)) {
    console.error("Arquivo não encontrado:", filePath);
    process.exit(2);
  }

  const src = fs.readFileSync(filePath, "utf8");
  const lexerTokens = lexAll(src);
  const lexicalError = lexerTokens.find((tok) => tok.tokenLabel === "ERRO_LEXICO");

  if (lexicalError) {
    console.error(`Erro léxico na linha ${lexicalError.loc ? lexicalError.loc.first_line : "?"}.`);
    process.exit(1);
  }

  const parser = getParser();

  try {
    parser.parse(src);
    console.log("OK");
  } catch (error) {
    const line = formatLine(error);
    if (line !== null) {
      console.error(`Erro sintático na linha ${line}.`);
    } else {
      console.error("Erro sintático.");
    }
    process.exit(1);
  }
}

if (require.main === module) {
  main();
}

module.exports = {
  getParser,
  formatLine,
};
