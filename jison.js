//Run with node to compile parser from JISON & JISONLEX files
var fs = require("fs");
var jison = require("./jison/lib/jison");

var grammar = require("./jison/lib/jison/bnf").parse(fs.readFileSync("card.jison"));
var opt = grammar.options || {};
opt.moduleName = "GameNS.Cards.Parser";

grammar.lex = require("./jison/lib/jison/jisonlex").parse(fs.readFileSync("card.jisonlex"));

if (!opt.moduleType)
  opt.moduleType = "commonjs";

var generator = new jison.Jison.Generator(grammar, opt);
fname = "game/models/cards/parser.js",
source = generator.generate(opt),

fs.writeFileSync(fname, source);
