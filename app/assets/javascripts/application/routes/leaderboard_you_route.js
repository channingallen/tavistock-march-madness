App.LeaderboardYouRoute = Ember.Route.extend({

  redirect: function() {
    var currentUser = App.get('currentUser');
    if (!currentUser.get('email')) this.transitionTo('form');
  },

  model: function() {
    var currentUser = App.get('currentUser');
    return currentUser ?
           App.User.find({ near_user: currentUser.get('id') }) :
           [];
  },

  setupController: function(controller, model) {
    controller.set('content', model);
  },

  renderTemplate: function() {
    this.render('leaderboard/leaderboard_rankings');
  }
});