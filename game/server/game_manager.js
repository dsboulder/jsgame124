GameManager = {
  games: [],

  create: function() {
    var newGame = new Game({id: Math.uuid()});
    GameManager.games.push(newGame);
    return newGame;
  }
}