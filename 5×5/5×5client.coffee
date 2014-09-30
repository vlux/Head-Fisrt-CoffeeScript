$(document).ready ->
    $('#grid li').live 'click', tileClick        #live只需要创建一个事件
    socket = new io.Socket()
    socket.connect()
    socket.on 'connect', -> showMessage 'waitForConnection'
    socket.on 'message', handleMessage
    #我们只需要处理两种消息：初始的欢迎信息和每次移动的结果信息

handleMessage = (message) ->
    {type, content} = typeAndContent message
    switch type
        when 'welcome'
            {players, currPlayerNum, tiles, yourNum: myNum} = JSON.parse content
            startGame players, currPlayerNum
        when 'moveResult'
            {player, swapCoordinates, moveScore, newWords} =JSON.PARSE CONTENT
            showMoveResult player, swapCoordinates, moveScore, newWords

startGame = (player, currPlayerNum) ->
    for player in players
        $("#p#{player.num}name").html player.name
        $("#p#{player.num}score").html player.score
    drawTiles()
    if myNum is currPlayerNum
        startTurn()
    else
        endTurn()

showMoveResult = (player, swapCoordinates, moveScore, newWords) ->
    $("#p#{player.num}score").html player.score
    $notice = $('<p class = "notice"></p>')
    if moveScore is 0
        $notice.html "#{player.name} formed no words this turn"
    else
        $notice.html """
            #{player.name} formed the following #{newWords.length} word(s):<br />
            <b> #{newWords.join(', ')}</b><br />
            earning <b>#{moveScore / newWords.length}×#{newWords.length}
            = #{moveScore} </b> points!
        """
    showThenFade $notice
    swapTiles swapCoordinates
    if player.num isnt myNum then startTurn
