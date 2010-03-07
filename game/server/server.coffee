sys:      require "sys"
http:     require "http"
fs:       require "fs"
path:     require "path"
url:      require "url"
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

fayeServer: new faye.NodeAdapter {mount: '/faye', timeout: 45}

server: http.createServer (req, res) ->
  sys.puts("request: " + req.url)
  return if fayeServer.call(req, res)
  if req.url == '/games' and req.method.toLowerCase() == "post"
    newGame: GameManager.create
    json: Object.toJSON(newGame)
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