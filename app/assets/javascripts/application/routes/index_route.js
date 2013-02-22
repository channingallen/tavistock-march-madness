App.IndexRoute = Ember.Route.extend({

  redirect: function() {
    var currentUser = App.get('currentUser');
    if (!currentUser.get('email')) this.transitionTo('form');
  },

  model: function() {
    return App.get('currentUser');
  },

  setupController: function(controller, model) {
    controller.set('content', model);
  }
});