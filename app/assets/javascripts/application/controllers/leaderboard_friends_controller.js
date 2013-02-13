App.LeaderboardFriendsController = Ember.ArrayController.extend({
  users: function() {
    var users = this.get('content');
    return users.toArray().slice(0, 100);
  }.property('content.@each')
});