App.BracketRoute = Ember.Route.extend({
  model: function(params) {
    return App.Bracket.find(params.bracket_id);
  },
  setupController: function(controller, model) {
    controller.set('content', model);
  }
});