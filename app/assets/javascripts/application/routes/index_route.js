App.IndexRoute = Ember.Route.extend({
  model: function() {
    return App.get('currentUser');
  }
});