App.LeaderboardTopRoute = Ember.Route.extend({
  model: function() {
    var users = App.store.find(App.User);
    users = users.toArray().slice(0, 100);
    return users;
  }
});