App.LeaderboardController = Ember.ArrayController.extend({
  sortProperties: ['score'],
  sortAscending: false,

  currentUser: function() {
    return App.get('currentUser');
  }.property('App.currentUser'),

  isActive: function() {
    return true;
  }
});