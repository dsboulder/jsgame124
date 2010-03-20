class GameNS.Cards.CardTemplate
  constructor: (name, author, description) ->
    @name: name
    @author: author
    @description: description
    @compiledCard: new GameNS.Cards.CompiledCard(description)

  getCompiledCard: ->
    @compiledCard