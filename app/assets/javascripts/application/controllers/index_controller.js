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
    var officialBracketId = this.get('officialBracketId');
    if (officialBracketId) {
      return App.Bracket.find(officialBracketId);
    } else {
      var results = App.Bracket.find({ is_official: true }),
        controller = this;
      results.on('didLoad', function() {
        controller.set('officialBracketId', this.get('content')[0].id);
      });
      return false;
    }
  }.property('officialBracketId')

});