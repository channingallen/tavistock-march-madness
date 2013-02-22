App.FormRoute = Ember.Route.extend({

  model: function() {
    return App.get('currentUser');
  },

  setupController: function(controller, model) {
    controller.set('content', model);
  }
});