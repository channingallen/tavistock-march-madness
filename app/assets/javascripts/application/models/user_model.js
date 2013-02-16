App.User = DS.Model.extend({
  name: DS.attr('string'),
  email: DS.attr('string'),
  score: DS.attr('number'),
  gender: DS.attr('string'),
  timezone: DS.attr('string'),
  fb_username: DS.attr('string'),
  fb_id: DS.attr('string'),
  bracket: DS.belongsTo('App.Bracket') // foreign key on bracket
});