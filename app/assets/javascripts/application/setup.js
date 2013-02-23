window.App = Ember.Application.create({

  // An object containing helper functions.
  helpers: {},

  // An array of the Facebook IDs of the user's Facebook friends.
  friendIds: [],

  // An array of the Facebook IDs of admin accounts.
  // 707419 - Courtland Allen
  // 4930013 - Channing Allen
  // 1038690087 - Melissa Chen
  adminFbIds: ['707419', '4930013', '1038690087'],

  ready: function() {
    App.bindings();
  }
});