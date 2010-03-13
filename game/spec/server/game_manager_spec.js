(function(){
  describe("GameManager", function() {
    beforeEach(function() {
      return this.gameManager = new Game.GameManager();
    });
    return describe("#createGame", function() {
      return it("should assign a UUID", function() {
        var game;
        game = this.gameManager.createGame();
        sys.puts(game.id);
        return expect(game).id.length.toBeGreaterThan(10);
      });
    });
  });
})();
