var sys = require('sys'),
    http = require('http'),
    fs = require('fs'),
    path = require('path'),
    paperboy = require('../../paperboy/paperboy'),
    game_mgr = require('./game_manager'),
    debug = require('../../node_debug/debug'),
    WEBROOT = path.join(path.dirname(__filename), "..");
process.mixin(GLOBAL, game_mgr);

debug.listen(8080);
function includeJs(path) {
  var filename = WEBROOT + path + ".js";
  sys.puts("Requiring " + filename);
  var fileData = fs.readFileSync(filename);
  process.compile(fileData, filename);
}
eval(fs.readFileSync("../includes.js"));
includeJs("/server/game_manager");

var faye = require('../../faye/faye');
var server = new faye.NodeAdapter({mount: '/faye', timeout: 45});

//server.getClient().subscribe("/games", function(msg) {
//})

http.createServer(function(req, res) {
  sys.puts("request");
  if (server.call(req, res)) return;
  if (req.url == "/games" && req.method.toLowerCase() == "post") {
    var newGame = GameManager.create();
    var json = Object.toJSON(newGame);
    res.sendHeader(200, {'Content-Type': 'application/json', 'Content-Length': json.length});
    res.write(json);
    res.close();
  }
  paperboy
      .deliver(WEBROOT, req, res)
      .before(function() {
    sys.puts('About to deliver: ' + req.url);
  })
      .after(function() {
    sys.puts('Delivered: ' + req.url);
  })
      .error(function() {
    sys.puts('Error delivering: ' + req.url);
  })
      .otherwise(function() {
    res.sendHeader(404, {'Content-Type': 'text/plain'});
    res.write('Hello, non-Faye request!');
    res.close();
  });
}).listen(9292);
