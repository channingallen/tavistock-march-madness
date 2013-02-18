App.ApplicationRoute = Ember.Route.extend({

  events: {

    /**
     * Prompts the user to authorize the app to access his Facebook account. If
     * he approves, creates a user record on our server.
     */
    login: function() {

      // Prompt the user to authorize our app with permission to access Likes.
      var scopeObj = { scope: 'user_likes' };
      FB.login(function(loginResponse) {

        // If the user authorizes our app...
        if (loginResponse.authResponse) {
          var accessToken = loginResponse.authResponse.accessToken;

          // ...retrieve his basic info from Facebook.
          FB.api('/me', function(meResponse) {

            // Use this info to find an existing account for the user (or to
            // create a new one) and assign it to App.currentUser.
            var existingUserRequest = App.User.find({ fb_id: meResponse.id });
            existingUserRequest.on('didLoad', function() {
              var existingUserDetails = this.get('content')[0];
              if (existingUserDetails) {
                var existingUser = App.User.find(existingUserDetails.id);
                existingUser.set('name', meResponse.name);
                existingUser.set('gender', meResponse.gender);
                existingUser.set('timezone', meResponse.timezone);
                existingUser.set('fbUsername', meResponse.username);
                existingUser.set('fbAccessToken', accessToken);
                existingUser.on('didUpdate', function() {
                  App.set('currentUser', App.User.find(existingUser.id));
                });
              } else {
                var newUser = App.User.createRecord({
                  name: meResponse.name,
                  email: null,
                  gender: meResponse.gender,
                  timezone: meResponse.timezone,
                  fbUsername: meResponse.username,
                  fbAccessToken: accessToken,
                  fbId: meResponse.id
                });
                newUser.on('didCreate', function() {
                  App.set('currentUser', this);
                });
              }
              App.store.commit();
            });
          });
        }
      }, scopeObj);
    }
  }
});