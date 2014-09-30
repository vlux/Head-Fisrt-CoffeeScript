connect = require 'connect'

#将connect的complier连到static中间件上
app = connect.createServer(
    connect.compiler(src: __dirname + '/client', enable: ['coffeescript']),
    connect.static(__dirname + '/client'),
    connect.errorHandler dumpExceptions: true, showStack: true
)

port = 3000
app.listen port
console.log "Browse to localhost:#{port} to play"

io = require 'socket.io'
socket = io.listen app
socket.on 'connection', (client) ->
    if assignToGame client
        client.on 'message', (message) -> handleMessage client, message
        client.on 'disconnect', ->removeFromGame client
    else
        client.send 'full'

game = new Game
idClientMap = {}

assignToGame = (client) ->
    idClientMap[client.sessionId] = client
    return false if game.isFull()
    game.addPlayer client.sessionId
    if game.isFull() then welcomePlayers()
    true

welcomePlayers = ->
    players = [game.player1, game.player2]
    info = {players, tiles: game.grid.tiles, currPlayerNum: game.currPlayer.num}
    for player in players
        playerinfo = extend {}, info, {yourNum: player.num}
        idClientMap[player.id].send "welcome:#{JSON.stringify playerinfo}"

extend = (a, others...) ->
    for o in others
        a[key] = val for key, val of o
    a

handleMessage = (client, message) ->
    {type, content} = typeAndContent message
    if type is 'move'
        return unless client.sessionId is game.currPlayer.id  #no cheating!
        swapCoordinates = JSON.parse content
        {moveScore, newWords} = game.currPlayer.makeMove swapCoordinates
        result = {swapCoordinates, moveScore, newWords, player: game.currPlayer}
        socket.broadcast "moveResult:#{JSON.stringify result}"
        game.endTurn()
