App.LeaderboardTopController = Ember.ArrayController.extend({
  sortProperties: ['score'],
  sortAscending: false,

  users: function() {
    var users = this.get('content');
    return users.toArray().slice(0, 100);
  }.property('content.@each')
});