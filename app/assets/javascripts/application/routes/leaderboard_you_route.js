App.LeaderboardYouRoute = Ember.Route.extend({

  redirect: function() {
    if (!App.get('currentUser')) this.transitionTo('leaderboard.top');
  },

  model: function() {
    return App.User.find(); // TODO:
  },

  // TODO: Don't we need a setupController fn?

  renderTemplate: function() {
    this.render('leaderboard/leaderboard_rankings');
  }
});