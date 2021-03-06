App.LeaderboardFriendsController = Ember.ArrayController.extend({
  sortProperties: ['rank'],
  sortAscending: true,

  tournamentPhase: function() {
    return App.get('phase') == 'tournament';
  }.property('App.phase'),

  users: function() {
    return this.get('arrangedContent');
  }.property('content.@each'),

  updateContent: function() {
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

    this.set('content', friends);
  }.observes('App.friendIds')

});
