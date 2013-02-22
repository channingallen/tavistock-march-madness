App.LeaderboardTopRoute = Ember.Route.extend({

  redirect: function() {
    var currentUser = App.get('currentUser');
    if (!currentUser.get('email')) this.transitionTo('form');
  },

  model: function() {
    var currentUser = App.get('currentUser');
    return App.User.find({
      sort: 'score',
      order: 'DESC',
      limit: 10,
      restaurant_id: currentUser.get('restaurantId'),
      restaurant_location: currentUser.get('restaurantLocation')
    });
  },

  setupController: function(controller, model) {
    controller.set('content', model);
  },

  renderTemplate: function() {
    this.render('leaderboard/leaderboard_rankings');
  }
});