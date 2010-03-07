sys:      require "sys"
http:     require "http"
fs:       require "fs"
path:     require "path"
paperboy: require "../../paperboy/paperboy"
game_mgr: require "./game_manager"
faye:     require('../../faye/faye')
WEBROOT:  path.join(path.dirname(__filename), "..")

process.mixin(GLOBAL, game_mgr)

includeJs: (path) ->
  filename: WEBROOT + path + ".js"
  sys.puts("Requiring " + filename)
  fileData: fs.readFileSync(filename)
  process.compile(fileData, filename)


eval(fs.readFileSync("../includes.js"))
includeJs("/server/game_manager")

server: new faye.NodeAdapter {mount: '/faye', timeout: 45}

server: http.createServer (req, res) ->
  sys.puts("request")
  return if server.call(req, res)
  if req.url == '/games' and req.method.toLowerCase() == "post"
    newGame: GameManager.create
    json: Object.toJSON(newGame)
    res.sendHeader(200, {'Content-Type': 'application/json', 'Content-Length': json.length})
    res.write(json)
    res.close()
  paperboy
    .deliver(WEBROOT, req, res)
    .before ->
      sys.puts('About to deliver: ' + req.url)
    .error ->
      sys.puts('Error delivering: ' + req.url)
    .otherwise ->
      res.sendHeader(404, {'Content-Type': 'text/plain'})
      res.write('Hello, non-Faye request!')
      res.close()
  
server.listen 9292 