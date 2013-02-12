MarchMadness.Game = DS.Model.extend({
  teamOne: DS.belongsTo('MarchMadness.Team'),
  teamTwo: DS.belongsTo('MarchMadness.Team'),
  winningTeam: DS.belongsTo('MarchMadness.Team'),
  nextGame: DS.belongsTo('MarchMadness.Game'),
  bracket: DS.belongsTo('MarchMadness.Bracket')
});