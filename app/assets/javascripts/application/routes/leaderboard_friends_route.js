App.LeaderboardFriendsRoute = Ember.Route.extend({
  model: function() {
    return App.store.find(App.User);
  }
});