class Dictionary
    constructor: (@originalWordList, grid) ->
        @setGrid grid if grid?

    setGrid: (@grid) ->
        @wordList = @originalWordList.slice(0) #slice(0)用来复制js数组
        @wordList = (word for word in @wordList when word.length <= @grid.size)
        @minWordLength = Math.min apply Math, (w.length for w in @wordList)
        @useWords = []
        for x in [0...@grid.size]
            for y in [0...@grid.size]
                @markUsed word for word in @wordsThroughTile x, y

    markUsed: (str) ->
        if str in @useWords
            false
        else
            @useWords.push str
            true

    isWord: (str) -> str in @wordList
    isNewWord: (str) -> str in @wordList and str not in @useWords

    root = exports ? window
    root.Dictionary = Dictionary
