MarchMadness.User = DS.Model.extend({
  name: DS.attr('string'),
  email: DS.attr('string'),
  score: DS.attr('number'),
  bracket: DS.belongsTo('MarchMadness.Bracket') // foreign key on bracket
});