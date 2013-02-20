window.App = Ember.Application.create({

  // An object containing helper functions.
  helpers: {},

  ready: function() {
    App.bindings();
    App.helpers.facebook.checkLogin();
  }
});