App.Bracket = DS.Model.extend({
  isOfficial: DS.attr('boolean'),
  user: DS.belongsTo('App.User'),
  games: DS.hasMany('App.Game')
});