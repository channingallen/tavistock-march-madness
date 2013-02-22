App.User = DS.Model.extend({
  name: DS.attr('string'),
  email: DS.attr('string'),
  phone: DS.attr('string'),
  score: DS.attr('number'),
  gender: DS.attr('string'),
  restaurantId: DS.attr('string'),
  contactAllowed: DS.attr('boolean'),
  timezone: DS.attr('string'),
  rank: DS.attr('number'),
  fbUsername: DS.attr('string'),
  fbAccessToken: DS.attr('string'),
  fbId: DS.attr('string'),
  bracket: DS.belongsTo('App.Bracket') // foreign key on bracket
});