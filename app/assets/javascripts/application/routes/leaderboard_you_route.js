App.LeaderboardYouRoute = Ember.Route.extend({

  redirect: function() {
    if (!App.get('currentUser')) this.transitionTo('leaderboard.top');
  },

  model: function() {
    var currentUser = App.get('currentUser');
    return App.User.find({ near_user: currentUser.get('id') });
  },

  setupController: function(controller, model) {
    controller.set('content', model);
  },

  renderTemplate: function() {
    this.render('leaderboard/leaderboard_rankings');
  }
});