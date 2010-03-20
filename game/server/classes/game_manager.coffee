class GameNS.GameManager
  games: []

  createGame: ->
    newGame: new GameNS.Game({id: Math.uuid()})
    @games.push newGame
    newGame