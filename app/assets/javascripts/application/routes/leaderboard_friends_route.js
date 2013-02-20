App.LeaderboardFriendsRoute = Ember.Route.extend({

  redirect: function() {
    if (!App.get('currentUser')) this.transitionTo('leaderboard.top');
  },

  renderTemplate: function() {
    this.render('leaderboard/leaderboard_rankings');
  }
});