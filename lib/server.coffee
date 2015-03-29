ws = require 'nodejs-websocket'

server = ws.createServer (conn) ->
  console.log("New connection")

server.listen(8001)
