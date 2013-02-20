App.LeaderboardFriendsController = Ember.ArrayController.extend({
  users: function() {
    var fbIds = [App.get('currentUser').get('fbId')],
      friendIds = App.get('friendIds');
    if (friendIds) {
      for (var i = 0; i < friendIds.length; i++) {
        fbIds.push(friendIds[i]);
      }
    }

    return App.User.find({ fb_id: fbIds});
  }.property('App.friendIds')
});