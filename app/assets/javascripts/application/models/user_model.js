App.User = DS.Model.extend({
  name: DS.attr('string'),
  email: DS.attr('string'),
  score: DS.attr('number'),
  gender: DS.attr('string'),
  timezone: DS.attr('string'),
  fbUsername: DS.attr('string'),
  fbAccessToken: DS.attr('string'),
  fbId: DS.attr('string'),
  bracket: DS.belongsTo('App.Bracket') // foreign key on bracket
});