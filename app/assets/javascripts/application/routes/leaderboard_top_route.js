App.LeaderboardTopRoute = Ember.Route.extend({

  model: function() {
    return App.User.find({ sort: 'score', order: 'DESC', limit: 10 });
  },

  setupController: function(controller, model) {
    controller.set('content', model);
  },

  renderTemplate: function() {
    this.render('leaderboard/leaderboard_rankings');
  }
});