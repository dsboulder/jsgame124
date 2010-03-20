describe "Parser", ->
  describe "+1 action", ->
    it "should create a parse tree", ->
      tree: GameNS.Cards.Parser.parse("+1 Action")
      expect(tree.length).toEqual(1)
