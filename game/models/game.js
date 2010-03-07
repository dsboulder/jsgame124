var Game = Class.create({
  players: [],
  turnNumber: 0,
  activePlayer: undefined,
  phase: "waiting",
  id: undefined,

  initialize: function(params) {
    Object.extend(this, params);
  },

  join: function(userId) {
    this.players.push(userId);
  }
});
