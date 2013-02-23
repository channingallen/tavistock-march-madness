App.IndexController = Ember.Controller.extend({

  currentUser: function() {
    this.set('content', App.get('currentUser'));
    return this.get('content');
  }.property('App.currentUser'),

  isAdmin: function() {
    var user = this.get('content');
    return _.contains(App.get('adminFbIds'), user.get('fbId'));
  }.property('content.fbId'),

  officialBracket: function() {
    return App.Bracket.find(1);
  }.property('content')

});