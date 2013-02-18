App.LeaderboardTopRoute = Ember.Route.extend({

  model: function() {
    return App.User.find();
  },

  // TODO: Don't we need a setupController fn?

  renderTemplate: function() {
    this.render('leaderboard/leaderboard_rankings');
  }
});