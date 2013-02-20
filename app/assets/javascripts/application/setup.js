window.App = Ember.Application.create({

  // An object containing helper functions.
  helpers: {},

  // An array of the Facebook IDs of the user's Facebook friends.
  friendIds: [],

  ready: function() {
    App.bindings();
  }
});