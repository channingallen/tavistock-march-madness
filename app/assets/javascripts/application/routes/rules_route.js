App.RulesRoute = Ember.Route.extend({

  redirect: function() {
    var currentUser = App.get('currentUser');
    if (!currentUser || !currentUser.get('email')) this.transitionTo('form');
  }
});