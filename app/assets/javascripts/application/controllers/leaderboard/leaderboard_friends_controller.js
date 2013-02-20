App.LeaderboardFriendsController = Ember.ArrayController.extend({
  sortProperties: ['score'],
  sortAscending: false,

  users: function() {
    return this.get('arrangedContent');
  }.property('content.@each'),


  updateContent: function() {
    var fbIds = [App.get('currentUser').get('fbId')],
      friendIds = App.get('friendIds');
    if (friendIds) {
      for (var i = 0; i < friendIds.length; i++) {
        fbIds.push(friendIds[i]);
      }
    }
    this.set('content', App.User.find({ fb_id: fbIds}));
  }.observes('App.friendIds')


});