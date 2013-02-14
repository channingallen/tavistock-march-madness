App.Game = DS.Model.extend({
  score: DS.attr('number'),
  roundNumber: DS.attr('number'),
  teamOne: DS.belongsTo('App.Team'),
  teamTwo: DS.belongsTo('App.Team'),
  winningTeam: DS.belongsTo('App.Team'),
  nextGame: DS.belongsTo('App.Game'),
  bracket: DS.belongsTo('App.Bracket'),

  /**
   * Helpers for building the classes for game elements.
   */
    
  todo: function() {
    var teamOne = this.get('teamOne'),
      teamTwo = this.get('teamTwo'),
      winningTeam = this.get('winningTeam'),
      roundNumber = this.get('roundNumber'),
      todoRound2 = (roundNumber == 2 && (!teamOne || !teamTwo || !winningTeam)),
      todoRound3Plus = (roundNumber > 2 && !winningTeam && teamOne && teamTwo);
    return !!(todoRound2 || todoRound3Plus);
  }.property('teamOne', 'teamTwo', 'winningTeam', 'roundNumber'),

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
  }.property('score')
  
});