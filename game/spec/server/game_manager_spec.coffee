describe "GameManager", ->
  beforeEach ->
    @gameManager: new GameNS.GameManager()

  describe "#createGame", ->
    it "should assign a UUID", ->
      game: @gameManager.createGame();
      expect(game.id.length).toBeGreaterThan(10)
