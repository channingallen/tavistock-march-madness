App.LeaderboardFriendsRoute = Ember.Route.extend({
  model: function() {
    var users = App.store.find(App.User);
    users = users.toArray().slice(0, 100);
    return users;
  },
  renderTemplate: function() {
    this.render('leaderboard/leaderboard_rankings');
  }
});