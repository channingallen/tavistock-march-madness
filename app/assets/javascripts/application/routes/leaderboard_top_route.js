App.LeaderboardTopRoute = Ember.Route.extend({
  model: function() {
    return App.User.find();
  },
  renderTemplate: function() {
    this.render('leaderboard/leaderboard_rankings');
  }
});