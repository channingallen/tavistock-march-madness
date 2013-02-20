App.ApplicationRoute = Ember.Route.extend({

  events: {
    login: function() {
      App.helpers.facebook.promptForAuthorization();
    }
  }
});