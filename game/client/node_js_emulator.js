var Game = {};

var NodeEmulator = {
  requires: []
}

var includeJs = function(path) {
  path = path.replace(/^\.\//, "");
  NodeEmulator.requires.push(path);

  document.write('<script type="text/javascript" src="' + path  + '.js"></scr' + 'ipt>');
}