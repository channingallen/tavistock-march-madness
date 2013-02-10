MarchMadness.LeaderboardRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    controller.set('title', 'Leaderboard');
  }
});