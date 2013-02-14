App.Game = DS.Model.extend({
  score: DS.attr('number'),
  roundNumber: DS.attr('number'),
  teamOne: DS.belongsTo('App.Team'),
  teamTwo: DS.belongsTo('App.Team'),
  winningTeam: DS.belongsTo('App.Team'),
  nextGame: DS.belongsTo('App.Game'),
  bracket: DS.belongsTo('App.Bracket')
});