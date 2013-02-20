App.Game = DS.Model.extend({

  /**
   * Properties from the server.
   */
  score: DS.attr('number'),
  roundNumber: DS.attr('number'),
  teamOne: DS.belongsTo('App.Team'),
  teamTwo: DS.belongsTo('App.Team'),
  winningTeam: DS.belongsTo('App.Team'),
  nextGame: DS.belongsTo('App.Game'),
  siblingGame: DS.belongsTo('App.Game'),
  bracket: DS.belongsTo('App.Bracket'),
  previousGames: DS.hasMany('App.Game'),

  /**
   * Helpers for building the classes for game elements.
   */
    
  todo: function() {
    var teamOne = this.get('teamOne'),
      teamTwo = this.get('teamTwo'),
      winningTeam = this.get('winningTeam'),
      roundNum = this.get('roundNumber'),
      hasPreviousGames = this.get('previousGames'),
      todoRound1 = (roundNum == 1 && !winningTeam),
      todoRound2Top = (roundNum == 2 && hasPreviousGames && teamTwo &&
                       !winningTeam),
      todoRound2Norm = (roundNum == 2 && !hasPreviousGames &&
                        (!teamOne || !teamTwo || !winningTeam)),
      todoRound3Plus = (roundNum > 2 && !winningTeam && (teamOne || teamTwo));
    return !!(todoRound1 || todoRound2Top || todoRound2Norm || todoRound3Plus);
  }.property('teamOne', 'teamTwo', 'winningTeam', 'roundNum'),

  teamOneWon: function() {
    var teamOne = this.get('teamOne'),
      winningTeam = this.get('winningTeam');
    return (teamOne && teamOne == winningTeam);
  }.property('teamOne', 'winningTeam'),

  teamTwoWon: function() {
    var teamTwo = this.get('teamTwo'),
      winningTeam = this.get('winningTeam');
    return (teamTwo && teamTwo == winningTeam);
  }.property('teamTwo', 'winningTeam'),

  pointsAwarded: function() {
    return !!this.get('score');
  }.property('score'),

  /**
   * Recursively updates the next game (and the next, and the next...) based on
   * the properties of this game. Useful for optimistic UI updates, so we don't
   * have to wait on the server.
   */
  updateNextGame: function() {
    var nextGame = this.get('nextGame'),
      sibling = this.get('siblingGame'),
      roundNumber = this.get('roundNumber');
    if (nextGame && (sibling || roundNumber == 1)) {
      var winningTeam = this.get('winningTeam'),
        teamAttr;
      if (sibling) {
        teamAttr = this.get('id') < sibling.get('id') ? 'teamOne' : 'teamTwo';
      } else {
        teamAttr = 'teamTwo';
      }
      if (nextGame.get(teamAttr) != winningTeam) {
        if (nextGame.get('winningTeam') == nextGame.get(teamAttr)) {
          nextGame.set('winningTeam', null);
        }
        nextGame.set(teamAttr, winningTeam);
        nextGame.updateNextGame();
        return;
      }
    }

    // Once we're done making ALL updates (which is the only time the following
    // line will be run), push the changes to the server.
    App.helpers.commit();
  }
  
});