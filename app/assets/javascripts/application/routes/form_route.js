App.FormRoute = Ember.Route.extend({

  model: function() {
    var currentUser = App.get('currentUser');
    if (!currentUser) App.helpers.facebook.promptForAuthorization();
    return currentUser;
  },

  setupController: function(controller, model) {
    controller.set('content', model);
  }
});