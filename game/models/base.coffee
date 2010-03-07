class Game.Base
  constructor: (params) ->
    for propertyName, propertyValue of params
      this[propertyName]: propertyValue
