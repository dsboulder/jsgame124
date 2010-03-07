class GameManager
  games: []

  create: ->
    newGame: new Game({id: Math.uuid()})
    GameManager.games.push newGame
    newGame