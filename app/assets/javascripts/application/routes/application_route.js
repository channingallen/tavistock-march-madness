App.ApplicationRoute = Ember.Route.extend({

  events: {
    login: App.helpers.facebook.promptForAuthorization
  }
});