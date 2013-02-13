App.LeaderboardYouRoute = Ember.Route.extend({
  model: function() {
    var users = App.store.find(App.User),
      usersArr = users.toArray(),
      index = 0,
      numToShow = 15;
    _.each(usersArr, function(user, i) {
      if (user == App.get('currentUser')) index = i;
    });
    users = _.filter(usersArr, function(user, i) {
      return ((i >= index - Math.floor(numToShow / 2)) &&
              (i <= index + Math.floor(numToShow / 2)));
    });
    return users;
  }
});