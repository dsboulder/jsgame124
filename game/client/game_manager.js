GameManager = {
  currentGame: null,
  username: null,

  setUsername: function(username) {
    if (username != this.username) {
      if (this.username) {
        window.fayeClient.unsubscribe("/users/" + this.username);
      }
      this.username = username;
      window.fayeClient.subscribe("/users/" + this.username);
    }
  },
  
  create: function() {
    jQuery.ajax({
      url:"/games",
      type:"post",
      dataType: "json",
      success: function(gameJSON) {
        console.debug("Created", gameJSON);
        GameManager.currentGame = new Game.Game(gameJSON);
      }
    });
  }
};