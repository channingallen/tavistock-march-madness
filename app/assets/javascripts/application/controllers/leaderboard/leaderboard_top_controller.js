App.LeaderboardTopController = Ember.ArrayController.extend({
  sortProperties: ['rank'],
  sortAscending: true,

  users: function() {
    return this.get('arrangedContent');
  }.property('content.@each')
});