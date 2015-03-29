{Vote, Receiver, Option} = require './models'

class ConnectionMap
  constructor: ->
    @map = new Map

  addConnection: (receiver, connection) ->
    conns = @map.get(receiver) ? []
    @map.set(receiver, conns.concat([connection]))

    connection.once 'close', =>
      conns = @map.get(receiver) ? []
      index = conns.indexOf(connection)
      conns.splice(index, 1) if index isnt -1

  getConnections: (receiver) ->
    @map.get(receiver) ? []

exports.voteConns = new ConnectionMap
exports.receiverConns = new ConnectionMap
