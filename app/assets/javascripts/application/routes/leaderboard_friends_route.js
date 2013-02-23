App.LeaderboardFriendsRoute = Ember.Route.extend({

  redirect: function() {
    var currentUser = App.get('currentUser');
    if (!currentUser || !currentUser.get('email')) this.transitionTo('form');
  },

  model: function() {
    var currentUser = App.get('currentUser');
    if (!currentUser) return [];

    var users = App.User.find(),
      friendIds = App.get('friendIds'),
      friends = [currentUser];
    users.forEach(function(user) {
      if (user.get('restaurantId') == currentUser.get('restaurantId') &&
          user.get('restaurantLocation') == currentUser.get('restaurantLocation') &&
          _.contains(friendIds, user.get('fbId'))) {
        friends.push(user);
      }
    });

    return friends;
  }.observes('App.friendIds'),

  setupController: function(controller, model) {
    controller.set('content', model);
  }.observes('App.friendIds')
});
