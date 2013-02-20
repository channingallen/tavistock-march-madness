App.helpers.facebook = {

  checkLogin: function() {

    // Ensure the (correct) user is logged-in and authenticated.
    var currentUser = App.get('currentUser');
    if (!currentUser) return;
    FB.getLoginStatus(function(response) {
      if (response.status != 'connected') return;
      if (!response.userID) return;
      if (response.userID != currentUser.get('fb_id')) return;

      // Update the user in our DB and in our front-end data with the most
      // recent data from the Graph API.
      var accessToken = response.accessToken;
      FB.api('/me', function(meResponse) {
        App.helpers.facebook.updateUserFromMeResponse(currentUser, accessToken,
                                                      meResponse);
      });
    });
  },

  updateUserFromMeResponse: function(user, accessToken, meResponse) {
    user.set('name', meResponse.name);
    user.set('gender', meResponse.gender);
    user.set('timezone', meResponse.timezone);
    user.set('fbUsername', meResponse.username);
    user.set('fbAccessToken', accessToken);
    user.on('didUpdate', function() {
      App.set('currentUser', App.User.find(user.get('id')));
    });
    App.store.commit();
  },

  promptForAuthorization: function() {

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
              App.helpers.facebook.updateUserFromMeResponse(existingUser,
                                                            accessToken,
                                                            meResponse);
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
              App.store.commit();
            }
          });
        });
      }
    }, scopeObj);
  }
};