App.LeaderboardFriendsController = Ember.ArrayController.extend({
  sortProperties: ['rank'],
  sortAscending: true,

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
      if (_.contains(friendIds, user.get('fbId'))) {
        friends.push(user);
      }
    });

    this.set('content', friends);
  }.observes('App.friendIds')

});
