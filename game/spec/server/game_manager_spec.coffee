describe "GameManager", ->
  beforeEach ->
    @gameManager: new Game.GameManager()
    
  describe "#createGame", ->
    it "should assign a UUID", ->
      game: @gameManager.createGame();
      sys.puts game.id
      expect(game).id.length.toBeGreaterThan(10)
