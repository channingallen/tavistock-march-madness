MarchMadness.IndexRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    controller.set('title', 'Home');
  }
});