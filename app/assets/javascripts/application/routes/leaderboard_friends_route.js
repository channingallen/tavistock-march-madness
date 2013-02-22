App.LeaderboardFriendsRoute = Ember.Route.extend({

  redirect: function() {
    if (!App.get('currentUser')) this.transitionTo('leaderboard.top');
  },

  model: function() {
    var currentUser = App.get('currentUser');
    if (!currentUser) return [];

    var users = App.User.find(),
      friendIds = App.get('friendIds'),
      friends = [currentUser];
    users.forEach(function(user) {
      if (_.contains(friendIds, user.get('fbId'))) {
        friends.push(user);
      }
    });

    return friends;
  }.observes('App.friendIds'),

  setupController: function(controller, model) {
    controller.set('content', model);
  }.observes('App.friendIds')
});
