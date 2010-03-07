class Game.GameManager
  games: []

  createGame: ->
    newGame: new Game.Game({id: Math.uuid()})
    GameManager.games.push newGame
    newGame