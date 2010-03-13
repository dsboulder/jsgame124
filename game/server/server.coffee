Game:     {}
sys:      require "sys"
http:     require "http"
fs:       require "fs"
path:     require "path"
url:      require "url"
faye:     require('../../faye/faye')
WEBROOT:  path.join(path.dirname(__filename), "..")

includeJs: (path) ->
  filename: WEBROOT + path + ".js"
  sys.puts("Requiring " + filename)
  fileData: fs.readFileSync(filename)
  eval(fileData)
#  process.compile(fileData, filename)


#eval(fs.readFileSync("../lib/uuid.js"))
#eval(fs.readFileSync("../lib/json2.js"))
#eval(fs.readFileSync("../models/base.js"))
#eval(fs.readFileSync("../models/game.js"))
#eval(fs.readFileSync("./game_manager.js"))
eval(fs.readFileSync("../includes.js"))
includeJs("/server/classes/game_manager")

fayeServer: new faye.NodeAdapter {mount: '/faye', timeout: 45}
gameManager: new Game.GameManager()

server: http.createServer (req, res) ->
  sys.puts("request: " + req.url)
  return if fayeServer.call(req, res)
  
  if req.url == '/games' and req.method.toLowerCase() == "post"
    newGame: gameManager.createGame()
    json: JSON.stringify(newGame)
    res.sendHeader(200, {'Content-Type': 'application/json', 'Content-Length': json.length})
    res.write(json)
    res.close()
    return

  static_filename: path.join(WEBROOT, url.parse(req.url).pathname)
  fs.stat static_filename, (err, stat) ->
    if err
      sys.puts "  NotFound " + static_filename
      res.sendHeader(404, {'Content-Type': 'text/plain'})
      res.write('Not found')
      res.close()
    else
      sys.puts "  Found " + static_filename
      fs.readFile static_filename, (err, data) ->
        res.sendHeader(200, {'Content-Type': 'text/html'})
        res.write(data)
        res.close()
server.listen 9292 