class GameNS.Cards.CompiledCard
  constructor: (description) ->
    @parseTree: new GameNS.Cards.ParseTree(description) 
  