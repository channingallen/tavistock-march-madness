App.LeaderboardTopRoute = Ember.Route.extend({
  model: function() {
    return App.store.find(App.User);
  }
});