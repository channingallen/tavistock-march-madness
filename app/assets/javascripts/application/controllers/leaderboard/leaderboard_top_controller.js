App.LeaderboardTopController = Ember.ArrayController.extend({
  sortProperties: ['score'],
  sortAscending: false,

  users: function() {
    return this.get('arrangedContent');
  }.property('content.@each')
});