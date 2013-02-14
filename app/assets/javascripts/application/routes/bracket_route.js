App.BracketRoute = Ember.Route.extend({
  model: function(params) {
    return App.get('currentUser').get('bracket');
  }
});