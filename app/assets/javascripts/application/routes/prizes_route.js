App.PrizesRoute = Ember.Route.extend({

  redirect: function() {
    var currentUser = App.get('currentUser');
    if (!currentUser.get('email')) this.transitionTo('form');
  }
});