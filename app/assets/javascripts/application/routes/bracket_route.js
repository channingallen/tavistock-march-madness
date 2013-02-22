App.BracketRoute = Ember.Route.extend({

  redirect: function() {
    var currentUser = App.get('currentUser');
    if (!currentUser || !currentUser.get('email')) this.transitionTo('form');
  },

  model: function(params) {
    return App.Bracket.find(params.bracket_id);
  },

  setupController: function(controller, model) {
    controller.set('content', model);
  }
});