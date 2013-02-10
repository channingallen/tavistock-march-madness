MarchMadness.Bracket = DS.Model.extend({
  isOfficial: DS.attr('boolean'),
  user: DS.belongsTo('MarchMadness.User'),
  games: DS.hasMany('MarchMadness.Game')
});