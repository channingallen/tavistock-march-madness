App.LeaderboardYouController = Ember.ArrayController.extend({
  users: function() {
    var users = this.get('content'),
      index = users.indexOf(App.get('currentUser')),
      numToShow = 11;

    return users.filter(function(user, i) {
      return ((i >= index - Math.floor(numToShow / 2)) &&
              (i <= index + Math.floor(numToShow / 2)));
    });
  }.property('content.@each')
});