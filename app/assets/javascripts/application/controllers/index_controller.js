App.IndexController = Ember.Controller.extend({

  currentUser: function() {
    this.set('content', App.get('currentUser'));
    return this.get('content');
  }.property('App.currentUser')

});