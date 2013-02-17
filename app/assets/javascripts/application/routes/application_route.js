App.ApplicationRoute = Ember.Route.extend({

  events: {

    /**
     * Prompts the user to authenticate our application.
     */
    login: function() {
      FB.login(function(response) {
        if (response.authResponse) {
          FB.api('/me', function(response) {
            console.log(response);
            window.infoResponse = response;
          });
        }
      }, { scope: 'user_likes' });
    }
  }
});