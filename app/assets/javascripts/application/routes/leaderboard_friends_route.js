App.LeaderboardFriendsRoute = Ember.Route.extend({

  redirect: function() {
    if (!App.get('currentUser')) this.transitionTo('leaderboard.top');
  },

  model: function() {
    var fbIds = [App.get('currentUser').get('fbId')],
      friendIds = App.get('friendIds');
    if (friendIds) {
      for (var i = 0; i < friendIds.length; i++) {
        fbIds.push(friendIds[i]);
      }
    }
    return App.User.find({ fb_id: fbIds});
  }.observes('App.friendIds'),

  setupController: function(controller, model) {
    controller.set('content', model);
  }.observes('App.friendIds')
});