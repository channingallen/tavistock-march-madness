App.BracketRoute = Ember.Route.extend({
  setupController: function(controller) {
    var currentUser = App.get('currentUser');
    controller.set('content', currentUser.get('bracket'));
  }
});